function params = createParams(baseFolder, isanetwork)
% supporting function for mainPhrase_kth
params.avipath = fullfile(baseFolder, '15experiments', 'kth', 'kth_selectFrames');
params.fovea.spatial_size = isanetwork{1}.spatial_size; 
params.fovea.temporal_size = isanetwork{1}.temporal_size;
% params.num_km_init = 3;
params.num_km_init_word = 1;
params.num_km_init_phrase = 3;
params.seed = 10; %random seed for kmeans
params.num_centroids = 50;

%norm binning & filtering (disregard, leave values)
params.usenormbin = 1; %
params.normbinexp = 1; %
params.filtermotion = 0; %

%svm kernel
params.kernel = 'chisq';

params.pydheight = 1;

params.norm_type = 1; %normalization type for svm classification
% [L1-norm]: recommended for chi-squared svm kernel

%evaluation method: 'ap' average precision (one-vs-all, multiple labels per datapoint), 
params.eval = 'ap';

params.num_vid_sizes = 1; %[void] option to use multiple video sizes
% params.unscramble = 1; %set 1 Hollywood2: deal with multiple labels/clip 
params.unscramble = 0; %kth doesn't need unscramble
% Where to read the ground truth label information.
params.infopath = [];
% phraseWindowSize: each phrase contains how many words
params.phraseWindowSize = 4;
