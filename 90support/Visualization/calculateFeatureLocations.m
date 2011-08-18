function [textLocationBatch featureRegular] = calculateFeatureLocations(croppedVideoObj, ClassLabels)
% croppedVideoObj

displayOffsite = 5;

numFeaturePerRow = croppedVideoObj.siz(1) / croppedVideoObj.spatial_size;
numFeaturePerFrame = croppedVideoObj.siz(1) * croppedVideoObj.siz(2) / (croppedVideoObj.spatial_size^2);
numOfSlides = croppedVideoObj.siz(end) / croppedVideoObj.temporal_size;
nFeature = numFeaturePerFrame * numOfSlides;

assert(nFeature == length(ClassLabels), 'nFeature Calculated is not equal to Experimental Results');

textLocationBatch = cell(nFeature, 1);

for i = 1 : nFeature
    slideIndex = mod(i / numFeaturePerFrame);
    rowIndex = mod(slideIndex / numFeaturePerRow);
    colIndex = ceil(slideIndex / numFeaturePerRow);
    
    textLocation = zeros(croppedVideoObj.temporal_size, 3);
    textLocation(:, 1) = (rowIndex - 1) * croppedVideoObj.spatial_size + displayOffsite;
    textLocation(:, 2) = (colIndex - 1) * croppedVideoObj.spatial_size + displayOffsite;
    textLocation(:, 3) = slideIndex * (1 : croppedVideoObj.temporal_size)';
    
    textLocationBatch{i} = textLocation;
end

featureRegular.numFeaturePerRow = numFeaturePerRow;
featureRegular.numFeaturePerFrame = numFeaturePerFrame;
featureRegular.numOfSlides = numOfSlides;
featureRegular.nFeature = nFeature;
    