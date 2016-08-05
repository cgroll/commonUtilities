function tab = tableFillNaN(tab, fillVal, firstCol, lastCol)
% replace NaN entries within numeric columns of table
%
% Input:
%   tab         table with NaNs to be replaced
%   fillVal     value to replace NaNs with (most likely: 0)
%   firstCol    index of first column where NaNs need to be replaced
%   lastCol     index of last column where NaNs need to be replaced; if
%               empty, automatically take last column
%
% Output:
%   filledTab   table without NaNs in respective columns
%
% Notes:
%   This function is useful when tables are transformed from long to wide
%   format. There you get a lot of NaNs for entries that were missing in
%   long format, and sometimes it makes sense to fill them with zeros
%   instead.


% extract numeric columns
if exist('lastCol', 'var')
    xx = tab{:, firstCol:lastCol};
else
    xx = tab{:, firstCol:end};
end

% replace values
xx(isnan(xx)) = fillVal;

if exist('lastCol', 'var')
    tab{:, firstCol:lastCol} = xx;
else
    tab{:, firstCol:end} = xx;
end

end