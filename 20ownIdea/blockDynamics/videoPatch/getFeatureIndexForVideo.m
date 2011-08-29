function featureIndexForVideo = getFeatureIndexForVideo(index, train_indices)
% Algorithm:
% Step 1: Feature Id corresponding all video pool (as input var: index)
% Step 2: each feature belongs to which video (videoIndex)
% Step 3: construct the same size as videoIndex array, with the starting
% Index corresponding to each individual videoIndex (videoStartIndex)
% Step 4: each index - videStartIndex  + 1 should be the corresponding
% feature Id in each video based.
% Step 5: Construct the featureIndexForVideo with video Id as first column,
% featureId on video based as 2nd column.

featureOrderFileIndex = featureIndex2FileIndex(train_indices);
videoIndex = featureOrderFileIndex(index);
videoStartIndex = getVideoStartIndex(videoIndex, train_indices);
featureIndexForVideo = [videoIndex index - videoStartIndex + 1];

