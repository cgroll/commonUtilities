function res = findMod(replacer, varargin)
% modification of find to deal with empty output
%
% Input:
%   replacer        string, indicating what value should be returned if
%                   original "find" function returns empty array
%   varargin        usual inputs to function "find"
%
% Output:
%   res             output of "find", possibly modified when it was empty

% apply usual find function
res = find(varargin{:});

% modify output if no true was existent
if isempty(res)
    switch replacer
        case 'NaN'
            res = NaN;
        case 'LastIndex'
            xx = varargin{1};
            res = length(xx);
        case 'Zero'
            res = 0;
    end
end