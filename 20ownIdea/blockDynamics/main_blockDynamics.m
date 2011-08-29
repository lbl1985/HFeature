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
        dataFolder = fullfile(baseFolder, 'AVIClips05/');
        dataSavingFolder = fullfile(baseFolder, 'Results', 'hw2');
    case 'kth'
        load(fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData', 'visTrainMedianData_all.mat'));
        load(fullfile(baseFolder, '15experiments', 'kth', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));
        dataFolder = fullfile(baseFolder, '15experiments', 'kth', 'kth_selectFrames/');
        dataSavingFolder = fullfile(baseFolder, 'Results', 'kth');
end

fovea = getFovea(isanetwork);

% featureOrderFileIndex = featureIndex2FileIndex(train_indices{1});
numWord = max(train_label_all{1}{1});

for wordId = 25
    index = find(train_label_all{1}{1} == wordId);
    featureIndexForVideo = getFeatureIndexForVideo(index, train_indices{1});
    wordPatches = getWordPatches(featureIndexForVideo, all_train_files, ...
        datasetName, dataFolder, fovea, params);
    save(fullfile(dataSavingFolder, ['videoPatchAll_Word' num2str(wordId) ...
    '.mat']), 'wordPatches');
end

inWordId = 25;

params_subspace.subspaceDim_pca = 30;
params_subspace.subspaceDim_hankel = 1;
params_subspace.hankelWindowSize = 4;
params_subspace.fovea = fovea;

patchSubspaces(inWordId, params_subspace);