clear
baseFolder = getProjectBaseFolder();
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'all_train_files.mat'));
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'save_train_indices.mat'));
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'train_label_all.mat'));
load(fullfile(baseFolder, 'Results', 'VisualMedianData', 'trainKmeans_excpt_Xtrain_raw.mat'));
load(fullfile(baseFolder, '10digging', 'bases', 'isa2layer_16t20_ts10t14_nf200_gs2_st4t4_l1_isa1layer_16_10_300_1'));

fovea.spatial_size = isanetwork{1}.spatial_size; 
fovea.temporal_size = isanetwork{1}.temporal_size;

