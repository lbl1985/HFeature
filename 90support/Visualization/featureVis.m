% function featureVis
baseFolder = getProjectBaseFolder();
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'all_train_files.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_indices.mat'));
load(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_label_all.mat'));

all_train_files = all_train_files(1 : length(train_indices));
params.avipath = fullfile(baseFolder, 'AVIClips05/');

nFiles = length(all_train_files);
for i = 1 : nFiles
    tmpMovieName = fullfile(params.avipath, [all_train_files{i} '.avi']);
    if ~exist(tmpMovieName, 'file')
        error('the file %s is not available', tmpMovieName);
    end
    tmpMovieVar = movie2var(tmpMovieName, 0, 1);
    coverFlowObj = coverFlow(tmpMovieVar);
    coverFlowObj = coverFlowObj.setFrameRangeAll;
    coverFlowObj.playConsecutiveCoverFlow;
    clear coverFlowObj
%     coverFlowObj1.
end