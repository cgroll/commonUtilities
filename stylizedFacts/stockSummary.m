function summaryTable = stockSummary(stockData)

% define what an observation is
isObs = @(x)(~isnan(x) & (x ~= 0));

% get prices and dates
prices = stockData(:, 2:end);
dats = stockData{:, 1};

% get first observation
firstInds = varfun(@(x)(findMod('LastIndex', isObs(x), 1)), prices);
firstDates = dats(firstInds{1, :});

summaryTable = table(tabnames(prices)', firstDates, 'VariableNames', {'Ticker', 'FirstDate'});

% get last observations
lastInds = varfun(@(x)(findMod('LastIndex', isObs(x), 1, 'last')), prices);
lastDates = dats(lastInds{1, :});
summaryTable.LastDate = lastDates;

% get number of observations
nObsTable = varfun(@(x)(sum(isObs(x))), prices);
summaryTable.NObs = nObsTable{1, :}';

% get time period of observations
summaryTable.Duration = (lastDates - firstDates) ./ 365;

firstPrices = varfun(@(x)x(findMod('LastIndex', isObs(x), 1)), prices);
summaryTable.FirstPrice = firstPrices{1, :}';
lastPrices = varfun(@(x)x(findMod('LastIndex', isObs(x), 1, 'last')), prices);
summaryTable.LastPrice = lastPrices{1, :}';

summaryTable.FullRets = ((lastPrices{1, :}./firstPrices{1, :}) - 1)'*100;
durs = summaryTable.Duration;
summaryTable.AnnualRets = ((lastPrices{1, :}./firstPrices{1, :}).^(1./durs') - 1)'*100;

end
