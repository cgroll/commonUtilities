function fullTab = vcatUnequalTables(tab1, tab2)
% appending table with subset of columns
%
% Inputs:
%   tab1    nxm table
%   tab2    lxk table, k<m
%
% Outputs:
%   fullTab     (n+l)xm table
%
% Remarks:
% - columns of tab2 must be subset of columns of tab1
% - column sorting will be given by larger table tab1

% check if all columns of table 2 do occur in table 1
if all(ismember(tabnames(tab2), tabnames(tab1))) == false
    notSubSetInds = ~ismember(tabnames(tab2), tabnames(tab1));
    error('vcatUnequalTables',...
            'Columns of table 2 must be subset of table 1')
end

% preallocate new table with full number of columns
nObs = size(tab2, 1);
nVars = size(tab1, 2);

bigTab2 = array2table(NaN(nObs, nVars), 'VariableNames', tabnames(tab1));

colNames = tabnames(tab1);
for ii=1:nVars
    thisCol = colNames(ii);

    if ismember(thisCol, tabnames(tab2))
        % get values, if column exists in tab2
        bigTab2(:, thisCol) = tab2(:, thisCol);
    end
end

% append table
fullTab = [tab1; bigTab2];

end




