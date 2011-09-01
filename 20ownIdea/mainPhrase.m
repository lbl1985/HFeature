clear
baseFolder = getProjectBaseFolder();
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'all_train_files.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_indices.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_label_all.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'Xtrain_raw.mat'));
load(fullfile(baseFolder, '10digging', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

fovea.spatial_size = isanetwork{1}.spatial_size; 
fovea.temporal_size = isanetwork{1}.temporal_size;
params.avipath = fullfile(baseFolder, 'AVIClips05/');
all_train_files = all_train_files(1 : length(train_indices)); 

hankelWindowSize = 4;
nSubspaces = 1;
subspaceDimension =  size(isanetwork{1}.W, 1) * hankelWindowSize;
blockHankelBatch = [];
blockSubspacesBatch = [];

nFiles = length(all_train_files);
for i = 1 : nFiles
    featureIndexObj = blockSubspace.getFeatureIndexObj(i, all_train_files, params);
    
    tmpFeatureMatrix = blockSubspace.getFeatureMatrix(i, train_indices, train_label_all{1}{1});
    
    tmpHankelVideo = blockSubspace.blockHankelConstruction(hankelWindowSize, ...
        tmpFeatureMatrix, featureIndexObj);
    tmpPhraseEachVideo = phrase.getPhraseEachVideo(tmpFeatureMatrix, featureIndexObj, 2);
    
    if (~isempty(tmpHankelVideo{1}))
        tmpSubspacesVideo = blockSubspace.blockSubspacesCal(tmpHankelVideo, nSubspaces, subspaceDimension);

        train_indices{i}.blockHankelIndex.start = size(blockSubspacesBatch, 2) + 1; %#ok<*SAGROW>
        train_indices{i}.blockHankelIndex.end   = size(blockSubspacesBatch, 2) + featureIndexObj.numFeaturePerFrame;

        blockHankelBatch = cat(1, blockHankelBatch, tmpHankelVideo);
        blockSubspacesBatch = cat(2, blockSubspacesBatch, tmpSubspacesVideo);
    end
    
    writenum(i);
end
