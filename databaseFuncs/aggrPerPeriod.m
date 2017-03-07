function aggrTab = aggrPerPeriod(dataTab, freq, aggrFunc, scalingFactor)
% aggregate observations per time period
%
% Inputs:
%   dataTab         nx(m+1) table with dates in first column
%   
%
% Outputs:
%   

if exist('scalingFactor', 'var') == false
    scalingFactor = [];
end

dateInd = hasDateCol(dataTab);

if ~dateInd
    error('aggrPerPeriod:noDateColumnFound', ...
        'The table provided must have a date column')
end

dats = dataTab.Date;
varNames = tabnames(dataTab(:, 2:end));

switch freq
    case 'weekly'
        
    case 'monthly'
        
    case 'quarterly'
        
    case 'yearly'
        
        % aggregate per year
        xxOnes = ones(size(dats));
        dataTab.Date = datenum(year(dats), 12*xxOnes, 31*xxOnes);
end

% do actual grouping
aggrTab = grpstats(dataTab, 'Date', aggrFunc);

% fix metadata
grpCount = aggrTab.GroupCount;
aggrTab.GroupCount = [];
aggrTab.Properties.VariableNames(2:end) = varNames;
aggrTab = sortrows(aggrTab, 'Date');
aggrTab.Properties.RowNames = {};

% apply scaling
if ~isempty(scalingFactor)
    xx = aggrTab{:, 2:end};
    xx = scalingFactor * xx;
    aggrTab{:, 2:end} = xx;
end
    

end