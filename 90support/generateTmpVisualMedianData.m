function generateTmpVisualMedianData(idx, varargin)
% This function is designed for prepare for the visualization purpose.
% Save the information sections corresponding to the specific required
% videos.

% idx = 1 : 2;

baseFolder = getProjectBaseFolder();
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'all_train_files.mat'));
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'save_train_indices.mat'));
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'train_label_all.mat'));

all_train_files_backup = all_train_files;
all_train_files = all_train_files(idx);
save(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'all_train_files.mat'), 'all_train_files');

train_indices_backup = train_indices;
train_indices = train_indices{1}(idx);
save(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_indices.mat'), 'train_indices');

save(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'train_label_all.mat'), 'train_label_all');   

if nargin == 2
    isRaw = varargin{1};
end


if exist('isRaw', 'var')
    load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'trainKmeans.mat'));
    lastLineNum = train_indices{end}.end;
    Xtrain_raw = {Xtrain_raw{1}(1 : lastLineNum, :)};
    save(fullfile(baseFolder, 'Results', 'tmpVisualMedianData', 'Xtrain_raw.mat'), 'Xtrain_raw');
end
    