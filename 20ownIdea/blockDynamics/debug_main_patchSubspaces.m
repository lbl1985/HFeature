clear
load videoPatchAll_Word25

fovea.spatial_size = 20; fovea.temporal_size = 14;

subspaceDim_pca = 5;
subspaceDim_hankel = 1;
hankelWindowSize = 4;
nPatches = length(wordPatches);

wordPatchesArray = reshape(assembleCellData2Array(wordPatches, 4), ...
    fovea.spatial_size * fovea.spatial_size, []);
wordPatchesArrayRemoveDC = removeDC(wordPatchesArray);
[U S V] = pca(wordPatchesArrayRemoveDC);
wordPatchesArrayProjected = U(1:subspaceDim_pca, :) * wordPatchesArrayRemoveDC;

wordHankelPatches = cell(length(wordPatches), 1);
wordHankelSubspaces = cell(length(wordPatches), 1);
spaceAngle = zeros(nPatches, 1);

for i = 1 : nPatches
    colNum = (i - 1) * fovea.temporal_size + 1 : i * fovea.temporal_size;
    wordHankelPatches{i} = hankelConstruction(wordPatchesArrayProjected(:, colNum), hankelWindowSize);
    [U S V] = svd(wordHankelPatches{i});
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
hist(spaceAngle, bins);