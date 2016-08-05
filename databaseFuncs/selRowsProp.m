function [subTable] = selRowsProp(dataTable, colName, value)
%SELECTROWSPROP select all rows that match a given property
%
% REMARK: matching properties is different to matching keys! Matching keys
% will return a single row per key, keeping to sequential order of input
% keys. Matching properties will test the property one row at a time, and
% hence the sequential order of the selected rows will be with increasing
% row index, not matching any sequence given by input properties.
%
% Usage: 
%      selRowsProp(DATA.JointConstraints, 'JointConstraintID', {'J1', 'J2'})  
%
% Inputs:
%   dataTable       data as table
%   colName         string of column name
%   value           value to match, cell array for multiple string values

colVals = dataTable.(colName);
rowInds = ismember(colVals, value);
subTable = dataTable(rowInds, :);

end

