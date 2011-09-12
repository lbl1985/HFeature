function Xsvm = formhist_phrase(label_all, indices, params,  num_clips, ini_idx_word, ini_idx_phrase)

    %%------------------ form svm inputs by binning ----------------------    

    Xsvm = zeros(num_clips, params.num_centroids);
%     for i = 1:params.num_vid_sizes
        Xsvm = Xsvm + buildtmppyd(label_all{1, ini_idx_word}{ini_idx_phrase, 1}, indices, num_clips, params.num_centroids, params.pydheight);
%     end 