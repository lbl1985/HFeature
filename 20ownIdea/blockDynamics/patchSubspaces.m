function patchSubspaces(wordId, params_subspace)

load(['videoPatchAll_Word' num2str(wordId) '.mat']);

if nargin > 1
    fovea = params_subspace.fovea;
    subspaceDim_pca = params_subspace.subspaceDim_pca;
    subspaceDim_hankel = params_subspace.subspaceDim_hankel;
    hankelWindowSize = params_subspace.hankelWindowSize;
else
    fovea.spatial_size = 20; fovea.temporal_size = 14;
    subspaceDim_pca = 3;
    subspaceDim_hankel = 1;
    hankelWindowSize = 4;
end

nPatches = length(wordPatches);

wordPatchesArray = reshape(assembleCellData2Array(wordPatches, 4), ...
    fovea.spatial_size * fovea.spatial_size, []);
wordPatchesArrayRemoveDC = removeDC(wordPatchesArray);

[U, ~, D] = pca(wordPatchesArrayRemoveDC);
figure(); plot(1:min(size(D)), diag(D));

wordPatchesArrayProjected = U(1:subspaceDim_pca, :) * wordPatchesArrayRemoveDC;

wordHankelPatches = cell(length(wordPatches), 1);
wordHankelSubspaces = cell(length(wordPatches), 1);
spaceAngle = zeros(nPatches, 1);

for i = 1 : nPatches
    colNum = (i - 1) * fovea.temporal_size + 1 : i * fovea.temporal_size;
    wordHankelPatches{i} = hankelConstruction(wordPatchesArrayProjected(:, colNum), hankelWindowSize);
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
figure(); hist(spaceAngle, bins);