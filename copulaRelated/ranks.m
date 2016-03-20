function U = ranks(X)
% converts values of X to unit cube via empirical cdf
%
% Input:
%   X       nxd matrix of d time series
%
% Output:
%   U       nxd matrix of transformed values
%
% Nov.2011

% get length of individual time series
[n d] = size(X);

% sort individual time series
[xSorted xIX] = sort(X);

% get associated rank values
rankVals = 1:n;
rankVals = rankVals'/(n+1); % avoid 0 and 1

% determine output
U = zeros(n,d);
for ii=1:d
    U(xIX(:,ii),ii) = rankVals;
end