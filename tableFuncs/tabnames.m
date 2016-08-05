function [ colnames ] = tabnames( tab )
%TABNAMES shortcut to get the column names of a table

if ~istable(tab)
    error('tabnames', ...
        'tabnames only works for tables')
end
colnames = tab.Properties.VariableNames;

end

