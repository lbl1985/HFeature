classdef coverFlowClassLabel < coverFlowOrig
    %COVERFLOWCLASSLABEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        classLabels
        textLocationBatch
        numFeaturePerRow;
        numFeaturePerFrame;
        numOfSlides;
        nFeature;
        
        displayOffsite = 5;
    end
    
    methods     %initialization function
        function obj = coverFlowClassLabel(croppedVideoObj, inputClassLabels)
            obj = obj@coverFlowOrig(croppedVideoObj);
            obj.classLabel = inputClassLabels;
            
            obj.numFeaturePerRow = croppedVideoObj.siz(1) / croppedVideoObj.spatial_size;
            obj.numFeaturePerFrame = croppedVideoObj.siz(1) * croppedVideoObj.siz(2) / (croppedVideoObj.spatial_size^2);
            obj.numOfSlides = croppedVideoObj.siz(end) / croppedVideoObj.temporal_size;
            obj.nFeature = obj.numFeaturePerFrame * obj.numOfSlides;
            
            assert(obj.nFeature == length(obj.classLabels), ...
                'nFeature Calculated is not equal to Experimental Results');
        end        
    end
    
    methods     % Ability Functions
        function plotClassifiedLabel(obj)
            for i = 1 : obj.data.
        end
    end
    
end

