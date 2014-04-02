function [labIm, nProps] = neuronMarker(labIm, nProps, dispIm)
% [labIm, nProps] = neuronMarker(labIm, nProps)
% updates given labeled image and neuron props based on user input

figure, imshow(dispIm)
maskh = alphamask(im2bw(labIm, 1), [1 0 0]);

[X, Y] = meshgrid(1:size(labIm, 2), 1:size(labIm, 1));

% Get user input
[xInd, yInd, inputs] = ginput;
xInd = round(xInd);
yInd = round(yInd);

% Process input
processInput();


function processInput()
    coordsToAdd = inputs == 1;
    coordsToRemove = inputs == 3;
    addNeurons(xInd(coordsToAdd), yInd(coordsToAdd));
    removeNeurons(xInd(coordsToRemove), yInd(coordsToRemove));


function addNeurons(x, y)
    % Calculate new neuron's props, app to nProps
    nRad = 15;
    newNeuron.Area = pi*nRad^2;
    newNeuron.Centroid = [x, y];
    newNeuron.BoundingBox = [[x, y] - nRad, nRad*2, nRad*2];
    nKey = max(labIm(:)) + 1;
    nProps(nKey) = newNeuron;
    % draw a circle on labIm
    circleInds = nRad^2 >= (X - x).^2 + (Y - y).^2;
    labIm(circleInds) = nKey;


function removeNeuron(x, y)
    % nr, nc
    nKey = labIm(y, x);
    % remove key, update labIm
    if nProps.isKey(nKey)
        nProps.remove(nKey)
        labIm(labIm == nKey) = 0;
    end