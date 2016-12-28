function imputedTab = LOCF(dataTab)
% impute missing observations with previous observations

% input table checks
assert(istable(dataTab))
assert(hasDateCol(dataTab))

% convert to fints object
xx = fints(dataTab{:, :});

% impute (LOCF)
filledFts = fillts(xx, 'zero');

% convert to matrix and then to table
xxDats = filledFts.dates;
xx = fts2mat(filledFts);
imputedTab = array2table([xxDats, xx], 'VariableNames', tabnames(dataTab));

end