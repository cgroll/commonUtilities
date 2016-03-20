%% Download SP500 stock price data

% specify start and end point of investigation period
dateBeg = '01011990';
dateEnd = '18032016';

% load ticker symbol table
tickerSymbs = readtable('../public_data/SP500TickerTable.csv');

% SP500 components
tic
spCompPrices = getPrices(dateBeg, dateEnd, tickerSymbs.Ticker_symbol');
toc

% save to disk
writetable(spCompPrices, '../public_data/sp500Prices.csv')