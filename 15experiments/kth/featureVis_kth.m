% function featureVis
baseFolder = getProjectBaseFolder();
% load(fullfile(baseFolder, 'Results', 'kth', 'tmpVisualMedianData', 'all_train_files.mat'));
% load(fullfile(baseFolder, 'Results', 'kth', 'tmpVisualMedianData', 'train_indices.mat'));
% load(fullfile(baseFolder, 'Results', 'kth', 'tmpVisualMedianData', 'train_label_all.mat'));
load(fullfile(baseFolder, 'Results', 'kth', 'VisualMedianData', 'visTrainMedianData_all.mat'));
load(fullfile(baseFolder, '15experiments', 'kth', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

fovea.spatial_size = isanetwork{1}.spatial_size; 
fovea.temporal_size = isanetwork{1}.temporal_size;
params.avipath = fullfile(baseFolder, '15experiments', 'kth', 'kth_selectFrames/');
checkingIndex = [64 * (0 : 5) + 1 64 * (0:5) + 5];

% nFiles = length(all_train_files);
for i = checkingIndex
    tmpMovieName = fullfile(params.avipath, [all_train_files{i}]);
    if ~exist(tmpMovieName, 'file')
        error('the file %s is not available', tmpMovieName);
    end
    tmpMovieVar = load(tmpMovieName);
    
    tmpMovieObj = video.croppedVideoVar(tmpMovieVar.I, fovea);
    tmpMovieObj.videoName = all_train_files{i}(strfind(all_train_files{i}, '/') + 1:...
        strfind(all_train_files{i}, '.') - 1);
    tmpMovieObj.videoOrigFolder = params.avipath;
    
    tmpMovieObj = tmpMovieObj.cropVideoForFeatureDetection();
    tmpClassLabel = train_label_all{1}{1}(train_indices{1}{i}.start : train_indices{1}{i}.end);

    coverFlowObj = coverflow.coverFlowClassLabel(tmpMovieObj, tmpClassLabel);
%     coverFlowObj.visualizeOnImage;
    coverFlowObj.saveKeyFramesAsFig;

    
    clear coverFlowObj
    close all;

end