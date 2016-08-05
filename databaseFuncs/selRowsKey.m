function [subTable] = selRowsKey(dataTable, colName, key)
%SELECTROWSKEY select all rows that match a given key
%
% REMARK: matching properties is different to matching keys! Matching keys
% will return a single row per key, keeping to sequential order of input
% keys. Matching properties will test the property one row at a time, and
% hence the sequential order of the selected rows will be with increasing
% row index, not matching any sequence given by input properties.
%
% Usage: 
%      selRowsKey(DATA.JointConstraints, 'JointConstraintID', {'J1', 'J2'})  
%
% Inputs:
%   dataTable       data as table
%   colName         string of column name
%   value           value to match, cell array for multiple string values

% % check that no entry in key is a missing value
% if any(isna(key))
%     error('selRowsKey:missingKey',...
%         'Keys may not represent missing values.')
% end

% check if column name occurs in table
colNames = tabnames(dataTable);
if ~ismember(colNames, colName)
    error('selRowsKey:wrongColumn',...
        'The given column does not exist in the table')
end

inds = findInKeys(key, dataTable.(colName));

% % create map container from given column and indices
% keyMap = containers.Map(dataTable.(colName), ...
%     [1:size(dataTable, 1)]);
% 
% inds = [];
% if iscategorical(key)
%     xx = cellstr(key);
%     cellVals = values(keyMap, xx);
%     inds = cell2mat(cellVals);
% elseif iscell(key)
%     % get rows for given keys
%     cellVals = values(keyMap, key);
%     inds = cell2mat(cellVals);
% else
%     inds = keyMap(key);
% end

subTable = dataTable(inds, :);

end

