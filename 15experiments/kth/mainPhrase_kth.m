clear
baseFolder = getProjectBaseFolder();
dataFolder = fullfile(baseFolder, 'Results', 'VisualMedianData');
% Training Section
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'visTrainMedianData_all.mat'));
load(fullfile(baseFolder, '15experiments', 'bases', ...
    'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));



