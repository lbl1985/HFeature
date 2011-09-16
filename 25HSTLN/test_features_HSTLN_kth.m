function test_features_HSTLN_kth(network, params)

initializerandomseeds;

%%-------------- compute descriptors for training data-------------
if(params.num_movies<900)
    [all_train_labels, all_test_labels, all_train_files, all_test_files] ...
        = get_data_summary_kth(params.infopath, params.num_movies);
else
    [all_train_labels, all_test_labels, all_train_files, all_test_files] ...
        = get_data_summary_kth(params.avipath{1});
end

for j = 1:params.num_km_init
    train_label_all{j} = cell(1);
    test_label_all{j} = cell(1);
end

%%---------------TRAIN: compute raw features ---------------
fprintf('Computing features for all videos in the training set:\n');
[Xtrain_raw{1}, train_indices{1}] ...
    = compute_regressor_features_HSTLN_kth(network, params, all_train_files, 1);
fprintf('feature size: %d\n', size(Xtrain_raw{1}, 2));