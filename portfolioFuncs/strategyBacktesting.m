% specify ticker symbols

tickSymbs = {'^STOXX50E', ... % STOXX Europe 50
    '^GDAXI', ... % DAX
    '^GSPC'};     % S&P 500
    
etfSymbs = {'EEM', ... % iShares MSCI Emerging Markets; USD
    'BTUSX', ... % Deutsche US Bond Index Institutional (BTUSX); USD
    'SPY', ... % SPDR S&P 500; USD
    'EWJ', ... % iShares MSCI Japan; USD
    'SGOL', ... % ETFS Physical Swiss Gold; USD
    'EFA', ... % iShares MSCI EAFE; USD
    'EWZ', ... % iShares MSCI Brazil Capped; USD
    'HYG', ... % iShares iBoxx $ High Yield Corporate Bd; USD
    'XOP', ... % SPDR S&P Oil & Gas Explor & Prodtn ETF; USD
    };
    
% specify beginning and ending as string variables
dateBeg = '01011990';   %  day, month, year: ddmmyyyy
dateEnd = '01092016';


%% download prices

prices = getPrices(dateBeg, dateEnd, etfSymbs);
writetable(prices, '~/someETFprices.csv')

%% 

prices = readtable('~/someETFprices.csv');

%%

plot(prices.Date, prices{:, 2:end})
datetick 'x'
grid on
grid minor

%% visualize missing values

imagesc(isnan(prices{:, 2:end}), [0 1])
set(gca, 'XTickLabel', tabnames(prices(:, 2:end)))
yTicks = get(gca, 'YTick');
set(gca, 'YTickLabel', datestr(prices.Date(yTicks)))

%% get sub-sample without NaNs

subPrices = cleanSubsample(prices, 6);
assert(~any(any(isnan(subPrices{:, :}))), 'There are still missing values')

%%

plot(subPrices.Date, subPrices{:, 2:end})
datetick 'x'
grid on
grid minor

%% visualize normed prices

% get normed prices
nObs = size(subPrices, 1);
normedPrices = subPrices;
xxnormedPrices = subPrices{:, 2:end} ./ repmat(subPrices{1, 2:end}, nObs, 1);
normedPrices{:, 2:end} = xxnormedPrices;

% make plot
plot(normedPrices.Date, normedPrices{:, 2:end})
datetick 'x'
grid on
grid minor
legend(tabnames(normedPrices(:, 2:end)))

%%

% get asset names
etfNames = tabnames(normedPrices(:, 2:end));

% attach cash and sort
univPrices = subPrices;
univPrices.Cash = ones(nObs, 1);
univPrices = univPrices(:, ['Date', 'Cash', etfNames]);

%% try to get equal weights portfolio

% get portfolio value
initValue = 10000;
oldCash = initValue;

% get target weights
nEtfs = size(subPrices, 2) - 1;
targetWgts = [0, 1./nEtfs*ones(1, nEtfs)];

% current prices
currPrices = subPrices{1, 2:end};

% current vols
currVols = [oldCash, 1./nEtfs*zeros(1, nEtfs)];


% get associated weights
newWgts = getNewWgts(currVols(2:end), bestVols, currPrices, currVols(1))



