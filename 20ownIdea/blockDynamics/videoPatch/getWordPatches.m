function videoPatchAll = getWordPatches(featureIndexForVideo, all_train_files, datasetName, dataFolder, fovea, params)

videoPatchAll = [];
i = 1;
while i <= size(featureIndexForVideo, 1)
    videoIndex = featureIndexForVideo(i, 1);
    M = loadingData(datasetName, dataFolder, all_train_files{videoIndex}, fovea);
    videoSample = transact_dense_samp_raw(M, fovea, params);
    sameTypeIndexInSameVideo = find(featureIndexForVideo(:, 1) == videoIndex);
    for j = 1 : length(sameTypeIndexInSameVideo)
        writenum(sameTypeIndexInSameVideo(j));
        colIndex = featureIndexForVideo(sameTypeIndexInSameVideo(j), 2);
        videoPatch = reshape(videoSample(:, colIndex), [fovea.spatial_size ...
            fovea.spatial_size fovea.temporal_size]);
        videoPatchAll = cat(1, videoPatchAll, {videoPatch});
    end
    i = sameTypeIndexInSameVideo(end) + 1;
end