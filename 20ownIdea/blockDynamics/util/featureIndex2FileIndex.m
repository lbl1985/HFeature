function fileIndex = featureIndex2FileIndex(feature_indices)
% This function is designed for train_indices. 
% Generate an array with file id at location from the corresponding start
% and end location
% Input:
% feature_indices: contains the # of videos feature cells directly
% example: feature_indices = train_indices{1};
fileIndex = zeros(feature_indices{end}.end, 1, 'single');
nVideo = length(feature_indices);
for i = 1 : nVideo
    fileIndex(feature_indices{i}.start : feature_indices{i}.end) = i;
end
