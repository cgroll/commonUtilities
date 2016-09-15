function imputedValues = imputeWithLastDay(values)
%
% Inputs:
%   values  nxm matrix
%
% Outputs:
%   values  nxm matrix with imputed values

% find missing values
missingValues = isnan(values);

% get NaNs and previous values
nRows = size(values, 2);
nansToReplace = logical([zeros(1, nRows); missingValues(2:end, :)]);
replaceWith = logical([missingValues(2:end, :); zeros(1, nRows)]);

% Replace NaN with observation of last day. 
values(nansToReplace) = values(replaceWith);

imputedValues = values;

end