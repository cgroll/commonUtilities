function writetableTS(dataTab, fname, varargin)
% write time series table to file
%
% Inputs:
%   dataTab     nxm table with time series data and dates as row names
%   fname       file name to write table to
%   varargin    additional options to pass on to writetable
%
% Output: sideeffects
%   data table written to file in .csv format

% attach row names as column
xx = [dataTab.Properties.RowNames dataTab];
xx.Properties.VariableNames = [{'Date'}, dataTab.Properties.VariableNames];

% write to disk
writetable(xx, fname, varargin{:})