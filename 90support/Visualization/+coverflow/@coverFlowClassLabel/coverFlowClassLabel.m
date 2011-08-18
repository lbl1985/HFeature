classdef coverFlowClassLabel < coverflow.coverFlowOrig
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
            
            obj = obj@coverflow.coverFlowOrig(croppedVideoObj);
            obj.classLabels = inputClassLabels;
            
            obj.numFeaturePerRow = croppedVideoObj.siz(1) / croppedVideoObj.spatial_size;
            obj.numFeaturePerFrame = croppedVideoObj.siz(1) * croppedVideoObj.siz(2) / (croppedVideoObj.spatial_size^2);
            obj.numOfSlides = croppedVideoObj.siz(end) / croppedVideoObj.temporal_size;
            obj.nFeature = obj.numFeaturePerFrame * obj.numOfSlides;
            
            assert(obj.nFeature == length(obj.classLabels), ...
                'nFeature Calculated is not equal to Experimental Results');
            
            
        end        
    end
    
    methods     % Ability Functions
        function [w h] = playConsecutiveCoverFlow(obj)
            obj.framesRange = 1 : 10;
            obj.figHandel = figure();
            % frameRange is the showing frames indicator.
            for i = obj.framesRange(1) : obj.framesRange(end - obj.param.stackSize + 1)
                obj = obj.setFrames(obj.framesRange(i) : obj.framesRange(i + obj.param.stackSize -1));
                if isobject(obj.data)
                    [w h] = obj.coverFlowCore(obj.data.Data);
                else
                    [w h] = obj.coverFlowCore(obj.data);
                end
                pause(1/11);
                obj.engraveText(w);
            end
        end
    end
    
    methods     % Figure based class label. The saved generated images
        function visualizeOnImage(obj)
            for t = 1 : obj.data.nFrame
                if t == 1, obj.figHandel = figure();
                else figure(obj.figHandel); end
                
                if obj.data.ndim == 4
                    imshow(obj.data.Data(:, :, :, t));
                else
                    imshow(obj.data.Data(:, :, t));
                end
                featureIndex = obj.featureIndexOnThisFrame(t);
                for j = featureIndex(1) : featureIndex(end)
                    location = obj.calculateFeatureLocation(j);
                    try
                        text(location(2), location(1), num2str(obj.classLabels(j)));
                    catch ME
                        display(['Frame ' num2str(t)]);
                        dispMEstack(ME.stack);
                    end
                end                
                title(['Frame ' num2str(t)]);
                pause(1/11);
            end
        end
    end
    
    methods    % Utility functions
        function engraveText(obj, w)
            figure(w);
            for i = 1 : obj.param.stackSize
                t = obj.frames(i);                
                featureIndex = obj.featureIndexOnThisFrame(t);
                for j = featureIndex(1) : featureIndex(end)
                    location = obj.calculateFeatureLocation(j);
                    text(location(1), location(2), num2str(obj.classLabels(j)));
                end
            end                
        end
        
        function textLocation = calculateFeatureLocation(obj, i)
            slideIndex = mod(i , obj.numFeaturePerFrame);
            if slideIndex == 0, slideIndex = obj.numFeaturePerFrame; end
            rowIndex = mod(slideIndex , obj.numFeaturePerRow);
            if rowIndex == 0, rowIndex = obj.numFeaturePerRow; end
            colIndex = ceil(slideIndex / obj.numFeaturePerRow);

            textLocation = zeros(1, 2);
            textLocation(1) = (rowIndex - 1) * obj.data.spatial_size + obj.displayOffsite;
            textLocation(2) = (colIndex - 1) * obj.data.spatial_size + obj.displayOffsite;
        end
        
        function featureIndex = featureIndexOnThisFrame(obj, t)
            if t == obj.data.nFrame, t = obj.data.nFrame - 1; end
            slideIndex = floor(t/obj.data.temporal_size);
            featureIndex = slideIndex * obj.numFeaturePerFrame + 1 : ...
                (slideIndex + 1) * obj.numFeaturePerFrame;
        end
    end
end

