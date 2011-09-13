function phraseEachVideo = getPhraseEachVideo(featureMatrix, featureIndexObj, phraseWindowSize)
nFeature = size(featureMatrix, 1);
phraseEachVideo = featureMatrix(1:nFeature - (phraseWindowSize  - 1) * featureIndexObj.numFeaturePerFrame, :);
for i = 1 : phraseWindowSize - 1
    phraseEachVideo = cat(2, phraseEachVideo, featureMatrix(i * ...
        featureIndexObj.numFeaturePerFrame + 1 : end - ...
        (phraseWindowSize - i - 1) * featureIndexObj.numFeaturePerFrame, :));
end