function [bestVols, newCash, newWgts, cashDrain] = realizeWgts(targetWgts, currETFVols, currPrices, cashVal)
% realize given target weights as closely as possible
%
% Inputs:
%   targetWgts      1xnAss vector of target weights (including cash)
%   currETFVols     1xnEtfs vector of current ETF volumes
%   currPrices      1xnEtfs vector of current ETF prices
%   cashVal         scalar value with current cash
%
% Outputs:
%   bestVols        1xnEtfs vector of best ETF volumes
%   newCash         scalar value with new cash
%   newWgts         1xnAss vector of weights

%% get optimal single weights

bestVols = realizeSingleWeights(targetWgts, currETFVols, currPrices, cashVal);

% get new cash value / portfolio value associated with target volumes
[tradeBalance, tradeCosts] = getTradeEffects(currETFVols, bestVols, currPrices);

newCash = updateCash(cashVal, tradeBalance, tradeCosts);

%% create cash if first proposal is negative
% - cash MUST be higher than required

if newCash < 0
    bestVols = createCash(targetWgts, currETFVols, bestVols, currPrices, cashVal);    
end

%% further adapt weights for joint optimality
% - cash SHOULD not be too high

bestVols = burnCash(targetWgts, currETFVols, bestVols, currPrices, cashVal);

%% get associated cash value and weights

[newWgts, newCash, cashDrain] = getNewWgts(currETFVols, bestVols, currPrices, cashVal);
