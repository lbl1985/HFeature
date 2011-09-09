clear
baseFolder = getProjectBaseFolder();
dataFolder = fullfile(baseFolder, 'Results', 'VisualMedianData');
videoFolder = fullfile(baseFolder, '15experiments', 'kth', 'kth_selectFrames');
% Training Section
load(fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData', 'visTrainMedianData_all.mat'));
load(fullfile(baseFolder, '15experiments', 'bases', ...
    'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

[labelPhraseAll_train train_PhraseIndices] = phrase.getPhraseBatch(train_indices{1}, ...
    train_label_all, all_train_files, isanetwork, videoFolder);

save(fullfile(dataFolder, 'phraseTrain.mat'), 'labelPhraseAll_train', 'train_PhraseIndices');

% Testing Section

load(fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData', 'visTrainMedianData_all.mat'));
[labelPhraseAll_test test_PhraseIndices] = phrase.getPhraseBatch(test_indices{1}, ...
    test_label_all, all_test_files, isanetwork, videoFolder);
save(fullfile(dataFolder, 'phraseTest.mat'), 'labelPhraseAll_test', 'test_PhraseIndices');
