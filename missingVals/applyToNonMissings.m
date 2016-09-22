function modDataVals = applyToNonMissings(func, dataVals, skipFirstCol)
% apply some function on numeric values in table
%
% Inputs:
%   func            function handle with function that works elementwise
%                   on vector of values
%   dataTab         nxm table of numeric values
%   skipFirstCol    boolean whether first column should be treated
%                   differently
%
% Outputs:
%   modDataTab      nxm table of modified numeric values

if skipFirstCol
    firstCol = dataVals(:, 1);
    dataVals = dataVals(:, 2:end);
end

dataInTable = istable(dataVals);
if dataInTable
    origTable = dataVals;
    dataVals = dataVals{:, :};
end

nCols = size(dataVals, 2);

% preallocation with NaNs
modDataVals = NaN(size(dataVals));

% apply function to cols
for ii=1:nCols
    thisColVals = dataVals(:, ii);
    
    % find non-missing values
    xxInds = ~isnan(thisColVals);
    realVals = thisColVals(xxInds);
    
    % apply function
    modVals = func(realVals);
    
    % plug values into modified table
    modDataVals(xxInds, ii) = modVals;
end

if dataInTable
    origTable{:, :} = modDataVals;
    modDataVals = origTable;
end

if skipFirstCol
    modDataVals = [firstCol, modDataVals];
end

end