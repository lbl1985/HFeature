function subspaceVis(isanetwork)

nFeature = size(isanetwork{1}.W, 1);
fovea.spatio = isanetwork{1}.spatial_size;
fovea.temporal = isanetwork{1}.temporal_size;
[nRow nCol] = plotPre(fovea);

for i = 1 : nFeature
    tempW = isanetwork{1}.W(i, :);
    tempW = reshape(tempW, [fovea.spatio fovea.spatio fovea.temporal]);    
    figure(i); figure('Name', ['subspace ' num2str(i)]);
    for j = 1 : fovea.temporal
        subplot(nRow, nCol, j); imshow(tempW(:, :, j));
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