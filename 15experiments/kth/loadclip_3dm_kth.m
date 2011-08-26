function M = loadclip_3dm_kth(file, spatial_size, fast, smooth)

%     readerobj = mmread(file, [], [], false, true);

%     vidFrames = readerobj.frames;
    
    loadedVar = load(file);
    I = loadedVar.I;
    l = size(I, ndims(I));
    
    first_frame = fix_frame(I(:, :, 1), spatial_size);

    if fast
        M = zeros(size(first_frame, 1), size(first_frame,2), floor(l/2), 'single');        
    else        
        M = zeros(size(first_frame, 1), size(first_frame,2), l, 'single');
    end
    
    if fast
        for i = 1:2:floor(l/2)*2-1
            fixed_frame = fix_frame(I(:, :, i), spatial_size);
            if smooth
                fixed_frame = smooth_frame(fixed_frame);
            end
            M(:, :, i) = fixed_frame;
        end
    else
        for i = 1:l
            fixed_frame = fix_frame(I(:, :, i), spatial_size);

            if smooth
                fixed_frame = smooth_frame(fixed_frame);                
            end

            M(:, :, i) = fixed_frame;
        end
    end

end
