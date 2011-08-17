classdef croppedVideoVar < video.videoVar
    %Crop the video data according to specified spatial_size parameter.
    
    properties
        spatial_size
        temporal_size
        croppedVideo
        croppedSiz
    end
    
    methods
        function obj = croppedVideoVar(inputData, input_spatial_size, input_temporal_size)
            obj = obj@video.videoVar(inputData);
            obj.spatial_size = input_spatial_size;
            obj.temporal_size = input_temporal_size;
            obj.croppedVideo = uint8(zeros(floor(size(inputData, 1) / input_spatial_size) ...
                * input_spatial_size, floor(size(inputData, 2) / input_spatial_size) ...
                * input_spatial_size, size(inputData, 3), size(inputData, 4)));
            obj.croppedSiz = size(obj.croppedVideo);
        end        
    end
    
    methods
        function cropVideoForFeatureDetection(obj)
            obj = obj.cropVideoForFeatureDetectionInTime();
            if obj.ndim == 3
                % do operation for gray images
                for t = 1 : obj.croppedSiz(end)
                    obj.croppedVideo(:, :, t) = obj.Data(1 : floor(obj.siz(1)/obj.spatial_size) * obj.spatial_size, ...
                        1 : floor(obj.siz(2) / obj.spatial_size) * obj.spatial_size, t);
                end
            elseif obj.ndim == 4
                % do operation for color images
                for t = 1 : obj.croppedSiz(end)
                    obj.croppedVideo(:, :, :, t) = obj.Data(1 : floor(obj.siz(1)/obj.spatial_size) * obj.spatial_size, ...
                        1 : floor(obj.siz(2) / obj.spatial_size) * obj.spatial_size, :, t);
                end
            end
                
        end
    end
    
    methods % Utility Function
        function obj = cropVideoForFeatureDetectionInTime(obj)
            obj.croppedSiz(end) = floor(obj.nFrame/obj.temporal_size) * obj.temporal_size;
            if obj.ndim == 3
                obj.croppedVideo = obj.croppedVideo(:, :, 1 : obj.croppedSiz(end));
            else
                obj.croppedVideo = obj.croppedVideo(:, :, :, 1 : obj.croppedSiz(end));
            end
        end
    end
end

