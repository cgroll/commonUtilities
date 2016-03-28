function plotTable(tableToPlot, varargin)
% plot table with time series data as row names
%
% Inputs:
%   tableToPlot     nxm table with dates as row names

% convert strings to numeric dates
serialDates = datenum(tableToPlot.Properties.RowNames);

% plot with dates on x axis
plot(serialDates, tableToPlot{:, :}, varargin{:})
datetick 'x'

end