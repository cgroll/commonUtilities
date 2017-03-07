function dateInd = hasDateCol(dataTab)
% check whether table has date / time information in first column
%
% Input:
%   dataTab         nxm table
%
% Output:
%   dateInd         boolean, whether first column fulfilles date / time
%                   patterns

%% define restrictions

% column names
allowedDateNames = {'Date'};

% value restrictions
lowBoundVal = datenum('1880-01-01');
highBoundVal = datenum('2080-01-01');

%%

dateInd = true;

%% check for numeric column

if ~isnumeric(dataTab{:, 1})
    dateInd = false;
    return;
end

%% check column name

firstColName = dataTab.Properties.VariableNames{1};

if ~ismember(firstColName, allowedDateNames)
    dateInd = false;
    return;
end

%% check for realistic values

dateVals = dataTab{:, 1};

if any(dateVals < lowBoundVal) || any(dateVals > highBoundVal)
    dateInd = false;
    return;
end

end