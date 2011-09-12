function [labelPhraseAll train_indices] =  getPhraseBatch(train_indices, ...
    train_label_all, all_train_files, params)
% Functionalize mainPhrase.m

all_train_files = all_train_files(1 : length(train_indices)); 

% labelPhraseAll = [];

nKmeans = length(train_label_all);
labelPhraseAll = cell(1, nKmeans);

nFiles = length(all_train_files);
for i = 1 : nFiles
    featureIndexObj = blockSubspace.getFeatureIndexObj(i, all_train_files, params);
    
    for j = 1 : params.num_km_init_word
        tmpFeatureMatrix = blockSubspace.getFeatureMatrix(i, train_indices, train_label_all{1, j}{1});
    
        tmpPhraseEachVideo = phrase.getPhraseEachVideo(tmpFeatureMatrix, featureIndexObj, 2);
        if j == 1
            train_indices{i}.blockPhraseIndex.start = size(labelPhraseAll{j}, 1) + 1; %#ok<*SAGROW>
        end
        labelPhraseAll{j} = cat(1, labelPhraseAll{j}, tmpPhraseEachVideo);
        if j == 1
            train_indices{i}.blockPhraseIndex.end   = size(labelPhraseAll{j}, 1);
        end
    end
    
    writenum(i);
end