classdef fishImageData < handle
    properties
        path
        containingDirName
        containingDirPath
        filetype
        name
        date
        bytes
        isdir
        datenum
        neurons = containers.Map('KeyType', 'double', 'ValueType', 'any');
        data
    end

    methods
        function obj = fishImageData(file, containingDirPath)
            % Add dir() created fields to the obj
            fileFields = fieldnames(file);
            for i = 1:length(fileFields)
                setfield(obj, fileFields{i}, getfield(file, fileFields{i}));
            end

            % Get path and filetype
            obj.path = fullfile(containingDirPath, file.name);
            [obj.containingDirPath, ~, obj.filetype] = fileparts(obj.path);
            [~, obj.containingDirName] = fileparts(obj.containingDirPath);
        end
    end
end