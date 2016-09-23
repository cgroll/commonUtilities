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
    vicin = [vals(leftEnd:jj-1); vals(jj+1:rightEnd)];
    
    % check if current point is local extrema
    if all(vicin < vals(jj))
        locMax(jj) = true;
    end
    if all(vicin > vals(jj))
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
nExtrema = size(locExtrema, 1);
for jj=1:(nExtrema - 1)
    % get this extremum type
    thisType = locExtrema(jj, 2);
    thisExtr = vals(locExtrema(jj, 1));
    
    if thisType == 0
        % skip
    else
        % find series of this type
        equalTypesFollow = locExtrema(jj:end, 2) == thisType;
        equalTypesEnd = find(equalTypesFollow == 0, 1) - 1;
        if isempty(equalTypesEnd)
            equalTypesEnd = length(equalTypesFollow) - 1;
        end
        
        equalSeries = false(size(locExtrema(:, 1)));
        equalSeries((jj+1):(jj+equalTypesEnd - 1)) = true;
        
        % if series is not empty
        if(any(equalSeries))
            thisVals = vals(locExtrema(equalSeries, 1));
            if thisType == -1
                % is minimum?
                if ~all(thisVals > thisExtr)
                    locExtrema(jj, 2) = 0;
                else
                    locExtrema(equalSeries, 2) = 0;
                end
            elseif thisType == 1
                % is maximum?
                if ~all(thisVals < thisExtr)
                    locExtrema(jj, 2) = 0;
                else
                    locExtrema(equalSeries, 2) = 0;
                end
            end
        end
    end
end

% make last value 0 if equal to previous value
% NOTE: upper logic always checks for the next value, but modifies only current value
if nExtrema > 1
    lastTwoExtrema = find(locExtrema(:, 2) ~= 0, 2, 'last');
    if locExtrema(end, 2) == locExtrema(lastTwoExtrema(1), 2)
        locExtrema(end, 2) = 0;
    end
end

% guarantee that real extrema are alternating
xxRealExtrema = locExtrema(locExtrema(:, 2) ~= 0, :);
assert(all(abs(diff(xxRealExtrema(:, 2))) == 2), 'Real extrema must be alternating')