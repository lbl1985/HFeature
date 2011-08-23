classdef featureIndex
    %FEATUREINDEX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        croppedVideoObj
        featureMatrix
        
        
        numFeaturePerRow
        numFeaturePerCol
        numFeaturePerFrame
        numOfSlides
        nFeature
    end
    
    methods
        function obj = featureIndex(inputCroppedVideoObj, inputFeatureMatrix)
            assert(isobject(inputCroppedVideoObj), '1st input should be croppedVideoObject');
            
            obj.croppedVideoObj = inputCroppedVideoObj;
            obj.featureMatrix = inputFeatureMatrix;
            
            obj.numFeaturePerRow = inputCroppedVideoObj.siz(1) / inputCroppedVideoObj.spatial_size;
            obj.numFeaturePerCol = inputCroppedVideoObj.siz(2) / inputCroppedVideoObj.spatial_size;
            obj.numFeaturePerFrame = inputCroppedVideoObj.siz(1) * inputCroppedVideoObj.siz(2) / (inputCroppedVideoObj.spatial_size^2);
            obj.numOfSlides = inputCroppedVideoObj.siz(end) / inputCroppedVideoObj.temporal_size;
            obj.nFeature = obj.numFeaturePerFrame * obj.numOfSlides;
        end        
    end
    
end

