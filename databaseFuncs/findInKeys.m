function indsOutput = findInKeys(vals, keyVals)
%FINDINKEYS find vals in key array, return indices
%
% Idea: 
%   vals 
%   - may have duplicate values
%   - may have missing values
%   - missing values NEVER match but return NaN
%   keyVals:
%   - may have missing values
%   - must NOT have duplicate values
%   - missing values may be returned as matching key

% transform character strings to cell
if ischar(vals)
    vals = {vals};
end

if ischar(keyVals)
    keyVals = {keyVals};
end

% get indices of not missing keys
indsNotMissingKeys = find(~isna(keyVals));
keysNotMissing = keyVals(indsNotMissingKeys);

% get indices of non-missing values
indsNotMissingVals = find(~isna(vals));
valsNotMissing = vals(indsNotMissingVals);

% non-missing key values must be unique
nUnique = length(unique(keysNotMissing));
if length(keysNotMissing) ~= nUnique
    error('findInKeys:nonuniqueKeys',...
        'Given keys do not have unique key values.')
end

% create non-missing key mapping:
% index non-missing keys -> index original key array
indexMapKeys = containers.Map(1:length(indsNotMissingKeys), ...
    indsNotMissingKeys);

% create non-missing value mapping
% index non-missing values -> index original value array
%indexMapVals = containers.Map(1:length(indsNotMissingVals), ...
%    indsNotMissingVals);

% create map container on non-missing keys
keyMap = containers.Map(keysNotMissing, ...
    [1:length(keysNotMissing)]);

% now we have the following mapping:
% key -> index within non-missing keys -> index within original vector
% (with missing values)

% get indices for non-missing keys
if iscategorical(valsNotMissing)
    xx = cellstr(valsNotMissing);
    try
        cellVals = values(keyMap, xx);
    catch ME
        % find values not found in keys
        notFound = valsNotMissing(~ismember(xx, keysNotMissing));
        error('findInKeys:keyNotFound',...
            'Some values are not found')
    end
    indsNoMissing = cell2mat(cellVals);
elseif iscell(valsNotMissing)
    % get rows for given keys
    try
        cellVals = values(keyMap, valsNotMissing);
    catch ME
        % find values not found in keys
        notFound = valsNotMissing(~ismember(valsNotMissing, keysNotMissing));
        error('findInKeys:keyNotFound',...
            'Some values are not found')
    end
    indsNoMissing = cell2mat(cellVals);
elseif isnumeric(valsNotMissing)
    try
        cellVals = values(keyMap, num2cell(valsNotMissing));
    catch ME
        % find values not found in keys
        notFound = valsNotMissing(~ismember(valsNotMissing, keysNotMissing));
        error('findInKeys:keyNotFound',...
            'Some values are not found')
    end
    indsNoMissing = cell2mat(cellVals);
else
    try
        indsNoMissing = keyMap(valsNotMissing);
    catch ME
        % find values not found in keys
        notFound = valsNotMissing(~ismember(valsNotMissing, keysNotMissing));
        error('findInKeys:keyNotFound',...
            'Some values are not found')
    end
end
%indsNoMissing = values(keyMap, valsNotMissing);

% transform to indices for original keys with missing values
inds = cell2mat(values(indexMapKeys, num2cell(indsNoMissing)));

% preallocation 
indsOutput = NaN(size(vals));

% insert matching indices at respective entries
indsOutput(indsNotMissingVals) = inds;

end
