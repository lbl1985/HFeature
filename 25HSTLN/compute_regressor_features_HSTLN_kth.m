function [Xall, indices] = compute_regressor_features_HSTLN_kth(network, params, data_file_names, size_idx)

% data_file_names : list of files
% XALL: descriptors for all video clips
% MM  : saliency measure of the descriptors
% indices: track start and end of each clip; also contains ds_sections,
% which tracks sections containing descriptors from differenct dense
% sampling offsets

indices = cell(1);

fovea = network.isa{params.feature.num_layers}.fovea;

m = length(data_file_names);
Xall = 0;
switch params.feature.type
    case 'sisa'
        Xall = zeros(3000000, params.num_features, 'single');
end

Xall_fill = 1;
% total_time = 0;
for i=1:m
%   tic
    display(['ClipNum ' num2str(i) ': ' char(data_file_names(i))]);
    
    M = loadclip_3dm_kth([params.avipath{size_idx}, char(data_file_names(i))], fovea.spatial_size, 0, 0); 
    [X_clip, ds_sections] = transact_dense_samp_HSTLN_kth(M, network, params);
    
    %% code to filter out the features with more motion elements, by l1 norm of
    %% activations
            
    indices{i}.start = Xall_fill;

    for ds = 1:length(ds_sections)
       ds_sections(ds).start = ds_sections(ds).start + indices{i}.start - 1 ;
       ds_sections(ds).end = ds_sections(ds).end + indices{i}.start - 1 ;
    end
    
    Xall(Xall_fill:Xall_fill+size(X_clip,1)-1,:) = X_clip;
    
    Xall_fill = Xall_fill + size(X_clip,1);    
    
    indices{i}.end = Xall_fill-1;

    indices{i}.ds_sections = ds_sections;
    
%   elapsed_time = toc;
%   total_time = total_time + elapsed_time;
%   average_time = total_time / i;
%   fprintf('number of features %d\n', size(X_clip, 1));
%   fprintf('elapsed = %f (seconds)\n', elapsed_time);
%   fprintf('ETA = %f (minutes)\n', average_time * (m-i) / 60);
  
    % print clip index
%     fprintf('%d ', i);
%     if mod(m, 20) == 0
%         fprintf('\n');
%     end    
end

Xall = Xall(1:Xall_fill-1,:);

if length(data_file_names) == 378
    save trainHSTLN Xall indices
else
    save testHSTLN Xtest indices
end
end