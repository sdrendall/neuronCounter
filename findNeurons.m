function [labIm, neuronProps] = findNeurons(im)
    %% [labIm, neuronProps] = findNeurons(im)
    % Attempts to find neurons in an fish section
    % Returns a labled image, 'labIm' of size im, where each detected neuron 
    %  is labled with a distinct value
    % Returns a hashmap neuronProps, with a key value pair for each labeled object 
    % in labIm.  Values include the output of regionprops() 'basic' and major/minor axis length


    % Extract green layer
    green = mat2gray(im(:,:,2));

    % Log -- probably a better way to accentuate image
    %logIm = log2(green);

    % segment -- should reveal section
    filtIm = imfilter(green, fspecial('disk', 10), 'replicate');
    section = im2bw(filtIm, graythresh(green));

    % segment -- for cells (or a big mess if no cells are present)
    cells = im2bw(filtIm, graythresh(filtIm(section)));

    % A bit of morphological preprocessing 
    % taken directly from hunter elliot's spot detector
    cells = bwmorph(cells, 'clean'); % remove isolated pixels
    cells = bwmorph(cells, 'fill'); % fill isolated holes
    cells = bwmorph(cells, 'thicken');
    cells = bwmorph(cells, 'spur'); % remove single pixels 8-attached to clusters
    cells = bwmorph(cells, 'spur');
    cells = bwmorph(cells, 'clean');

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

    % Remove cells
    cells = removeObjects(cells, cellProps, disqualifiedCells);
    cells = cells > 0;

    % Watershed cells
    labIm = watershedCells(filtIm, cells);

    % Store neuron data in a hashmap
    neuronProps = containers.Map('KeyType', 'double', 'ValueType', 'any');
    tmpProps = regionprops(labIm, propertiesToStore);
    tmpProps = calculateAvgIntensityAndStdForEachCell(green, labIm, tmpProps);

    for obj = 1:max(labIm(:))
        neuronProps(obj) = tmpProps(obj);
    end

    % Get some information about the non neuron part of the section
    green = mat2gray(green);    
    section(section & cells) = 0;
    labSection = bwlabel(section);
    sectionProps = regionprops(labSection);
    sectionProps = calculateAvgIntensityAndStdForEachCell(green, labSection, sectionProps);
    sectionProps = sectionProps(find([sectionProps(:).Area] == max([sectionProps(:).Area])));

    % Remove non neuron objects
    disqualifiedObjects = distinguishNonNeurons(neuronProps, sectionProps);
    [labIm, neuronProps] = removeObjects(labIm, neuronProps, disqualifiedObjects);


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


function propsOut = calculateAvgIntensityAndStdForEachCell(im, labIm, propsIn)
    im = mat2gray(im);
    propsOut = appendFields(propsIn, {'avgIntensity', 'std'});

    for i = 1:length(propsOut)
        propsOut(i).avgIntensity = mean(im(labIm == i));
        propsOut(i).std = std(im(labIm == i));
    end


function nonNeuronInds = distinguishNonNeurons(neuronProps, sectionProps)
    % Extract values
    values = neuronProps.values();
    areas = zeros(size(values));
    avgIntensities = areas;
    for i = 1:length(values)
        areas(i) = values{i}.Area;
        avgIntensities(i) = values{i}.avgIntensity;
    end

    % Determine a threshold based on the section's (discluding cells) mean intensity and std
    % This is sort of arbitrary, Someday i'll use a t test or something here
    intensityThreshold = sectionProps.avgIntensity + 1.5*sectionProps.std;

    % Tests
    tooBig = areas > 3500;
    tooSmall = areas < 90;
    tooWeak = avgIntensities < intensityThreshold;

    % Union
    nonNeuronInds = tooBig | tooSmall | tooWeak;