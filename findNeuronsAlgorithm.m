function [labIm, neurons] = findNeuronsAlgorithm(im)
% Proxy function for a real object detection algorithm

green = im(:,:,2);

bwIm = im2bw(green, graythresh(green));

labIm = bwlabel(bwIm);

props = regionprops(labIm);

% Filter objects by area
neuronCt = 0;
nKeys = {};
for i = 1:length(props)
    if props(i).Area >= 200 && props(i).Area <= 1400
        neuronCt = neuronCt + 1;
        labIm(labIm == i) = neuronCt;
        nKeys(end + 1) = {neuronCt};
    else
        labIm(labIm == i) = 0;
    end
end

% store neuron data in a hashmap
nProps = props([props(:).Area] >= 200 & [props(:).Area] <= 1400);
neurons = containers.Map('KeyType', 'double', 'ValueType', 'any');

for i = 1:length(nProps)
    neurons(i) = nProps(i);
end