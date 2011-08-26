clear
baseFolder = getProjectBaseFolder();
datasetName = 'hw2';
switch datasetName
    case 'hw2'
        % This is using HW2 training data
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'all_train_files.mat'));
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'save_train_indices.mat'));
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'train_label_all.mat'));
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'trainKmeans_excpt_Xtrain_raw.mat'));
        load(fullfile(baseFolder, '10digging', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));
    case 'kth'
end

fovea = getFovea(isanetwork);

% featureOrderFileIndex = featureIndex2FileIndex(train_indices{1});
numWord = max(train_label_all{1}{1});

for wordId = 25
    index = find(train_label_all{1}{1} == wordId);
    featureIndexForVideo = getFeatureIndexForVideo(index, train_indices{1});
    videoPatchAll = [];
    while i ~= size(featureIndexForVideo, 1)
%     for i = 1 : size(featureIndexForVideo, 1)
        M = loadingData(datasetName, folder, all_train_files{i});
        videoSample = transact_dense_samp_raw(M, fovea, params);
        sameTypeIndexInSameVideo = find(featureIndexForVideo(:, 1) == featureIndexForVideo(i));
        for j = 1 : length(sameTypeIndexInSameVideo)
            videoPatch = cat(1, videoPatch, {reshape(videoSample, [fovea.spatial_size ...
                fovea.spatial_size fovea.temporal_size])});
        end
        i = j;        
    end
end