classdef fishImage < handle
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
        totalNeuronCount = 0;
        data
        bufferPos = 0;
    end

    methods
        function obj = fishImage(file, containingDirPath)
            % Add dir() created fields to the obj
            fileFields = fieldnames(file);
            for i = 1:length(fileFields)
                setfield(obj, fileFields{i}, getfield(file, fileFields{i}));
            end
            obj

            % Get path and filetype
            obj.path = fullfile(containingDirPath, file.name);
            [obj.containingDirPath, ~, obj.filetype] = fileparts(obj.path);
            [~, obj.containingDirName] = fileparts(obj.containingDirPath);
        end

        function percentExpressing = percentNeuronsExpressing(self)
            percentExpressing = double(self.neurons.Count)/self.totalNeuronCount * 100;
        end

    end
end