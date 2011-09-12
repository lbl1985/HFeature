clear
baseFolder = getProjectBaseFolder();
dataFolder = fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData');


% Training Section
load(fullfile(dataFolder, 'visTrainMedianData_all.mat'));
load(fullfile(baseFolder, '15experiments', 'kth', 'bases', ...
    'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

params.avipath = fullfile(baseFolder, '15experiments', 'kth', 'kth_selectFrames');
params.fovea.spatial_size = isanetwork{1}.spatial_size; 
params.fovea.temporal_size = isanetwork{1}.temporal_size;
params.num_km_init = 3;
params.seed = 10; %random seed for kmeans
params.num_centroids = 50;

[trainPhraseFeatureAll trainPhraseIndices] = phrase.getPhraseBatch(train_indices{1}, ...
    train_label_all, all_train_files, params);

for ini_idx = 1 : params.num_km_init
    fprintf('compute kmeans: %d th initialization\n', ini_idx);
    rand('state', params.seed + 10 * ini_idx);
    [~, center_all{ini_idx}, km_obj{ini_idx}] = litekmeans_obj(trainPhraseFeatureAll, params.num_centroids);
end
save(fullfile(dataFolder, 'phraseTrain.mat'), 'trainPhraseFeatureAll', 'trainPhraseIndices');

% Testing Section

load(fullfile(dataFolder, 'visTestMedianData_all.mat'));
[testPhraseFeatureAll testPhraseIndices] = phrase.getPhraseBatch(test_indices{1}, ...
    test_label_all, all_test_files, isanetwork, videoFolder);
save(fullfile(dataFolder, 'phraseTest.mat'), 'testPhraseFeatureAll', 'testPhraseIndices');
display('Done');
