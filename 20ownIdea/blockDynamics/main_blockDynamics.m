clear
baseFolder = getProjectBaseFolder();
datasetName = 'hw2';

subspaceDim_pca = 5;
subspaceDim_hankel = 1;
hankelWindowSize = 4;
switch datasetName
    case 'hw2'
        % This is using HW2 training data
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'all_train_files.mat'));
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'save_train_indices.mat'));
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'train_label_all.mat'));
        load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'trainKmeans_excpt_Xtrain_raw.mat'));
        load(fullfile(baseFolder, '10digging', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));
        dataFolder = fullfile(baseFolder, 'AVIClips05/');
    case 'kth'
        load(fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData', 'visTrainMedianData_all.mat'));
        load(fullfile(baseFolder, '15experiments', 'kth', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));
        dataFolder = fullfile(baseFolder, '15experiments', 'kth', 'kth_selectFrames/');
end

fovea = getFovea(isanetwork);

% featureOrderFileIndex = featureIndex2FileIndex(train_indices{1});
numWord = max(train_label_all{1}{1});

for wordId = 25
    index = find(train_label_all{1}{1} == wordId);
    featureIndexForVideo = getFeatureIndexForVideo(index, train_indices{1});
    wordPatches = getWordPatches(featureIndexForVideo, all_train_files, ...
        datasetName, dataFolder, fovea, params);
    
end

wordPatchesArray = reshape(assembleCellData2Array(wordPatches, 4), ...
    fovea.spatial_size * fovea.spatial_size, []);
wordPatchesArrayRemoveDC = removeDC(wordPatchesArray);
[U S V] = pca(wordPatchesArrayRemoveDC);
wordPatchesArrayProjected = U(1:subspaceDim_pca, :) * wordPatchesArrayRemoveDC;

wordHankelPatches = cell(length(wordPatches), 1);
wordHankelSubspaces = cell(length(wordPatches), 1);

for i = 1 : length(wordPatches)
    colNum = (i - 1) * fovea.temporal_size + 1 : i * fovea.temporal_size;
    wordHankelPatches{i} = hankelConstruction(wordPatchesArrayProjected(:, colNum), hankelWindowSize);
    [U S V] = svd(wordHankelPatches{i});
    wordHankelSubspaces{i} = U(:, 1 : subspaceDim_hankel);
end

wordHankelSubspacesArray = assembleCellData2Array(wordHankelSubspaces, 2);

spaceAngle = acos(wordHankelSubspacesArray(:, 1)' * wordHankelSubspacesArray);
bins = 0 : pi/ 100 : pi;
hist(spaceAngle, bins);