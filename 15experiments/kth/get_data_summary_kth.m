% function [all_train_labels, all_test_labels, all_train_files, all_test_files] = get_data_summary_kth(info_path, num_movies)
%[all_train_labels, all_test_labels, all_train_files, all_test_files] =
%                   get_data_summary(file_path, num_movies)
% INFO_PATH : path to video information (ClipSets)
% NUM_MOVIES: number of movies for processing
% ALL_TRAIN_LABELS : train labels
% ALL_TEST_LABELS  : test labels
% ALL_TRAIN_FILES  : train file names
% ALL_TEST_FILES   : test file names
% test file, train file and labels are organized such that each index will
% give the filename and corresponding labels

%% customized for different datasets; this is for Hollywood2


function [all_train_labels, all_test_labels, all_train_files, all_test_files] =...
    get_data_summary_kth(train_video_dir)

    all_test_labels = [];   all_test_files = [];
    all_train_labels = [];  all_train_files = [];
    for i = 1 : 6
        type = getTypeString_kth(i);
        [~, filenames, n] = rfdatabase(fullfile(train_video_dir, type), 'clip', '.mat');
        [train, test] = specialSetting(ones(n, 1) * i);
        trainFilenames = filenames(train);
        testFilenames = filenames(test);
                
        [test_labels test_files] = extractTrainTestEntries(i, testFilenames);
        [train_labels train_files] = extractTrainTestEntries(i, trainFilenames);
        all_test_labels = cat(1, all_test_labels, test_labels);
        all_test_files = cat(1, all_test_files, test_files);
        all_train_labels = cat(1, all_train_labels, train_labels);
        all_train_files = cat(1, all_train_files, train_files);
        
    end
end

function [label outputFilenames] = extractTrainTestEntries(typeId, selectedFilenames)
    outputFilenames = [];
    nEntries = length(selectedFilenames);
    type = getTypeString_kth(typeId);
    
    label = ones(nEntries, 1) * typeId;
    for i = 1 : nEntries
        outputFilenames = cat(1, outputFilenames, {[type '/' selectedFilenames{i}]});
    end
end

