function HankelVideo = blockHankelConstruction(hankelWindowSize, featureMatrix, featureIndexObj)
% Since the default featureMatrix is row orientated, each row is a feature
featureMatrix = featureMatrix';
assert(isequal(size(featureMatrix, 2), featureIndexObj.nFeature), ...
    'number of features is not identical between calculation and experiments');

% each video should contains # of featuresPerFrame Hankels. 
% Each Hankel represents the dynamics alonging the time through each block
% in spatial dimension
HankelVideo = cell(featureIndexObj.numFeaturePerFrame, 1);

for i = 1 : featureIndexObj.numFeaturePerFrame
    tmpFeatureIndexExtracting = i : featureIndexObj.numFeaturePerFrame : ...
        featureIndexObj.nFeature;
    tmpFF = featureMatrix(:, tmpFeatureIndexExtracting);
    HankelVideo{i} = hankelConstruction(tmpFF, hankelWindowSize);
end

