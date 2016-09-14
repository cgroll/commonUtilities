function [bestVols, newCash, newWgts] = realizeWgts(targetWgts, currVols, currPrices, cashVal)
% realize given target weights as closely as possible
%
% Inputs:
%   targetWgts      1xnAss vector of target weights (including cash)
%   currVols        1xnEtfs vector of current ETF volumes
%   currPrices      1xnEtfs vector of current ETF prices
%   cashVal         scalar value with current cash
%
% Outputs:
%   bestVols        1xnEtfs vector of best ETF volumes
%   newCash         scalar value with new cash
%   newWgts         1xnAss vector of weights

%% get optimal single weights

targetVols = realizeSingleWeights(targetWgts, currVols, currPrices);

% get new cash value / portfolio value associated with target volumes
[tradeBalance, tradeCosts] = getTradeEffects(currVols(2:end), targetVols, currPrices);

newCash = updateCash(currVols(1), tradeBalance, tradeCosts);
newPfVal = newCash + sum(targetVols .* currPrices);

wgts = [newCash, targetVols.*currPrices]./newPfVal;

%% create cash if first proposal is negative

if newCash < 0
    bestVols = createCash(targetWgts, currVols(2:end), targetVols, currPrices, currVols(1))
    
    % get associated weights
    newWgts = getNewWgts(currVols(2:end), bestVols, currPrices, currVols(1))
    
end

%% further adapt weights for joint optimality
% - cash MUST be higher than required
% - cash SHOULD not be too high

optSingleWgtLoss = sum((wgts - targetWgts).^2);

bestVols = burnCash(targetWgts, currVols(2:end), targetVols, currPrices, currVols(1))
