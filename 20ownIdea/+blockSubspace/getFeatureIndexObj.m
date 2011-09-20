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
    if params.dense_p == 1
        featureIndexObj = assembleFeatureIndexObj(tmpMovieVar, fovea);
    else
        stride_x = round(fovea.spatial_size/params.dense_p);
        stride_y = round(fovea.spatial_size/params.dense_p);
        stride_t = round(fovea.temporal_size/params.dense_p);
        numEntries = params.dense_p^3;
        featureIndexObj = cell(numEntries, 1);
        for i = 0 : numEntries - 1
            binaryI = de2bi(i, 3, params.dense_p, 'left-msb');
            intX = binaryI(1); intY = binaryI(2); intT = binaryI(3);
            startX = 1 + intX * stride_x;
            startY = 1 + intY * stride_y;
            startT = 1 + intT * stride_t;
            croppedTmpMovieVar = tmpMovieVar(startX : end, startY : end, startT : end);
            featureIndexObj{i + 1} = assembleFeatureIndexObj(croppedTmpMovieVar, fovea);
        end
    end
end

function featureIndexObj = assembleFeatureIndexObj(tmpMovieVar, fovea)
tmpMovieObj = video.croppedVideoVar(tmpMovieVar, fovea);
tmpMovieSizeObj = tmpMovieObj.calculateSizeOfFeatureDetection();

featureIndexObj = featureIndex(tmpMovieSizeObj);
end
                    