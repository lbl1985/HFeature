function wordPatchesArray = getWordPatchesArray(wordPatches, fovea)
nPatches = length(wordPatches);
wordPatchesArray = [];
for i = 1 : nPatches
    wordPatchesArray = cat(2, wordPatchesArray, reshape(wordPatches{1}, ...
        [fovea.spatial_size * fovea.spatial_size fovea.temporal_size]));
end