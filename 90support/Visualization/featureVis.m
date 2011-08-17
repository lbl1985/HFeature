function featureVis
baseFolder = getProjectBaseFolder();
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'all_train_files.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_indices.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_label_all.mat'));
load(fullfile(baseFolder, '10digging', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

fovea.spatial_size = isanetwork{1}.spatial_size;
fovea.temporal_size = isanetwork{1}.temporal_size;
params.avipath = fullfile(baseFolder, 'AVIClips05/');
all_train_files = all_train_files(1 : length(train_indices));

nFiles = length(all_train_files);
for i = 1 : nFiles
    tmpMovieName = fullfile(params.avipath, [all_train_files{i} '.avi']);
    if ~exist(tmpMovieName, 'file')
        error('the file %s is not available', tmpMovieName);
    end
    tmpMovieVar = movie2var(tmpMovieName, 0, 1);
    tmpMovieObj = video.videoVar(tmpMovieVar);
    tmpMovieObj = cutFrameBySpatialSize(tmpMovieObj, fovea.spatial_size);
%     tmpMovieVar = loadclip_3dm(tmpMovieName, fovea.spatial_size, 0, 0); 
    coverFlowObj = coverFlow(tmpMovieObj);
    coverFlowObj = coverFlowObj.setFrameRangeAll;
    coverFlowObj.playConsecutiveCoverFlow;
    clear coverFlowObj
%     coverFlowObj1.
end
end

function outputVideo = cutFrameBySpatialSize(inputVideo, spatial_size)

end