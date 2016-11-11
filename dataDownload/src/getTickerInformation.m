function allCompInfo = getTickerInformation(tickers, requFields, blockSize, fieldNames)

nAss = numel(tickers);

% not possible to download information for all tickers at once
if ~exist('fieldNames', 'var')
    fieldNames = {'Ticker', 'CCY', 'StockExchange', 'CompName'};
end
if ~exist('blockSize', 'var')
    blockSize = 100;
end
nReps = ceil(nAss/blockSize);

for ii=1:nReps
    % get ticker symbols in current block
    maxEnd = min(ii*blockSize, nAss);
    
    % make string for ticker symbols
    tickSymSequ = strjoin(tickers(((ii-1)*blockSize + 1):maxEnd), '+');
    
    % download data from yahoo
    [temp, status] = urlread(strcat('http://finance.yahoo.com/d/quotes.csv?s=',...
        tickSymSequ, '&f=', requFields));
    
    % process data
    if length(fieldNames) == 4
        xx = textscan(temp, '%q%q%q%q','delimiter',',');
        compInfo = table(xx{1, 1}, xx{1, 2}, xx{1, 3}, xx{1, 4}, 'VariableNames', ...
            fieldNames);
    elseif length(fieldNames) == 5
        xx = textscan(temp, '%q%q%q%q%q','delimiter',',');
        compInfo = table(xx{1, 1}, xx{1, 2}, xx{1, 3}, xx{1, 4}, xx{1, 5}, 'VariableNames', ...
            fieldNames);
    end

    if ii == 1
        allCompInfo = compInfo;
    else
        allCompInfo = [allCompInfo; compInfo];
    end

end