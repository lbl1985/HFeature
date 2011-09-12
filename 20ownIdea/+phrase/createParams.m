function params = createParams(baseFolder, isanetwork)
% supporting function for mainPhrase_kth
params.avipath = fullfile(baseFolder, '15experiments', 'kth', 'kth_selectFrames');
params.fovea.spatial_size = isanetwork{1}.spatial_size; 
params.fovea.temporal_size = isanetwork{1}.temporal_size;
% params.num_km_init = 3;
params.num_km_init_word = 3;
params.num_km_init_phrase = 3;
params.seed = 10; %random seed for kmeans
params.num_centroids = 50;