function joinedTable = joinMultipleTables(cellOfTables, joinKeys)
%
% Input:
%   cellOfTables    1xn cell array with tables in the individual entries
%   joinKeys        string or 1xm cell array of merge keys
%
% Output:
%   joinedTable     single table with single dates column and one column
%                   for each stock. Individual stock tables should be
%                   combined with outer join. 

nTables = length(cellOfTables);

joinedTable = cellOfTables{1, 1};
for ii=2:nTables
    joinedTable = outerjoin(joinedTable, cellOfTables{1, ii},...
        'Key', joinKeys, 'MergeKeys', true, 'Type', 'full');
end

end