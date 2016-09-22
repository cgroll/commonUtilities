function locExtrema = getLocalExtrema(vals, localWidth)
% get local extrema for price series
%
% Inputs:
%   vals            vector of values
%   localWidth      must be extra withhin localWidth in both sides (overall
%                   vicinity has width 2*localWidth)
%
% Output:
%   locExtrema      nExtrx2 matrix of extrema locations and type:
%                   1: max, -1: min, 0: local extrema were not alternating
%   

% pre-allocation
locMax = false(length(vals), 1);
locMin = false(length(vals), 1);

% for each point
for jj=1:length(vals)
    % get capped vicinity to left
    leftEnd = jj-localWidth;
    if leftEnd < 1
        leftEnd = 1;
    end
    
    % get capped vicinity to right
    rightEnd = jj+localWidth;
    if rightEnd > length(vals)
        rightEnd = length(vals);
    end
    vicin = vals(leftEnd:rightEnd);
    
    % check if current point is local extrema
    if all(vicin <= vals(jj))
        locMax(jj) = true;
    end
    if all(vicin >= vals(jj))
        locMin(jj) = true;
    end
end

% store local minima with location and indicator value -1
locMin = find(locMin);
locMin = [locMin, -1*ones(numel(locMin), 1)];

% store local maxima with location and indicator value 1
locMax = find(locMax);
locMax = [locMax, ones(numel(locMax), 1)];

% get all extrema
locExtrema = [locMin; locMax];
locExtrema = sortrows(locExtrema);

% remove consecutive extrema of equal type
for jj=2:size(locExtrema, 1)
    if locExtrema(jj, 2) == locExtrema(jj-1, 2) % both extrema of same type
        
        % if both are minima
        if locExtrema(jj, 2) == -1
            % only keep smaller one
            if vals(locExtrema(jj, 1)) < vals(locExtrema(jj-1, 1))
                locExtrema(jj-1, 2) = 0;
            else
                locExtrema(jj, 2) = 0;
            end
            
            % if both are maxima
        elseif locExtrema(jj, 2) == 1
            if vals(locExtrema(jj, 1)) > vals(locExtrema(jj-1, 1))
                locExtrema(jj-1, 2) = 0;
            else
                locExtrema(jj, 2) = 0;
            end
        end
    end
end