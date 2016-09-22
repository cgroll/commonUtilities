function seriesTab = findSeries(seriesInd, rets, skipInitNaNs)
% for example, find series of zero returns

if skipInitNaNs
    rets = cutOffInitNaNs(rets, true);
end

% extract values
retVals = rets{:, 2};
dats = rets{:, 1};

% extract data name
assName = tabnames(rets(:, 2));

% check condition
switch seriesInd
    case 'Zeros'
        condInd = retVals == 0;
    case 'ZerosNaNs'
        condInd = retVals == 0 | isnan(retVals);
    case 'NaNs'
        condInd = isnan(retVals);
end

condInd = [false; condInd; false];

% get sequence changes
changes = diff(condInd);

% get beginnings and endings of sequences
xxEnd = find(changes == -1) ;
xxBeg = find(changes == 1);

if isempty(xxBeg)
    seriesTab = [];
else
    % get series length
    seriesLen = xxEnd - xxBeg;
    
    % put together in table
    seriesTab = table(dats(xxBeg), dats(xxEnd-1), seriesLen, ...
        'VariableNames', {'SeriesBeg', 'SeriesEnd', assName{1}});
end
end