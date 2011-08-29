function rank = robustRank(d, ratio, isPlot)
% input:
% d: diagonal singular values. 
% ratio: the ratio of energy to keep

perD = cumsum(d) / sum(d);
rank = find(perD < ratio, 1, 'last' );
if isPlot
    figure(); plot(1:length(d), d);
end