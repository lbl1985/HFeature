classdef bases
    % Value type of classes. 
    
    properties
        isanetwork;  
        projectBaseFolder = getProjectBaseFolder();
        savingFolder = fullfile(getProjectBaseFolder(), 'Results', ...
                'visualizationResults', 'subspaces');
        recordInfo = struct('isRecord', 0, 'saveName', ...
             fullfile(getProjectBaseFolder(), 'Results', ...
                'visualizationResults', 'subspaces', 'trial1.avi'));
    end
    
    properties (Dependent = true, SetAccess = private)
        fovea;
        nRow; 
        nCol;
        nFeature;        
    end
    
    properties (SetAccess = public)
        plotVariableName = 'W';
    end
    
    methods  
        function obj = bases(inputNetwork)
            obj.isanetwork = inputNetwork;
        end
    end
    
    methods % Core Ability Functions                
        function plot(obj)
            command = ['data = obj.isanetwork{1}.' obj.plotVariableName ';'];
            eval(command);
            subspacePlotCore(obj, data);
        end
    end
    
    methods % Supporting Functions         
        
        function fovea = get.fovea(obj)
            fovea.spatio = obj.isanetwork{1}.spatial_size;
            fovea.temporal = obj.isanetwork{1}.temporal_size;
        end
        
        function nRow = get.nRow(obj)
            candidateNumber = (2 : floor(sqrt(obj.fovea.temporal)));
            for i = length(candidateNumber) : -1 :1
                if ~rem(obj.fovea.temporal, candidateNumber(i))
                    nRow = candidateNumber(i);
                    break;
                end
            end
        end
        
        function nCol = get.nCol(obj)
            nCol = obj.fovea.temporal / obj.nRow;
        end
        
        function nFeature = get.nFeature(obj)
            nFeature = size(obj.isanetwork{1}.W, 1);
        end

        function obj = setRecordInfo(obj, inputRecordInfo)
            if iscell(inputRecordInfo)
                obj.recordInfo.isRecord = inputRecordInfo{1};
                obj.recordInfo.saveName = fullfile(obj.savingFolder, inputRecordInfo{2});
            else if isnumeric(inputRecordInfo)
                    obj.recordInfo.isRecord = inputRecordInfo;
                else if ischar(inputRecordInfo)
                        obj.recordInfo.saveName = fullfile(obj.savingFolder, inputRecordInfo);
                    end
                end
            end
        end
        
        function obj = setSavingFolder(obj, inputSavingFolder)
            obj.savingFolder = inputSavingFolder;
        end
    end
end

