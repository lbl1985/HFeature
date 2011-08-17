function textLocationBatch = calculateFeatureLocations(tmpMovieObj, ClassLabels)
% croppedVideoObj

displayOffsite = 5;

numFeaturePerRow = tmpMovieObj.siz(1) / tmpMovieObj.spatial_size;
numFeaturePerFrame = tmpMovieObj.siz(1) * tmpMovieObj.siz(2) / (tmpMovieObj.spatial_size^2);
numOfSlides = tmpMovieObj.siz(end) / tmpMovieObj.temporal_size;
nFeature = numFeaturePerFrame * numOfSlides;

assert(nFeature == length(ClassLabels), 'nFeature Calculated is not equal to Experimental Results');

textLocationBatch = cell(nFeature, 1);

for i = 1 : nFeature
    slideIndex = mod(i / numFeaturePerFrame);
    rowIndex = mod(slideIndex / numFeaturePerRow);
    colIndex = ceil(slideIndex / numFeaturePerRow);
    
    textLocation = zeros(tmpMovieObj.temporal_size, 3);
    textLocation(:, 1) = (rowIndex - 1) * tmpMovieObj.spatial_size + displayOffsite;
    textLocation(:, 2) = (colIndex - 1) * tmpMovieObj.spatial_size + displayOffsite;
    textLocation(:, 3) = slideIndex * (1 : tmpMovieObj.temporal_size)';
    
    textLocationBatch{i} = textLocation;
end
    