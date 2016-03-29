function joinedTableSorted = getPrices(dateBeg, dateEnd, tickerSymbs)
%
% Input:
%   dateBeg     same format as for hist_stock_data
%   dateEnd     same format as for hist_stock_data
%   tickerSymbs     1xn cell array of ticker symbol strings
%
% Output:
%   joinedTable     a mxn table of stock prices for multiple stocks, with
%                   all dates that occur in at least one stock price series
%                   and missing observations filled with NaNs. Dates are
%                   sorted ascending and stored as strings in the RowNames
%                   property of the table.

% date format
gvDateFormat = 'yyyy-mm-dd'; % TODO: define on a more global level

% init old message length
oldMsgLength = 0;

% download data
stockStructure = [];
for ii=1:length(tickerSymbs)
   currentStock = hist_stock_data(dateBeg, dateEnd, tickerSymbs{1, ii});
   stockStructure = [stockStructure currentStock];

   % show progress
   progressValue = ii/length(tickerSymbs)*100;
   msg = ['Progress: ', num2str(progressValue), ' percent       '];
   fprintf(1, repmat('\b', 1, oldMsgLength));
   fprintf(1, msg);
   oldMsgLength = length(msg);
end

% call joinStockPriceSeries
joinedTable = joinStockPriceSeries(stockStructure);

% rename Dates column
assert(strcmp(joinedTable.Properties.VariableNames{1}, 'Dates'))
joinedTable.Properties.VariableNames{1} = 'Date';

% sort with regards to time
joinedTableSorted = sortrows(joinedTable, 'Date');

% convert dates to default date string format
xx = datenum(joinedTableSorted{:, 'Date'});
dats = datestr(xx, gvDateFormat);

% move dates to row names
joinedTableSorted(:, 'Date') = [];
joinedTableSorted.Properties.RowNames = cellstr(dats);

end

