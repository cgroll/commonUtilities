function retsTable = price2retWithHolidays(prices, varargin)
% logic to avoid that single price NaN leads to two NaNs in returns
%
% Input:
%   prices      nxm table of prices
%   varargin    variable input arguments that get passed on to function
%               computeReturns; if empty, default returns will be
%               logarithmic single period returns
%
% Output:
%   retsTable    (n-1)xm table of returns

% store missing values to include again afterwards
missingValues = isnan(prices{:,:});

% temporarily impute single missing values
pricesImputed = imputeWithLastDay(prices);

% impute once again? if two consecutive NaNs should be treated also
% pricesImputed = imputeWithLastDay(pricesImputed);

% calculate returns
rets = computeReturns(pricesImputed, varargin{:});

% fill in NaNs again
xx = rets{:, :};
xx(missingValues(2:end, :)) = NaN;
retsTable = embed(xx, rets);

end