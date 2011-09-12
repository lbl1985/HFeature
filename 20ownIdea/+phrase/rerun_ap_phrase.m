% function rerun_ap_phrase
clc
mean_ap_list = zeros(params.num_km_init_phrase, params.num_km_init_word);
mean_acc_list = zeros(params.num_km_init_phrase, params.num_km_init_word);

for ini_idx_word = 1 : params.num_km_init_word
    for ini_idx_phrase = 1 : params.num_km_init_phrase
        fprintf('binning VQ labels... \n');
        %%------------------ form svm inputs by binning ----------------------
        Xtrain = phrase.formhist_phrase(trainPhraseLabelAll, trainPhraseIndices, params, length(all_train_files), ini_idx_word, ini_idx_phrase);
        Xtest  = phrase.formhist_phrase(testPhraseLabelAll, testPhraseIndices, params, length(all_test_files), ini_idx_word, ini_idx_phrase);


        %%------------------ run SVM to classify data---------------------------
        norm_type = params.norm_type;
        unscramble = params.unscramble;
        [mean_ap_list(ini_idx_phrase, ini_idx_word), mean_acc_list(ini_idx_phrase, ini_idx_word)] = ...
            normalize_chi_svm_wangs_kth(Xtrain, Xtest, norm_type, ...
            all_train_files, all_test_files, all_train_labels, all_test_labels, unscramble, params.infopath, 0); 
    end
end