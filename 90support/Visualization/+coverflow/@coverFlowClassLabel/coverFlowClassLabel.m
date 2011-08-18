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
            assert(isobject(croppedVideoObj), 'croppedVideoObj has to be object');
            
            obj = obj@coverFlowOrig(croppedVideoObj);
            obj.classLabel = inputClassLabels;
            
            obj.numFeaturePerRow = croppedVideoObj.siz(1) / croppedVideoObj.spatial_size;
            obj.numFeaturePerFrame = croppedVideoObj.siz(1) * croppedVideoObj.siz(2) / (croppedVideoObj.spatial_size^2);
            obj.numOfSlides = croppedVideoObj.siz(end) / croppedVideoObj.temporal_size;
            obj.nFeature = obj.numFeaturePerFrame * obj.numOfSlides;
            
            assert(obj.nFeature == length(obj.classLabels), ...
                'nFeature Calculated is not equal to Experimental Results');
            
            obj.frameRange = 1 : 10;
        end        
    end
    
    methods     % Ability Functions
        function [w h] = playConsecutiveCoverFlow(obj)
            obj.figHandel = figure();
            % frameRange is the showing frames indicator.
            for i = obj.frameRange(1) : obj.frameRange(end - obj.param.stackSize + 1)
                obj = obj.setFrames(obj.frameRange(i) : obj.frameRange(i + obj.param.stackSize -1));
                if isobject(obj.data)
                    [w h] = obj.coverFlowCore(obj.data.Data);
                else
                    [w h] = obj.coverFlowCore(obj.data);
                end
                pause(1/11);
                obj.engraveText(h);
            end
        end
        
        function engraveText(obj, h)
            for i = 1 : obj.param.stackSize
                figure(h(i));   t = obj.frames(i);
                slideIndex = floor(t/ obj.data.temporal_size); 
                featureIndex = slideIndex * obj.numFeaturePerFrame + 1 : ...
                    (slideIndex + 1) * obj.numFeaturePerFarme;
                for j = featureIndex(1) : featureIndex(end)
                    location = obj.calculateFeatureLocation(j);
                    text(location(1), location(2), num2str(obj.classLabels(j)));
                end
            end                
        end
        
        function textLocation = calculateFeatureLocation(obj, i)
            slideIndex = mod(i / obj.numFeaturePerFrame);
            rowIndex = mod(slideIndex / obj.numFeaturePerRow);
            colIndex = ceil(slideIndex / obj.numFeaturePerRow);

            textLocation = zeros(1, 2);
            textLocation(1) = (rowIndex - 1) * obj.data.spatial_size + obj.displayOffsite;
            textLocation(2) = (colIndex - 1) * obj.data.spatial_size + obj.displayOffsite;
        end
    end
    
end

