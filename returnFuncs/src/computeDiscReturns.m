function discRets = computeDiscReturns(priceTab, varargin)
% compute discrete returns for given discrete prices
%
% Inputs:
%   priceTab    nxm table of discrete prices
%   freq        single / multi-period returns
%
% Outputs:
%   discRets    kxm table of (multi-period) discrete returns

% input must be table for now
assert(istable(priceTab))

if nargin == 1
    % use default values: single period returns
    prices = priceTab{:,:};
    discRetsMatr = (prices(2:end, :) - prices(1:end-1, :))...
        ./prices(1:end-1, :);
    discRets = embed(discRetsMatr, priceTab(2:end, :));
else
    error('commonUtilities:computeDiscReturns', ...
        'Multiple input arguments not yet defined');
    
end
