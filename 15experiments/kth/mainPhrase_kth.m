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
% params.num_km_init = 3;
params.num_km_init_word = 3;
params.num_km_init_phrase = 3;
params.seed = 10; %random seed for kmeans
params.num_centroids = 50;

[trainPhraseFeatureAll trainPhraseIndices] = phrase.getPhraseBatch(train_indices{1}, ...
    train_label_all, all_train_files, params);

trainLabelAll = cell(1, params.num_km_init_word);
trainCenterAll = cell(1, params.num_km_init_word);
train_km_obj = cell(1, params.num_km_init_word);
for i = 1 : params.num_km_init_word
    [trainLabelAll{i} trainCenterAll{i} train_km_obj{i}] = phrase.litekmeans_phrase(...
        trainPhraseFeatureAll{i}, params);
end
save(fullfile(dataFolder, 'phraseTrain.mat'), 'trainPhraseFeatureAll', ...
    'trainPhraseIndices', 'trainLabelAll', 'trainCenterAll', 'train_km_obj');

% Testing Section

load(fullfile(dataFolder, 'visTestMedianData_all.mat'));
[testPhraseFeatureAll testPhraseIndices] = phrase.getPhraseBatch(test_indices{1}, ...
    test_label_all, all_test_files, params);

for i = 1 : params.num_km_init_word
    for j = 1 : params.num_km_init_phrase
        test_label_all{1, i}{j, 1} = find_labels_dnc(trainCenter_all{1, i}{j, 1}, testPhraseFeatureAll{i});
    end
end
save(fullfile(dataFolder, 'phraseTest.mat'), 'testPhraseFeatureAll', ...
    'testPhraseIndices', 'test_label_all');
% display('Done');
