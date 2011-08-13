if ismac
    workingpath = '/Users/herbert19lee/Documents/MATLAB/work/HFeature';
elseif ispc
end  

cd(workingpath);
addpath(workingpath);
addpath(genpath(fullfile(workingpath, '10digging')));
addpath(genpath(fullfile(workingpath, '90support')));
addpath(genpath(fullfile(workingpath, 'Results')));