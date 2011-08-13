if ismac
    workingpath = '/Users/herbert19lee/Documents/MATLAB/work/HFeature';
elseif ispc
    workingpath = 'C:\Users\lbl1985\Documents\MATLAB\work\HFeature';
end  

cd(workingpath);
addpath(workingpath);
addpath(genpath(fullfile(workingpath, '10digging')));
addpath(genpath(fullfile(workingpath, '90support')));
addpath(genpath(fullfile(workingpath, 'Results')));