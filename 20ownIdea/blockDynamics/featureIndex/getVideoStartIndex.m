function videoStartIndex = getVideoStartIndex(videoIndex, train_indices)

nFeature = length(videoIndex);
videoStartIndex = zeros(nFeature, 1);
for i = 1 : nFeature
    videoStartIndex(i) = train_indices{videoIndex(i)}.start;
end