% function rerun_ap_phrase
clc
mean_ap_list = zeros(params.num_km_init_phrase, params.num_km_init_word);
mean_acc_list = zeros(params.num_km_init_phrase, params.num_km_init_word);

for ini_idx_word = 1 : params.num_km_init_word
    for ini_idx_phrase = 1 : params.num_km_init_phrase
        %%----------------- Multiple PhraseWindows ------------------------
        for i = 1 : params.nPhraseWindowSize
            fprintf('binning VQ labels... \n');
            %%------------------ form svm inputs by binning ----------------------
            Xtrain_tmp{i} = phrase.formhist_phrase(trainPhraseLabelAll{i}, trainPhraseIndices{i}, params, length(all_train_files), MM_train_phrase{i}, ini_idx_word, ini_idx_phrase);
            Xtest_tmp{i}  = phrase.formhist_phrase(testPhraseLabelAll{i}, testPhraseIndices{i}, params, length(all_test_files), MM_test_phrase{i}, ini_idx_word, ini_idx_phrase);
        end
        
        %%------------------ Comb the multiple Phrase Words 
        Xtrain = Xtrain_tmp{1}; Xtest = Xtest_tmp{1};
        
        if params.nPhraseWindowSize > 1
            for i = 2 : params.nPhraseWindowSize
                % 1st column is index need to remove.
                Xtrain = cat(2, Xtrain, Xtrain_tmp{i}(:, 2 : end));
                Xtest = cat(2, Xtest, Xtest_tmp{i}(:, 2 : end));
            end
        end
        
        
        %%------------------ run SVM to classify data---------------------------
        norm_type = params.norm_type;
        unscramble = params.unscramble;
        [mean_ap_list(ini_idx_phrase, ini_idx_word), mean_acc_list(ini_idx_phrase, ini_idx_word)] ...
            = normalize_chi_svm_wangs_kth(Xtrain, Xtest, norm_type, ...
            all_train_files, all_test_files, all_train_labels, all_test_labels, unscramble, params.infopath, 0);
    end
end