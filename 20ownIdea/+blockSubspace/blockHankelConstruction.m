function HankelVideo = blockHankelConstruction(hankelWindowSize, featureMatrix, featureIndexObj)
    % Since the default featureMatrix is row orientated, each row is a feature
    featureMatrix = featureMatrix';
    assert(isequal(size(featureMatrix, 2), featureIndexObj.nFeature), ...
        'number of features is not identical between calculation and experiments');

    % each video should contains # of featuresPerFrame Hankels. 
    % Each Hankel represents the dynamics alonging the time through each block
    % in spatial dimension
    HankelVideo = cell(featureIndexObj.numFeaturePerFrame, 1);
    isExtractable = checkIsNumOfSlideLargerThanHankelWindowSize(hankelWindowSize, featureIndexObj);
    if isExtractable
        for i = 1 : featureIndexObj.numFeaturePerFrame
            tmpFeatureIndexExtracting = i : featureIndexObj.numFeaturePerFrame : ...
                featureIndexObj.nFeature;
            tmpFF = featureMatrix(:, tmpFeatureIndexExtracting);
            HankelVideo{i} = hankelConstruction(tmpFF, hankelWindowSize);
        end
    end
end

function isExtractable = checkIsNumOfSlideLargerThanHankelWindowSize(...
    hankelWindowSize, featureIndexObj)
    numSlide = featureIndexObj.nFeature / featureIndexObj.numFeaturePerFrame;
    if numSlide > hankelWindowSize
        isExtractable = 1;
    else
        isExtractable = 0;
    end
end
