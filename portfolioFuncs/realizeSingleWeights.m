function targetVols = realizeSingleWeights(targetWgts, currETFVols, currPrices, cashVal)
% find optimal volumes for individual ETFs
%
% Inputs:
%   targetWgts      1xnAss vector of target weights including cash
%   currETFVols     1xnEtf vector of current volumes including cash
%   currPrices      1xnEtf vector of current ETF prices
%   cashVal         scalar value of current cash
%
% Outputs:
%   targetVols      1xnEtf vector of optimal ETF volumes
%
% Note: only problem is that trading might effect the overall portfolio
% value through cash drains / inflows. Hence, multiple iterations are
% required to get best volumes for each ETF.

% define maximum number of iterations
nIterMax = 10;
iterCounter = 0;

% get portfolio value
etfVols = currETFVols;
pfVal = sum(currPrices .* etfVols) + cashVal;

% init stopping indicator
stabilizedVols = false;

previousVols = etfVols;
while ~stabilizedVols % optimal volumes keep changing
    
    % get desired cash amount per ETF
    desiredAmount = pfVal .* targetWgts(2:end);
    
    % get optimal amount of ETFs
    targetVols = round(desiredAmount ./ currPrices);

    iterCounter = iterCounter + 1;
    if all(previousVols == targetVols) | (iterCounter == nIterMax)
        stabilizedVols = true;
    else
        % get associated trading effects
        [tradeBalance, tradeCosts] = getTradeEffects(etfVols, targetVols, currPrices);
        
        % get new cash value
        newCash = updateCash(cashVal, tradeBalance, tradeCosts);
        
        % get new portfolio value
        pfVal = sum(currPrices .* targetVols) + newCash;
        
        previousVols = targetVols;
    end

end