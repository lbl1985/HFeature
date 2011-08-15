classdef coverFlow
    %COVERFLOW Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        data
        param = struct('cflowwindow', struct('NumberTitle', 'off', 'Name', ...
            'Cover Flow:Skin Detection'), 'cflowproperties', struct('EdgeColor', ...
            'none', 'FaceColor', 'texturemap', 'LineStyle', 'none'), ...
            'stackSize', 5);
        frames = 1 : 5;
        figHandel;
    end
    
    methods
        function obj = coverFlow(inputData)
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
        
    end
    
end

