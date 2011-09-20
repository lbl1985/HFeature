clear; clc
dense_p = 2;
baseFolder = getProjectBaseFolder();
if dense_p > 1
    dataFolder = fullfile(baseFolder, 'Results', 'kth', ['VisualMedianData_dense' num2str(dense_p)]);
else
    dataFolder = fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData');
end
% dataFolder = fullfile(baseFolder, 'Results', 'kth', '2011-08-26');


% Training Section
load(fullfile(dataFolder, 'visTrainMedianData_all.mat'));
% load(fullfile(dataFolder, 'svm_ready_isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1_Nlay2_ca1_nm1000_cen50_nkms1000_1v_Frames_ds111_unb1_fm0_20110826T173020.mat'));
load(fullfile(baseFolder, '15experiments', 'kth', 'bases', ...
    'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

params = phrase.createParams(baseFolder, isanetwork);
params.dense_p = dense_p;

for i = 1 : params.nPhraseWindowSize
    params.phraseWindowSize = params.phraseWindowSizeBatch(i);
    display(['Working on PhraseWindowSize = ' num2str(params.phraseWindowSize)]);
    % -------------- TRAIN: compute phrase features ----------------------
    fprintf('Construct Phrase Features for all videos in the training set:\n');
    [trainPhraseFeatureAll{i} trainPhraseIndices{i}, MM_train_phrase{i}] = phrase.getPhraseBatch(train_indices{1}, ...
        Xtrain_raw, all_train_files, MM_train, params); 

    % -------------- Kmeans: over all phrase features --------------------
    fprintf('Start vector quantization on training samples:\n');
    [trainPhraseLabelAll{i} trainCenterAll{i} train_km_obj{i}] =  phrase.kmeans_phraseFeatures(trainPhraseFeatureAll{i}, params);
end

% Testing Section

load(fullfile(dataFolder, 'visTestMedianData_all.mat'));
params = phrase.createParams(baseFolder, isanetwork);

for i = 1 : params.nPhraseWindowSize
    params.phraseWindowSize = params.phraseWindowSizeBatch(i);
    display(['Working on PhraseWindowSize = ' num2str(params.phraseWindowSize)]);
    % -------------- Test: compute phrase features ----------------------
    fprintf('Construct Phrase Features for all videos in the testing set:\n');
    [testPhraseFeatureAll{i} testPhraseIndices{i} MM_test_phrase{i}] = phrase.getPhraseBatch(test_indices{1}, ...
        Xtest_raw, all_test_files, MM_test, params);

    % -------------- assign test samples to the nearest centers------------
    fprintf('assigning all labels to test data......\n');
    testPhraseLabelAll{i} = phrase.assignTestingLabel_phrase(trainCenterAll{i}, testPhraseFeatureAll{i}, params);    
end

% Classification section
phrase.rerun_ap_phrase