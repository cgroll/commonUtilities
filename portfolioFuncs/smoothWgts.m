function newWgts = smoothWgts(wgts, lambdaVal)

% get dimensions
nWgts = size(wgts, 1);

newWgts = wgts;
for ii=2:nWgts
    newWgts(ii, :) = sampleMean(wgts(1:ii, :), lambdaVal);
end
