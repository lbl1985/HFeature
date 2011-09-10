function featureIndexObj = getFeatureIndexObj(i, all_train_files, params)
    fovea = params.fovea;
    if ~strcmp(all_train_files{i}(end - 3 : end), '.mat')
        tmpMovieName = fullfile(params.avipath, [all_train_files{i} '.avi']);
        if ~exist(tmpMovieName, 'file')
            error('the file %s is not available', tmpMovieName);
        end
        tmpMovieVar = movie2var(tmpMovieName, 0, 1);
    else
        LOAD = load(fullfile(params.avipath, all_train_files{i}));
        tmpMovieVar = LOAD.I;
    end
    
    tmpMovieObj = video.croppedVideoVar(tmpMovieVar, fovea);
    tmpMovieSizeObj = tmpMovieObj.calculateSizeOfFeatureDetection();
    
    featureIndexObj = featureIndex(tmpMovieSizeObj);