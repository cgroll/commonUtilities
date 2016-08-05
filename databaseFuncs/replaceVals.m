function origVals = replaceVals(origVals, mappingTable, keyCol, valueCol)
% replace values given in origVals through values that can be looked up in
% a given mapping table
%
% origVals may contain missing values

% find original values in keys table
indsWithNaNs = findInKeys(origVals, mappingTable.(keyCol));

% drop NaNs
inds = indsWithNaNs(~isna(indsWithNaNs));

% find non-missing indices of origVals
insertInds = ~isna(origVals);

% test if new values are of same type as old values
newVals = mappingTable.(valueCol)(inds);
if strcmp(class(newVals), class(origVals))
    origVals(insertInds) = newVals;
else
    % create new emtpy array of same type
    if isnumeric(newVals)
        origVals = NaN(length(origVals), 1);
        origVals(insertInds) = newVals;
    elseif iscategorical(newVals)
        origVals = categorical(cellstr(repmat({''}, length(origVals), 1)));
        origVals(insertInds) = newVals;
    end
end

end

