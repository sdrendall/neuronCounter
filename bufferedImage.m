classdef bufferedImage < handle 
    properties (SetAccess = private)
        im
    end
    properties
        labIm
        dataObj
    end

    methods
        function obj = bufferedImage(rootObj);
            obj.dataObj = rootObj;
            obj.im = mat2gray(imread(rootObj.path));
        end
    end
end