function anyTrue = showTrues(func, dataTab, skipFirstCol, doTranspose)
% visualize elementwise whether condition is fulfilled
%
% Inputs:
%   func            function handle to function that checks some condition
%                   elementwise for each entry
%   dataTab         nxm table of data to be checked
%   skipFirstCol    boolean, whether first column should be skipped
%   doTranspose     boolean, whether table should be transposed. Sometimes
%                   handy for tables with dates
%
% Outputs:
%   anyTrue         boolean, whether condition is fulfilled for any
%                   element at all
%
% Sideeffects:
%   graphics        visualization of condition checks

if ~exist('doTranspose', 'var')
    doTranspose = false;
end

if skipFirstCol
    % apply function to individual entries
    condFulFilled = func(dataTab{:, 2:end});
    
    % visualize
    if doTranspose
        imagesc(condFulFilled', [0 1])
        
        % make date labels
        set(gca, 'XTickLabel', datestr(dataTab.Date(get(gca, 'XTick'))))
    else
        imagesc(condFulFilled, [0 1])

        % make date labels
        set(gca, 'YTickLabel', datestr(dataTab.Date(get(gca, 'YTick'))))

    end
    
    
else
    % apply function to individual entries
    condFulFilled = func(dataTab{:, :});
    
    % visualize
    if doTranspose
        imagesc(condFulFilled', [0 1])
    else
        imagesc(condFulFilled, [0 1])
    end
end

anyTrue = any(any(condFulFilled));

end