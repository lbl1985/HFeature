function [labelPhraseAll train_indices MM_phrase] =  getPhraseBatch(train_indices, ...
    train_label_all, all_train_files, MM, params)
% Functionalize mainPhrase.m

all_train_files = all_train_files(1 : length(train_indices)); 

% labelPhraseAll = [];

nKmeans = length(train_label_all);
labelPhraseAll = cell(1, nKmeans);
MM_phrase = cell(1,1);

nFiles = length(all_train_files);
for i = 1 : nFiles
    featureIndexObj = blockSubspace.getFeatureIndexObj(i, all_train_files, params);
    
    for j = 1 : params.num_km_init_word
        tmpFeatureMatrix = blockSubspace.getFeatureMatrix(i, train_indices, train_label_all{1, j}{1});
        
        
        tmpPhraseEachVideo = phrase.getPhraseEachVideo(tmpFeatureMatrix, ...
            featureIndexObj, params.phraseWindowSize);
        
        
        if j == params.num_km_init_word
            train_indices{i}.start = size(labelPhraseAll{j}, 1) + 1; %#ok<*SAGROW>
            train_indices{i}.ds_sections.start = train_indices{i}.start;
        end
        labelPhraseAll{j} = cat(1, labelPhraseAll{j}, tmpPhraseEachVideo);
        
        if j == params.num_km_init_word
            train_indices{i}.end   = size(labelPhraseAll{j}, 1);
            train_indices{i}.ds_sections.end = train_indices{i}.end;
        end
    end
    
    tmpMM = blockSubspace.getFeatureMatrix(i, train_indices, MM{1});
    tmpMMEachVideo = phrase.getMMEachVideo(tmpMM, featureIndexObj, ...
            params.phraseWindowSize);
    MM_phrase{1} = cat(1, MM_phrase{1}, tmpMMEachVideo);
    
    writenum(i);
end