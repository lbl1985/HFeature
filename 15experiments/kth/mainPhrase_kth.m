clear; clc
baseFolder = getProjectBaseFolder();
dataFolder = fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData');


% Training Section
load(fullfile(dataFolder, 'visTrainMedianData_all.mat'));
load(fullfile(baseFolder, '15experiments', 'kth', 'bases', ...
    'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

params = phrase.createParams(baseFolder, isanetwork);

[trainPhraseFeatureAll trainPhraseIndices, MM_train_phrase] = phrase.getPhraseBatch(train_indices{1}, ...
    train_label_all, all_train_files, MM_train, params);

trainPhraseLabelAll = cell(1, params.num_km_init_word);
trainCenterAll = cell(1, params.num_km_init_word);
train_km_obj = cell(1, params.num_km_init_word);
for i = 1 : params.num_km_init_word
    [trainPhraseLabelAll{i} trainCenterAll{i} train_km_obj{i}] = phrase.litekmeans_phrase(...
        trainPhraseFeatureAll{i}, params);
end
save(fullfile(dataFolder, 'phraseTrain.mat'), 'trainPhraseFeatureAll', ...
    'trainPhraseIndices', 'trainPhraseLabelAll', 'trainCenterAll', ...
    'train_km_obj', 'MM_train_phrase');

% Testing Section

load(fullfile(dataFolder, 'visTestMedianData_all.mat'));
params = phrase.createParams(baseFolder, isanetwork);
[testPhraseFeatureAll testPhraseIndices MM_test_phrase] = phrase.getPhraseBatch(test_indices{1}, ...
    test_label_all, all_test_files, MM_test, params);

for i = 1 : params.num_km_init_word
    for j = 1 : params.num_km_init_phrase
        testPhraseLabelAll{1, i}{j, 1} = find_labels_dnc(trainCenterAll{1, i}{j, 1}, testPhraseFeatureAll{i});
    end
end
save(fullfile(dataFolder, 'phraseTest.mat'), 'testPhraseFeatureAll', ...
    'testPhraseIndices', 'testPhraseLabelAll', 'MM_test_phrase');
% display('Done');

phrase.rerun_ap_phrase