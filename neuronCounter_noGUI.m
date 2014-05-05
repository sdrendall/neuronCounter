function neuronCounter_noGUI
%% Script to analyze a set of FISH images without using the GUI
% Ideally this can be run on Orchestra

    %% Find Images
    images = searchForFISHImages()
    % Create a randomized vector of inds so that images
    bufferInds = randperm(length(images));

    % Load Images
    imageBuffer = [];
    for i = 1:length(bufferInds)
        imageBuffer = [imageBuffer, bufferedImage(images(bufferInds(i)))];
        imageBuffer(i).dataObj.bufferPos = i;
    end

    % Find Neurons
    analyzeImagesInBuffer()

    % Save to .mat file
    save('~/analyzedImages', 'imageBuffer')


    function analyzeImagesInBuffer
    
        % Create some containers, to allow for parallelization
        labIms = cell(size(imageBuffer));
        neurons = labIms;
        totalNeuronCounts = zeros(size(imageBuffer));
    
        % Analyze buffered images
        parfor i = 1:length(imageBuffer)
            [labIms{i}, neurons{i}] = findNeurons(imageBuffer(i).im);
            totalNeuronCounts(i) = estimateTotalNeuronsFromDapi(imageBuffer(i).im);
        end
    
        for i = 1:length(imageBuffer)
            % Store values in data objects
            imageBuffer(i).labIm = labIms{i};
            imageBuffer(i).dataObj.neurons = neurons{i};
            imageBuffer(i).dataObj.totalNeuronCount = totalNeuronCounts(i);
    
            % Spit out some values
            disp(['totalNeuronCount: ', num2str(imageBuffer(i).dataObj.totalNeuronCount)])
            disp(['% expressing neurons: ', num2str(imageBuffer(i).dataObj.percentNeuronsExpressing())])
            disp('------------------------------------')
        end