function tmpSubspacesVideo = blockSubspacesCal(tmpHankelVideo, nSubspaces)
if isempty(tmpHankelVideo{1})
    tmpSubspacesVideo = tmpHankelVideo;
else
    nBlocks = length(tmpHankelVideo);
    tmpSubspacesVideo = cell(nBlocks, 1);
    for i = 1 : nBlocks
        [U, ~, ~] = svd(tmpHankelVideo{i});
        tmpSubspacesVideo{i} = U(:, 1 : nSubspaces);
    end
end