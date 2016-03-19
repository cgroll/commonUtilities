function rets = computeReturns(prices, varargin)
% compute returns from prices
%
% Inputs:
%   prices      nxm table of discrete prices
%   type        'log' or 'discrete'
%
% Defaults:
%   type        'log'
%   freq        1 - single period
%
% Outputs:
%   returns     kxm table of possibly multi-period returns with respective
%               row names

if nargin == 1
    % use default values
    rets = computeLogReturns(prices);
else
    retType = varargin{1};
    switch retType
        case {'log', 'logarithmic'}
            rets = computeLogReturns(prices);
        case {'discrete', 'disc'}
            rets = computeDiscReturns(prices);
        otherwise
            
    end
end