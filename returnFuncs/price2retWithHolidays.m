function retsTable = price2retWithHolidays(prices, datesInFirstCol, applyLog)
%
% Input:
%   prices              nxm matrix or table of prices
%   datesInFirstCol     boolean: is first column dates column
%   applyLog            boolean: make log returns (true) or discrete
%                       returns (false)
%
% Output:
%   retsTable    (n-1)xm table of logarithmic returns

if exist('applyLog', 'var') == false
    applyLog = true;
end
    

if datesInFirstCol
    % extract dates for later use
    dates = prices(:, 1);
    
    % get only prices
    prices = prices(:, 2:end);
end
    
% get missing values
missingValues = isnan(prices{:,:});

% get log prices
logPrices = log(prices{:,:});
pricesImputed = imputeWithLastDay(logPrices);

% impute once again?
% pricesImputed = imputeWithLastDay(pricesImputed);

% calculate returns
rets = diff(pricesImputed);

% fill in NaNs again
rets(missingValues(2:end, :)) = NaN;

% make discrete returns if required
if ~applyLog
    rets = exp(rets) - 1;
end

% attach meta-data
retsTable = array2table(rets, 'VariableNames', tabnames(prices));

if datesInFirstCol
    retsTable = [dates(2:end, :) retsTable];
end

end