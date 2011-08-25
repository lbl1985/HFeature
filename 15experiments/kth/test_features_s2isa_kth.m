function [] = test_features_s2isa_kth(network, params)

initializerandomseeds;

%%-------------- compute descriptors for training data-------------
if(params.num_movies<900)
    [all_train_labels, all_test_labels, all_train_files, all_test_files] ...
        = get_data_summary_kth(params.infopath, params.num_movies);
else
    [all_train_labels, all_test_labels, all_train_files, all_test_files] ...
        = get_data_summary_kth(params.avipath{1});
end

if params.feature.num_layers >= 2
    assert(size(network.isa{2}.H,2) == size(network.isa{2}.W,1));
end

% print_network(network);
% print_network(params);

for j = 1:params.num_km_init
    train_label_all{j} = cell(1);
    test_label_all{j} = cell(1);
end

%%---------------TRAIN: compute raw features ---------------
fprintf('Computing features for all videos in the training set:\n');
[Xtrain_raw{1}, MM_train{1}, train_indices{1}] = compute_raw_features_s2isa_kth(network, params, all_train_files, 1);
fprintf('feature size: %d\n', size(Xtrain_raw{1}, 2));

%%---------------KMEANS: over all scales raw features ---------------
fprintf('Start vector quantization on training samples:\n');
[train_label_all, center_all, km_obj] = kmeans_stackisa(Xtrain_raw, params);    
save(fullfile(params.visMedianVarSavingFolder, 'visTrainMedianData_all'));
send_mail_message('herbert19lee', 'HFeature kth_Training is Done', datestr(now));
clear Xtrain_raw

%%--------------TEST: compute raw features ---------------
fprintf('Computing features for all videos in the training set:\n');
[Xtest_raw{1}, MM_test{1}, test_indices{1}] = compute_raw_features_s2isa_kth(network, params, all_test_files, 1);

%%-------------- assign test samples to the nearest centers------------
fprintf('assigning all labels to test data......\n')
for j = 1:params.num_km_init
    test_label_all{j}{1} = find_labels_dnc(center_all{j}, Xtest_raw{1});
end
save(fullfile(params.visMedianVarSavingFolder, 'visTestMedianData_all'));
send_mail_message('herbert19lee', 'HFeature kth_Testing is Done', datestr(now));
clear Xtest_raw

%%-------------SAVE ------------
save_stackisa(params, center_all, km_obj, train_label_all, test_label_all, MM_train, MM_test, ...
        train_indices,test_indices,all_train_files,all_test_files,all_train_labels,all_test_labels);
try 
    rerun_ap;
catch ME
    send_mail_message('herbert19lee', 'rerun_ap is broken', ME.message);
end