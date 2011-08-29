function patchSubspaces(wordId, params_subspace, dataSavingFolder)

load(['videoPatchAll_Word' num2str(wordId) '.mat']);

if nargin > 1
    fovea = params_subspace.fovea;
%     subspaceDim_pca = params_subspace.subspaceDim_pca;
    subspaceDim_hankel = params_subspace.subspaceDim_hankel;
%     hankelWindowSize = params_subspace.hankelWindowSize;
else
    fovea.spatial_size = 20; fovea.temporal_size = 14;
%     subspaceDim_pca = 3;
    subspaceDim_hankel = 1;
%     hankelWindowSize = 4;
end

nPatches = length(wordPatches);

wordPatchesArray = reshape(assembleCellData2Array(wordPatches, 4), ...
    fovea.spatial_size * fovea.spatial_size, []);
wordPatchesArrayRemoveDC = removeDC(wordPatchesArray);

[U, ~, D] = pca(wordPatchesArrayRemoveDC);
d = diag(D); 
subspaceDim_pca = robustRank(d, 0.95, 0);

wordPatchesArrayProjected = U(1:subspaceDim_pca, :) * wordPatchesArrayRemoveDC;

wordHankelPatches = cell(length(wordPatches), 1);
wordHankelSubspaces = cell(length(wordPatches), 1);
spaceAngle = zeros(nPatches, 1);
hankelWindowSizeBatch = zeros(nPatches, 1);

for i = 1 : nPatches
    colNum = (i - 1) * fovea.temporal_size + 1 : i * fovea.temporal_size;
    tmpFeature = wordPatchesArrayProjected(:, colNum);
    hankelWindowSizeBatch(i) = getHankelWindowSize(tmpFeature);
end

n = histc(hankelWindowSizeBatch, 1:size(tmpFeature, 2));
hankelWindowSize = find(n ==max(n));

for i = 1 : nPatches
    colNum = (i - 1) * fovea.temporal_size + 1 : i * fovea.temporal_size;
    tmpFeature = wordPatchesArrayProjected(:, colNum);
    wordHankelPatches{i} = hankelConstruction(tmpFeature, hankelWindowSize);
    [U, ~, ~] = svd(wordHankelPatches{i});
    wordHankelSubspaces{i} = U(:, 1 : subspaceDim_hankel);
    spaceAngle(i) = subspace(wordHankelSubspaces{1}, wordHankelSubspaces{i});
end

for i = 1 : nPatches
    spaceAngle(i) = subspace(wordHankelSubspaces{1}, wordHankelSubspaces{i});
end

wordHankelSubspacesArray = assembleCellData2Array(wordHankelSubspaces, 2);
spaceAngle = acos(abs(wordHankelSubspacesArray(:, 1 : subspaceDim_hankel)' * ...
    wordHankelSubspacesArray));

bins = 0 : pi/ 100 : pi;
h = figure(1); hist(spaceAngle, bins);
saveas(h, fullfile(dataSavingFolder, ['inWordSubspaceHistogram_Word' num2str(wordId) '.jpg']));