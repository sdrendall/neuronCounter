function [labIm, neuronProps] = findNeurons(im)
    %% [labIm, neuronProps] = findNeurons(im)
    % Attempts to find neurons in an fish section
    % Returns a labled image, 'labIm' of size im, where each detected neuron 
    %  is labled with a distinct value
    % Returns a hashmap neuronProps, with a key value pair for each labeled object 
    % in labIm.  Values include the output of regionprops() 'basic' and major/minor axis length


    % Extract green layer
    green = double(im(:,:,2));

    % Log -- probably a better way to accentuate image
    logIm = mat2gray(log2(green));

    figure,imshow(logIm, [])
    title('after log')
    pause

    % segment -- should reveal section
    filtIm = imfilter(logIm, fspecial('disk', 10));
    section = im2bw(filtIm, graythresh(filtIm));
    
    figure,imshow(filtIm, [])
    title('after filtering')
    pause

    figure,imshow(section, [])
    title('section')
    pause

    % segment -- for cells (or a big mess if no cells are present)
    cells = im2bw(filtIm, graythresh(filtIm(section)));

    figure,imshow(cells, [])
    title('after segmentation')
    pause

    % label cells and get properties
    cells = bwlabel(cells);
    propertiesToStore = {'Area', 'Centroid', 'BoundingBox', 'MinorAxisLength', 'MajorAxisLength'};
    cellProps = regionprops(cells, propertiesToStore);

    % find cells that are too large or misshapen
    % thresholds here are determined somewhat arbitrarily
    imArea = size(green, 1) * size(green, 2);
    tooLarge = [cellProps(:).Area] >= imArea/5;
    axisRatio = [cellProps(:).MajorAxisLength]./[cellProps(:).MinorAxisLength];
    tooLong = axisRatio >= 5;
    boundingArea = [cellProps(:).MajorAxisLength].*[cellProps(:).MinorAxisLength];
    percentFilled = [cellProps(:).Area]./boundingArea;
    %tooSparse = percentFilled <= 20;
    tooSparse = logical(zeros(size(tooLong)));

    % Union disqualifiers
    disqualifiedCells = tooLarge | tooLong | tooSparse;

    figure, imshow(cells, [])
    title('before removeObjects')
    pause

    % Remove cells
    cells = removeObjects(cells, cellProps, disqualifiedCells);

    figure, imshow(cells, [])
    title('before watershed')
    pause

    % Watershed cells
    labIm = watershedCells(filtIm, logical(im2bw(cells, 0)));

    figure,imshow(labIm, [])
    title('after watershed')
    pause

    % Store neuron data in a hashmap
    neuronProps = containers.Map('KeyType', 'double', 'ValueType', 'any');
    tmpProps = regionprops(labIm, propertiesToStore);
    for obj = 1:max(labIm(:))
        neuronProps(obj) = tmpProps(obj);
    end

    % Remove non neuron objects
    %disqualifiedObjects = distinguishNonNeurons(neuronProps);
    %[labIm, neuronProps] = removeObjects(labIm, neuronProps, disqualifiedObjects);


function [labIm, objData] = removeObjects(labIm, objData, indsToRemove)
    % Removes objects from objData and sets corresponding pixels in labIm to 0
    % for each entry in objData

    % Get keys/label values - discard 0
    objKeys = unique(labIm(:));
    objKeys(objKeys == 0) = [];
    keysToRemove = objKeys(indsToRemove)';

    % remove entrys from objData - supports structs and hashmaps
    if strcmpi(class(objData), 'struct')
        objData(indsToRemove) = [];
    elseif strcmpi(class(objData), 'containers.Map')
        for key = keysToRemove
            objData.remove(key);
        end
    else
        warning(['Cannot remove properties from container of type: ', class(objData)])
    end

    % set labIm values to 0
    valsToDiscard = logical(zeros(size(labIm)));
    for value = keysToRemove
        newValsToDiscard = labIm == value;
        valsToDiscard = valsToDiscard | newValsToDiscard;
    end
    labIm(valsToDiscard) = 0;


function wsIm = watershedCells(im, logMask)
    toWs = -im;
    toWs(~logMask) = -Inf;
    wsIm = watershed(toWs);


function nonNeuronInds = distinguishNonNeurons(neuronProps)
    nonNeuronInds = logical(zeros(size(neuronProps)));