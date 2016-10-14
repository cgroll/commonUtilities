function seriesTab = stallPrices(stockData)
% identify periods of stall prices
%
% Input:
%   stockData       nx(m+1) table including date column
%
% Output:
%   seriesTab       lx(m+1) table with beginning dates of stall price
%                   periods in first column and length of periods in other
%                   columns

% check input table
assert(hasDateCol(stockData), 'Function requires table with date column')

% calculate returns
logRets = price2retWithHolidays(stockData, true);

%% get zero return series for each asset

% find series of zero returns for first data column
seriesTab = findSeries('ZerosNaNs', logRets(:, 1:2), true);
seriesTab = seriesTab(:, [1 3]);

% for all other columns and join on date column
for ii=3:size(logRets, 2)
    thisSeriesTab = findSeries('ZerosNaNs', logRets(:, [1 ii]), true);
    if isempty(thisSeriesTab)
        assName = tabnames(logRets(:, ii));
        vals = [logRets{1, 1} logRets{1, 1} 0];
        thisSeriesTab = array2table(vals, 'VariableNames',...
            {'SeriesBeg', 'SeriesEnd', assName{1}});
    end
    thisSeriesTab = thisSeriesTab(:, [1 3]);
    seriesTab = outerjoin(seriesTab, thisSeriesTab, 'Keys', 'SeriesBeg', 'MergeKeys', true,...
        'Type', 'full');
end

% remove zeros
xx = seriesTab{:, :};
xx(xx == 0) = NaN;
seriesTab{:, :} = xx;

% assert that number of columns was not changed
assert(size(seriesTab, 2) == size(stockData, 2))

