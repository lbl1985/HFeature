classdef featureIndex
    %FEATUREINDEX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        videoSize
%         featureMatrix
        
        
        numFeaturePerRow
        numFeaturePerCol
        numFeaturePerFrame
        numOfSlides
        nFeature
    end
    
    methods
        function obj = featureIndex(inputVideoSize)
            assert(isobject(inputVideoSize), '1st input should be croppedVideoObject');
            
            obj.videoSize = inputCroppedVideoObj;
            
            obj.numFeaturePerRow = inputVideoSize.siz(1) / inputVideoSize.spatial_size;
            obj.numFeaturePerCol = inputVideoSize.siz(2) / inputVideoSize.spatial_size;
            obj.numFeaturePerFrame = inputVideoSize.siz(1) * inputVideoSize.siz(2) / (inputVideoSize.spatial_size^2);
            obj.numOfSlides = inputVideoSize.siz(end) / inputVideoSize.temporal_size;
            obj.nFeature = obj.numFeaturePerFrame * obj.numOfSlides;
        end        
    end
    
end

