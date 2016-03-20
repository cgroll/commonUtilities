function dataTab = readtableTS(fname, varargin)
% read time series table from file
%
% Inputs:
%   fname       file name to write table to
%   varargin    additional options to pass on to writetable
%
% Output: sideeffects
%   dataTab     nxm table with time series data with dates in first row

% read data from disk
dataTab = readtable(fname, varargin{:});

% move dates to row names
dats = dataTab.Date;
dataTab(:, 'Date') = [];
dataTab.Properties.RowNames = cellstr(dats);