function subSample = cleanSubsample(prices, minAssets)
% find a subsample with minimum number of observable assets
%
% Inputs
%   prices      nObsx(m+1) table of prices with dates
%   minAssets   scalar value: minimum number of assets
%
% Output
%   subSample

% get number of observations per date
nObsPerDate = sum(~isnan(prices{:, 2:end}), 2);

% find first date with more assets than required 
xxInd = find(nObsPerDate >= minAssets, 1);

% pick only observable columns
relevantObs = prices(xxInd, :);

% only pick columns with observations
colInds = ~isnan(relevantObs{1, :});

subSample = prices(xxInd:end, colInds);

end
