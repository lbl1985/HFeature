function [trainPhraseLabelAll trainCenterAll train_km_obj] ...
    =  kmeans_phraseFeatures(trainPhraseFeatureAll, params)

trainPhraseLabelAll = cell(1, params.num_km_init_word);
trainCenterAll = cell(1, params.num_km_init_word);
train_km_obj = cell(1, params.num_km_init_word);
for i = 1 : params.num_km_init_word
    [trainPhraseLabelAll{i} trainCenterAll{i} train_km_obj{i}] = phrase.litekmeans_phrase(...
        trainPhraseFeatureAll{1}, params);
end

% save(fullfile(dataFolder, 'phraseTrain.mat'), 'trainPhraseFeatureAll', ...
%     'trainPhraseIndices', 'trainPhraseLabelAll', 'trainCenterAll', ...
%     'train_km_obj', 'MM_train_phrase');