classdef bufferedImage < handle 
    properties (SetAccess = private)
        im
        dataObj
    end
    properties
        labIm
    end

    methods
        function obj = bufferedImage(rootObj);
            obj.dataObj = rootObj;
            obj.im = mat2gray(imread(rootObj.path));
        end
    end
end