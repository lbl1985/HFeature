function subspaceVis(isanetwork)
fovea.spatio = isanetwork{1}.spatial_size;
fovea.temporal = isanetwork{1}.temporal_size;

visRealWork(isanetwork{1}.W, fovea);
% visRealWork(isanetwork{1}.V, fovea);
end

function visRealWork(data, fovea)
nFeature = size(data, 1);
subplotVis(data, nFeature, fovea);
end

function subplotVis(data, nFeature, fovea)
[nRow nCol] = plotPre(fovea);
for i = 1 : nFeature
    tempData = data(i, :);
    tempData = reshape(tempData, [fovea.spatio fovea.spatio fovea.temporal]);    
    h = figure(1); set(h, 'Name', ['subspace ' num2str(i)]);
    for j = 1 : fovea.temporal
        subplot(nRow, nCol, j); imshow(tempData(:, :, j));
        title(['time ' num2str(j)]);
    end    
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