function featureIndexObj = getFeatureIndexObj(i, all_train_files, params)
    tmpMovieName = fullfile(params.avipath, [all_train_files{i} '.avi']);
    if ~exist(tmpMovieName, 'file')
        error('the file %s is not available', tmpMovieName);
    end
    tmpMovieVar = movie2var(tmpMovieName, 0, 1);
    
    tmpMovieObj = video.croppedVideoVar(tmpMovieVar, fovea);
    tmpMovieSizeObj = tmpMovieObj.calculateSizeOfFeatureDetection();
    
    featureIndexObj = featureIndex(tmpMovieSizeObj);