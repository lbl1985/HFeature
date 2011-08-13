function subspacePlotCore(obj, data)
if obj.recordInfo.isRecord
    v1 = videoSaver(obj.recordInfo.saveName, 11);
end
for i = 1 : obj.nFeature
    tempData = data(i, :);
    tempData = reshape(tempData, [obj.fovea.spatio obj.fovea.spatio obj.fovea.temporal]);    
    h = figure(1); set(h, 'Name', ['subspace ' num2str(i)]);
    for j = 1 : obj.fovea.temporal
        subplot(obj.nRow, obj.nCol, j); imshow(tempData(:, :, j));
        title(['time ' num2str(j)]);
    end   
    if obj.recordInfo.isRecord
        v1.fig = h;
        v1.saveCore();
    end    
end
if obj.recordInfo.isRecord
    v1.saveClose();
end