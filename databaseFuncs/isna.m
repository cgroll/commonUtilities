function inds = isna(vals)
%ISNA detect missing values and return logical array
%
% Default missing values:
%   ''          for strings
%   undefined   for categorical arrays
%   NaN         for numeric arrays

if iscell(vals)
    % try to convert to table -> cell entries must be of some common type
    valsTab = cell2table(vals);
    inds = ismissing(valsTab);
elseif istable(vals)
    inds = ismissing(vals);
elseif iscategorical(vals)
    inds = isundefined(vals);
elseif isnumeric(vals)
    inds = isnan(vals);
elseif ischar(vals)
    inds = isempty(vals);
else % throw error
    inputType = class(vals);
    error('isna', ['isna not defined for input of type '...
        inputType])
end
end
