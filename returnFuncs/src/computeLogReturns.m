function logRets = computeLogReturns(priceTab, varargin)
% compute log returns for given discrete prices
%
% Inputs:
%   priceTab    nxm table of discrete prices
%   freq        single / multi-period returns
%
% Outputs:
%   logRets     kxm table of (multi-period) log returns

% input must be table for now
assert(istable(priceTab))

if nargin == 1
    % use default values: single period returns
    logPrices = log(priceTab{:,:});
    logRetsMatr = diff(logPrices);
    logRets = embed(logRetsMatr, priceTab(2:end, :));
else
    error('commonUtilities:computeLogReturns', ...
        'Multiple input arguments not defined yet');
    
end
