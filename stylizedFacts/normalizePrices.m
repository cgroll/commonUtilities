function normedPrices = normalizePrices(stockData, takeLog)
% normalize prices with regards to first prices
%
% Input:
%   stockData       nx(m+1) table of stock prices and dates column
%   takeLog         boolean, indicating whether log prices should be
%                   returned
%
% Output:
%   normedPrices    nx(m+1) table of normalized prices

assert(hasDateCol(stockData), 'First column must contain dates');

if ~exist('takeLog', 'var')
    takeLog = false;
end

% define what an observation is
isObs = @(x)(~isnan(x) & (x ~= 0));

% get first prices as first real observations
firstPrices = varfun(@(x)x(findMod('LastIndex', isObs(x), 1)), stockData(:, 2:end));

% get normed prices
nObs = size(stockData, 1);
normedPrices = stockData;
normedPrices{:, 2:end} = stockData{:, 2:end} ./ repmat(firstPrices{1, :}, nObs, 1);

if takeLog
    normedPrices{:, 2:end} = log(normedPrices{:, 2:end});
end

if nargout == 0
    plotVals = normedPrices;
    plotVals = cutOffInitNaNs(plotVals, true);
    plot(plotVals.Date, plotVals{:, 2:end})
    datetick 'x'
    grid on
    grid minor
    
    % overwrite output
    normedPrices = [];
end

end
