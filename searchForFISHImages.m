function imageData = searchForFISHImages(startPath, filetype)
%% imageData = searchForFISHimageData(startPath, filetype)
% 
% Recursively searches for imageData, starting at startPath
% Returns a structure 'imageData' that contains the image's filename (name), path,
% and its containing directory's path
%
% returns a structure imageData that includes the output of the dir function
% plus:
%   path: path pointint to the image file
%   originalDir: the path of the directory containing the image file
%   originalDirName: the name of the directory containing the image file

% test inputs
% make filetype tif by default
if ~exist('filetype', 'var')
    filetype = {'.tif', '.jpg', '.png', '.tiff'};
else
    % check for dotz
    if ~strcmp(filetype(1), '.')
        filetype = ['.', filetype];
    end
end

if ~exist('startPath', 'var')
    startPath = uigetdir('~', 'Specify start path for search');
    % Recursively handle cells
elseif iscell(startPath)
    imageData = [];
    for iPath = 1:length(startPath)
        incomingImages = searchForFISHImages(startPath{iPath});
        imageData = [imageData, incomingImages];
    end
    return
elseif ~ischar(startPath)
    error('searchForFISHImages:InvalidInput',['Input "', startPath, 'is of invalid class: ', class(startPath)])
end


%----------------Function Main----------------%
startPath = fullfile(startPath);

% Search current directory
cdContents = dirNoDot(startPath);
if length(cdContents) == 0
    imageData = [];
    return
end

% Create fishImageData objects for files with appropriate extensions
for i = 1:length(cdContents)
    [~, ~, ext] = fileparts(cdContents(i).name);
    if any(strcmpi(ext, filetype))
        if ~exist('imageData', 'var') || isempty(imageData)
            imageData = fishImageData(cdContents(i), startPath);
        else
            imageData(end + 1) = fishImageData(cdContents(i), startPath);
        end
    end
end

% Get directories
directories = cdContents([cdContents(:).isdir]);

% Recursively search directories
for i = 1:length(directories)
    if isempty(imageData)
        imageData = searchForFISHImages(fullfile(startPath, directories(i).name), filetype);
    else
        incomingImageData = searchForFISHImages(fullfile(startPath, directories(i).name), filetype);
        if ~isempty(incomingImageData)
            imageData = [imageData, incomingImageData];
        end
    end
end