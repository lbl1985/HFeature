function N = transact_dense_samp_raw(M, fovea, params)

% fovea = network.isa{params.feature.num_layers}.fovea;

ds_st_per_cf_x = params.testds_sp_strides_per_cfovea_x;
ds_st_per_cf_y = params.testds_sp_strides_per_cfovea_y;
ds_st_per_cf_t = params.testds_tp_strides_per_cfovea;

ds_st_sp_x = params.testds_sp_stride_x;
ds_st_sp_y = params.testds_sp_stride_y;
ds_st_tp = params.testds_tp_stride;

[x, y, t] = size(M);
approx_num_samples = max(1, floor((x/fovea.spatial_size-2)*(y/fovea.spatial_size-2)*(t/fovea.temporal_size-2)));

ds_multiple = ds_st_per_cf_x*ds_st_per_cf_y*ds_st_per_cf_t;

%initialization of feature list
X_features = zeros(approx_num_samples*ds_multiple, params.num_features, 'single');    

%initialize motion measure (list)
motion_measure = zeros(approx_num_samples*ds_multiple, 1);

%% start dense sampling: load and calculate features for movies, starting with various offsets
X_fill = 0;
ds_count = 1;
for x_offset = 0:ds_st_per_cf_x-1 %stride indices per complex fovea
    for y_offset = 0:ds_st_per_cf_y-1 %stride indices per complex fovea
        for t_offset = 0:ds_st_per_cf_t-1
            
            N = crop_video_blk(M(1+x_offset*ds_st_sp_x:end, 1+y_offset*ds_st_sp_y:end, 1+t_offset*ds_st_tp:end), fovea.spatial_size, fovea.temporal_size);
            x_height = size(N, 1);
            num_frames = size(N, 3);
            
            N = reshape(N, x_height, []);
            
            N = im2col(N, [fovea.spatial_size, fovea.spatial_size], 'distinct');
            
            N = reshape(N, [], num_frames);
            
            N = im2col(N, [fovea.spatial_size^2, fovea.temporal_size], 'distinct');            
            
%             num_samples = size(N,2);
        end
    end
end
end

