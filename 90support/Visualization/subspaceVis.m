function subspaceVis(isanetwork, isRecord)
fovea.spatio = isanetwork{1}.spatial_size;
fovea.temporal = isanetwork{1}.temporal_size;

visRealWork(isanetwork{1}.W, fovea, isRecord);
% visRealWork(isanetwork{1}.V, fovea);
end

function visRealWork(data, fovea, isRecord)
nFeature = size(data, 1);
subplotVis(data, nFeature, fovea, isRecord);
end

function subplotVis(data, nFeature, fovea, isRecord)
[nRow nCol] = plotPre(fovea);
if isRecord
    v1 = videoSaver('trial1.avi', 11);
end
for i = 1 : nFeature
    tempData = data(i, :);
    tempData = reshape(tempData, [fovea.spatio fovea.spatio fovea.temporal]);    
    h = figure(1); set(h, 'Name', ['subspace ' num2str(i)]);
    for j = 1 : fovea.temporal
        subplot(nRow, nCol, j); imshow(tempData(:, :, j));
        title(['time ' num2str(j)]);
    end   
    if isRecord
        v1.fig = h;
        v1.saveCore();
    end    
end
if isRecord
    v1.saveClose();
end
end

function [nRow nCol] = plotPre(fovea)
candidateNumber = (2 : floor(sqrt(fovea.temporal)));
for i = length(candidateNumber) : -1 :1
    if ~rem(fovea.temporal, candidateNumber(i))
        nRow = candidateNumber(i);
        break;
    end
end
nCol = fovea.temporal / nRow;
end