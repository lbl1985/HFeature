function [label_all center_all km_obj] = litekmeans_phrase(X, params)
% X  row oriented feature (each row is a feature)
% params
% .num_km_init      number of Kmeans need to run.
% .num_centroids    number of cluster.

center_all = cell(params.num_km_init, 1);
km_obj = cell(params.num_km_init, 1);
label_all = cell(params.num_km_init, 1);
for ini_idx = 1 : params.num_km_init
    fprintf('compute kmeans: %d th initialization\n', ini_idx);
    rand('state', params.seed + 10 * ini_idx);
    [label_all{ini_idx}, center_all{ini_idx}, km_obj{ini_idx}] = ...
        litekmeans_obj(X, params.num_centroids);
end