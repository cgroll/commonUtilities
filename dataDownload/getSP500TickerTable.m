function getSP500TickerTable(relOutPath)
% download SP500 component table from Wikipedia
%
% Inputs:
%   relOutPath      string, relative path to output file
%
% Output: side-effects
%   Table stored under given file name, output folders created if
%   non-existent before.

%% download SP500 ticker table

wikiUrl = 'http://en.wikipedia.org/wiki/List_of_S%26P_500_companies';
htmlContent = webread(wikiUrl);

%% get part comprising SP500 components table

startInd = regexp(htmlContent, '<table .*?>', 'start', 'all');
spComponentsHtmlTable = htmlContent(startInd(1):startInd(2)-1);

%% get header names

% get content between <th> and </th>
tableHeaderHtml = regexp(spComponentsHtmlTable, ...
    '<th>(.*?)</th>', 'tokens', 'all');

% preallocation
nCols = size(tableHeaderHtml, 2);
colNames = cell(nCols, 1);

for ii=1:nCols
    % remove hyperlink text
    xx = rmHyperlink(tableHeaderHtml{ii});
    
    % make valid column name
    colNames{ii} = strrep(xx, ' ', '_');
end

%% get table entries

% get table body: everything after </th> tags
tableBody = regexp(spComponentsHtmlTable, ...
    '<th>.*?</th>(.*)', 'tokens', 'all');

% get individual table rows: between <tr> and </tr>
tableRowsHtml = regexp(tableBody{1}{1}, ...
    '<tr>(.*?)</tr>', 'tokens', 'all');

% preallocate output
nRows = size(tableRowsHtml, 2);
tableEntries = cell(nRows, nCols);

for ii=1:size(tableRowsHtml, 2)
    % get content between <td> and </td>
    thisRowEntries = regexp(tableRowsHtml{ii}{1}, ...
        '<td>(.*?)</td>', 'tokens', 'all');
    for jj=1:nCols
        % remove hyperlinks
        tableEntries{ii, jj} = rmHyperlink(thisRowEntries{jj});
    end
end

% rename columns
tickerSymbs = cell2table(tableEntries);
tickerSymbs.Properties.VariableNames = colNames;

% get relevant columns only
sp500IndustryAffiliations = tickerSymbs(:, {'Ticker_symbol', ...
    'Security', 'GICS_Sector', 'GICS_Sub_Industry'});

%% generate path to output file

[outputDir, ~, ~] = fileparts(relOutPath);

% ensure that output directory exists
if ~exist(outputDir, 'dir'); mkdir(outputDir); end

%% save to disk

writetable(sp500IndustryAffiliations, relOutPath)

end