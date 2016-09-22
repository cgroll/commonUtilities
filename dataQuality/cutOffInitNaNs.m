function shortPrices = cutOffInitNaNs(prices, firstDateCol)
% skip all missing values until first observation column wise

if firstDateCol
    priceVals = prices{:, 2:end};
end

% find NaN rows
someObsRows = ~all(isnan(priceVals), 2);

% find observations before first observations
preFirstObsInd = find(someObsRows, 1);
preFirstObs = true(size(prices, 1), 1);
preFirstObs(preFirstObsInd:end) = false;

shortPrices = prices(~preFirstObs, :);

end