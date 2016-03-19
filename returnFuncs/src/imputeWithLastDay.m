function imputedValues = imputeWithLastDay(valuesTab)
%
% Inputs:
%   values  nxm table
%
% Outputs:
%   values  nxm matrix with imputed values

% extract values
values = valuesTab{:, :};

% find missing values
missingValues = isnan(values);

% get NaNs and previous values
nRows = size(values, 2);
nansToReplace = logical([zeros(1, nRows); missingValues(2:end, :)]);
replaceWith = logical([missingValues(2:end, :); zeros(1, nRows)]);

% Replace NaN with observation of last day. 
values(nansToReplace) = values(replaceWith);

% make table again
imputedValues = embed(values, valuesTab);

end