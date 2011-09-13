function Xsvm = formhist_phrase(label_all, indices, params,  num_clips,  MM, ini_idx_word, ini_idx_phrase)

if params.usenormbin == 0
    %%------------------ form svm inputs by binning ----------------------    

    Xsvm = zeros(num_clips, params.num_centroids);
    for i = 1:params.num_vid_sizes
        Xsvm = Xsvm + buildtmppyd(label_all{1, ini_idx_word}{ini_idx_phrase, 1}, indices, num_clips, params.num_centroids, params.pydheight);
    end 
else
    for i = 1 : params.num_vid_sizes
        MM_norm{i} = MM{i};
        MM_norm{i} = max(0, MM_norm{i}-params.filtermotion);
        MM_norm{i} = (MM_norm{i}/2400).^params.normbinexp;
    end
    
    %%%%%%%%%%%%%%%%% use buildtmppyd to build histograms %%%%%%%%%%%%%%%%%
    num_blocks = 2^params.pydheight-1;

    Xsvm = zeros(num_clips, params.num_centroids*num_blocks);
    for i = 1:params.num_vid_sizes  

       Xsvm = Xsvm + buildtmppyd(label_all{1, ini_idx_word}{ini_idx_phrase, 1}, indices, num_clips, params.num_centroids, params.pydheight, MM_norm{i});

    end    
end