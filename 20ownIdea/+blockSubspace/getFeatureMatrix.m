function featureMatrix = getFeatureMatrix(i, train_indices, inputFeatureMatrix)
% depend on the inputFeatureMatrix. We can decide what featureMatrix we r
% going to extract

featureMatrix = inputFeatureMatrix(train_indices{i}.start : train_indices{i}.end, :);
