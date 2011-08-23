baseFolder = getProjectBaseFolder();
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'all_train_files.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_indices.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_label_all.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'Xtrain_raw.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'Xtrain_raw.mat'));
load(fullfile(baseFolder, '10digging', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

fovea.spatial_size = isanetwork{1}.spatial_size; 
fovea.temporal_size = isanetwork{1}.temporal_size;
params.avipath = fullfile(baseFolder, 'AVIClips05/');
all_train_files = all_train_files(1 : length(train_indices)); 

nFiles = length(all_train_files);
for i = 1 : 1
    tmpMovieName = fullfile(params.avipath, [all_train_files{i} '.avi']);
    if ~exist(tmpMovieName, 'file')
        error('the file %s is not available', tmpMovieName);
    end
    tmpMovieVar = movie2var(tmpMovieName, 0, 1);
    
    tmpMovieObj = video.croppedVideoVar(tmpMovieVar, fovea);
    tmpMovieSizeObj = tmpMovieObj.calculateSizeOfFeatureDetection();
    
    tmpFeatureMatrix = Xtrain_raw{1}(train_indices{i}.start : train_indices{i}.end, :);
end
