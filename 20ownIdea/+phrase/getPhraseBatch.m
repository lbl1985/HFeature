function [labelPhraseAll train_indices] =  getPhraseBatch(train_indices, ...
    train_label_all, all_train_files, isanetwork, avipath)
% Functionalize mainPhrase.m

fovea.spatial_size = isanetwork{1}.spatial_size; 
fovea.temporal_size = isanetwork{1}.temporal_size;
params.fovea = fovea;
params.avipath = avipath;
all_train_files = all_train_files(1 : length(train_indices)); 

labelPhraseAll = [];

nFiles = length(all_train_files);
for i = 1 : nFiles
    featureIndexObj = blockSubspace.getFeatureIndexObj(i, all_train_files, params);
    
    tmpFeatureMatrix = blockSubspace.getFeatureMatrix(i, train_indices, train_label_all{1}{1});
    
    tmpPhraseEachVideo = phrase.getPhraseEachVideo(tmpFeatureMatrix, featureIndexObj, 2);
    train_indices{i}.blockPhraseIndex.start = size(labelPhraseAll, 1) + 1; %#ok<*SAGROW>
    labelPhraseAll = cat(1, labelPhraseAll, tmpPhraseEachVideo);
    train_indices{i}.blockPhraseIndex.end   = size(labelPhraseAll, 1);
    
    writenum(i);
end