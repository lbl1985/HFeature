classdef coverFlowClassLabel < coverflow.coverFlowOrig
    %COVERFLOWCLASSLABEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        classLabels
        textLocationBatch
        numFeaturePerRow;
        numFeaturePerCol;
        numFeaturePerFrame;
        numOfSlides;
        nFeature;
        
        colorBoard = uint8(round(varycolor(3000) * 255));
        displayOffsite = 5;
        
        savedResultFolder = fullfile(getProjectBaseFolder, 'Results', 'tmpResult');
        savedVideoName = fullfile(getProjectBaseFolder, 'Results', 'coverFlowClassLabelTmpVideo.avi');
    end
    
    methods     %initialization function
        function obj = coverFlowClassLabel(croppedVideoObj, inputClassLabels)
            assert(isobject(croppedVideoObj), 'croppedVideoObj has to be object');
            
            obj = obj@coverflow.coverFlowOrig(croppedVideoObj);
            obj.classLabels = inputClassLabels;
            
            obj.numFeaturePerRow = croppedVideoObj.siz(1) / croppedVideoObj.spatial_size;
            obj.numFeaturePerCol = croppedVideoObj.siz(2) / croppedVideoObj.spatial_size;
            obj.numFeaturePerFrame = croppedVideoObj.siz(1) * croppedVideoObj.siz(2) / (croppedVideoObj.spatial_size^2);
            obj.numOfSlides = croppedVideoObj.siz(end) / croppedVideoObj.temporal_size;
            obj.nFeature = obj.numFeaturePerFrame * obj.numOfSlides;
            
            assert(obj.nFeature == length(obj.classLabels), ...
                'nFeature Calculated is not equal to Experimental Results');
            
        end        
    end
    
    methods     % Ability Functions
        function playConsecutiveWholeVideoCoverFlow(obj)
            obj = obj.renewSavedVideoName();
            tmpCoverFlowObj = obj.coverFlowPrepare();
            tmpCoverFlowObj = tmpCoverFlowObj.setFrameRangeAll();
            tmpCoverFlowObj.playConsecutiveCoverFlow();
        end
        
        function playKeyFramesCoverFlow(obj)
            obj = obj.renewSavedVideoName();
            tmpCoverFlowObj = obj.coverFlowPrepare();
            keyFrames = obj.getKeyFrames();
            tmpCoverFlowObj.framesRange = keyFrames;
            tmpCoverFlowObj.playConsecutiveCoverFlow();
        end
        
        function saveKeyFramesAsFig(obj)
            obj = obj.renewSavedVideoName();
            tmpCoverFlowObj = obj.coverFlowPrepare();
            tmpCoverFlowObj.figHandel = figure();
            keyFrames = obj.getKeyFrames();            
            for i = 1 : length(keyFrames) - tmpCoverFlowObj.param.stackSize + 1
                tmpCoverFlowObj = tmpCoverFlowObj.setFrames(keyFrames(i : ...
                    i + tmpCoverFlowObj.param.stackSize - 1));
                if isobject(tmpCoverFlowObj.data)
                    tmpCoverFlowObj.coverFlowCore(tmpCoverFlowObj.data.Data);
                else
                    tmpCoverFlowObj.coverFlowCore(tmpCoverFlowObj.data);
                end
                saveas(gcf, fullfile(obj.savedResultFolder, [obj.data.videoName 'keyFramesFrom_' ...
                    num2str(keyFrames(i)) '.fig']));
            end
        end
    end
    
    methods     % Figure based class label. The saved generated images
        function visualizeOnImage(obj)
            for t = 1 : obj.data.nFrame
                obj = obj.visualizationOnImageCore1(t);
%                 title(['Frame ' num2str(t)]);
            end
        end
        
        function saveVisualizedAsVideo(obj)
            obj = obj.renewSavedVideoName();
            s1 = video.videoSaver(obj.savedVideoName, 11);            
            for t = 1 : obj.data.nFrame
                obj = obj.visualizationOnImageCore1(t);
                title(['Frame ' num2str(t)]);
                s1.fig = obj.figHandel;
                s1.saveCore();
            end
            s1.saveClose();
        end
        
        function obj = visualizationOnImageCore1(obj, t)
            if t == 1, obj.figHandel = figure();
            else figure(obj.figHandel); end
            
            featureIndex = obj.featureIndexOnThisFrame(t);
            
            if obj.data.ndim == 4
                img = obj.transactColor(obj.data.Data(:, :, :, t), featureIndex);
                imshow(img);
            else
                img = obj.transactColor(obj.data.Data(:, :, t), featureIndex);
                imshow(img);
            end
            
            for j = featureIndex(1) : featureIndex(end)
                location = obj.calculateFeatureLocation(j);
                try
                    text(location(2), location(1), num2str(obj.classLabels(j)), ...
                        'FontSize', 6);
                catch ME
                    display(['Frame ' num2str(t)]);
                    dispMEstack(ME.stack);
                end
            end
            title(['Frame ' num2str(t)]);
            pause(1/11);
        end
    end
    
    methods    % Utility functions
        function tmpCoverFlowObj = coverFlowPrepare(obj)
            % only read the data, but don't return the obj 
            % Because this class is not handle but value, therefore, it
            % should not have efforts on the other functions or interfaces
            obj = obj.renewSavedVideoName();
            if ~exist(obj.savedVideoName, 'file')
                obj.saveVisualizedAsVideo();
            end
            tmpVisualizedVar = movie2var(obj.savedVideoName, 0, 1);
            tmpMovieObj = video.videoVar(tmpVisualizedVar);
            tmpCoverFlowObj = coverflow.coverFlowOrig(tmpMovieObj);
        end
        
        function obj = renewSavedVideoName(obj)
            if ~isempty(obj.data.videoName)
                obj = obj.renewSavedResultFolder();
                obj.savedVideoName = fullfile(obj.savedResultFolder, ...
                    [obj.data.videoName '_coverFlowClassLabelVideo.avi']);
            end            
        end
        
        function obj = renewSavedResultFolder(obj)
            if ~isempty(obj.data.videoName)
                obj.savedResultFolder = fullfile(getProjectBaseFolder, ...
                    'Results', obj.data.videoName);
                if ~exist(obj.savedResultFolder, 'dir')
                    mkdir(obj.savedResultFolder);
                end
            end
        end
        
        function image = transactColor(obj, image, featureIndex)
            spatial_size = obj.data.spatial_size;
            for i = featureIndex(1) : featureIndex(end)
                typeId = obj.classLabels(i);
                color = reshape(obj.colorBoard(typeId, :), [1 1 3]);
                colorPatch = repmat(color, obj.data.spatial_size, obj.data.spatial_size);
                
                [rowIndex colIndex] = obj.calculateRowColIndex(i);
                image((rowIndex-1) * spatial_size + 1 : rowIndex * spatial_size, ...
                    (colIndex - 1) * spatial_size + 1: colIndex * spatial_size, :) = ...
                    image((rowIndex-1) * spatial_size + 1 : rowIndex * spatial_size, ...
                    (colIndex - 1) * spatial_size + 1: colIndex * spatial_size, :) + colorPatch;                
            end
        end
        
        function textLocation = calculateFeatureLocation(obj, i)
            [rowIndex colIndex] = obj.calculateRowColIndex(i);
            
            textLocation = zeros(1, 2);
            textLocation(1) = (rowIndex - 1) * obj.data.spatial_size + obj.displayOffsite;
            textLocation(2) = (colIndex - 1) * obj.data.spatial_size + obj.displayOffsite;
        end
        
        function [rowIndex colIndex] = calculateRowColIndex(obj, i)
            slideIndex = mod(i , obj.numFeaturePerFrame);
            if slideIndex == 0, slideIndex = obj.numFeaturePerFrame; end
            rowIndex = mod(slideIndex , obj.numFeaturePerRow);
            if rowIndex == 0, rowIndex = obj.numFeaturePerRow; end
            colIndex = ceil(slideIndex / obj.numFeaturePerRow);
        end
        
        function featureIndex = featureIndexOnThisFrame(obj, t)
            if t == obj.data.nFrame, t = obj.data.nFrame - 1; end
            slideIndex = floor(t/obj.data.temporal_size);
            featureIndex = slideIndex * obj.numFeaturePerFrame + 1 : ...
                (slideIndex + 1) * obj.numFeaturePerFrame;
        end
        
        function keyFrames = getKeyFrames(obj)
            keyFrames = (1 : obj.data.nFrame / obj.data.temporal_size);
            keyFrames = keyFrames - 1;
            keyFrames = keyFrames * obj.data.temporal_size + 1;
        end
    end
end

