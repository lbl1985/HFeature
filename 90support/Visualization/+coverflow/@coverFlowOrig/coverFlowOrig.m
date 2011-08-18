classdef coverFlowOrig
    %COVERFLOW Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        data
        param = struct('cflowwindow', struct('NumberTitle', 'off', 'Name', ...
            'Cover Flow:Skin Detection'), 'cflowproperties', struct('EdgeColor', ...
            'none', 'FaceColor', 'texturemap', 'LineStyle', 'none'), ...
            'stackSize', 5);
        framesRange = (1:  10);
        frames = 1 : 5;
        figHandel;
    end
    
    methods
        function obj = coverFlowOrig(inputData)
            obj.data = inputData;
        end
        
        function [w h] = playCoverFlow(obj)
            obj.figHandel = figure();
            if isobject(obj.data)
                [w h] = obj.coverFlowCore(obj.data.Data);
            else
                [w h] = obj.coverFlowCore(obj.data);
            end
        end
        
        function [w h] = playConsecutiveCoverFlow(obj)
            obj.figHandel = figure();
            for i = 1 : length(obj.framesRange) - obj.param.stackSize + 1;
                obj = obj.setFrames(obj.framesRange(i : i + obj.param.stackSize -1));
                if isobject(obj.data)
                    [w h] = obj.coverFlowCore(obj.data.Data);
                else
                    [w h] = obj.coverFlowCore(obj.data);
                end 
                pause(1/11);
%                 disp(['Frame ' num2str(i)]);
            end
        end
    end
    
    methods %utility functions
        function obj = setFrames(obj, specifiedFrames)
            obj.frames = specifiedFrames;
            obj.param.stackSize = length(obj.frames);
        end
        
        function obj = setFrameRangeAll(obj)
            if isobject(obj.data)
                obj.framesRange = (1 : obj.data.nFrame);
            else
                obj.framesRange = (1 : size(obj.data, ndims(obj.data)));
            end
        end
    end
    
end

