function tmpSubspacesVideo = blockSubspacesCal(tmpHankelVideo, nSubspaces, subspaceDimension)
nBlocks = length(tmpHankelVideo);

if isempty(tmpHankelVideo{1})
    tmpSubspacesVideo = zeros(subspaceDimension, nBlocks * nSubspaces);
else
    tmpSubspacesVideo = zeros(subspaceDimension, nBlocks * nSubspaces);
    for i = 1 : nBlocks
        [U, ~, ~] = svd(tmpHankelVideo{i});
        index = (i - 1) * nSubspaces + 1 : i * nSubspaces;
        tmpSubspacesVideo(:, index) = U(:, 1 : nSubspaces);
    end
end