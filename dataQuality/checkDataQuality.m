function checkDataQuality(stockData)
% show plots to inspect data

%% make some general settings

genInfo.pos = [50 50 1200 600];

% if export would be desired some day
genInfo.fmt = 'pdf';
genInfo.figClose = true;

genInfo.thresValReturns = 100; % 100 percent log return is deemed unrealistic


%% normalized prices

f = figure('pos', genInfo.pos);

normedPrices = normalizePrices(stockData);
logNormedPrices = normedPrices;
logNormedPrices{:, 2:end} = log(normedPrices{:, 2:end});

plotTs(logNormedPrices)
title('Normalized logarithmic prices')

%% 

f = figure('pos', genInfo.pos);

summaryTable = stockSummary(stockData);
plot(summaryTable.NObs, summaryTable.AnnualRets, '.')
grid on
grid minor
xlabel('Number of observations')
ylabel('Annualized log percentage return')

%% missing values, zero prices, unrealistic returns

f = figure('pos', genInfo.pos);

% show missing values
subplot(1, 3, 1)
showTrues(@(x)isnan(x), stockData, true, false);
title('Missing values')

% show zero prices
subplot(1, 3, 2)
showTrues(@(x)(x == 0), stockData, true, false);
title('Zero prices')

% show unrealistic returns
subplot(1, 3, 3)

logRets = price2retWithHolidays(stockData, true);
logRets{:, 2:end} = logRets{:, 2:end}*100;

showTrues(@(x)(x > genInfo.thresValReturns | x < -genInfo.thresValReturns), ...
    logRets, true, false);
title('Unrealistic returns')


end