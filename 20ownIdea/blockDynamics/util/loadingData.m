function M = loadingData(datasetName, dataFolder, filename, fovea)
switch datasetName
    case 'hw2'
        M = loadclip_3dm([dataFolder, filename, '.avi'], fovea.spatial_size, 0, 0); 
    case 'kth'
%         M = 
end