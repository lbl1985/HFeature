function regressor = HSTLN_regressor(N, fovea, params)

    nsamples = size(N, 2);
    maxRegressorLength = fovea.temporal_size - params.HSTLN_HankelWindowSize + 1;
    regressor = zeros(maxRegressorLength, nsamples);
    for i = 1 : nsamples
        tmpFeature = N(:, i);
        tmpFeature = reshape(tmpFeature, fovea.spatial_size^2, []);
        hankelTmpFeature = hankelConstruction(tmpFeature, params.HSTLN_HankelWindowSize);
        [~, tmpX] = drop_hankel_rank_hstln(hankelTmpFeature);
        regressor(1:length(tmpX), i) = tmpX;
        writenum2(i);
    end
    
end
    