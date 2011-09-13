function phraseEachVideo = getMMEachVideo(featureMatrix, featureIndexObj, phraseWindowSize)
nFeature = size(featureMatrix, 1);
phraseEachVideo = featureMatrix(1:nFeature - (phraseWindowSize  - 1) * featureIndexObj.numFeaturePerFrame);