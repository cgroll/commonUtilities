function newCash = updateCash(currCash, tradeBalance, tradeCosts)
% update cash after trading

newCash = currCash + tradeBalance - tradeCosts;

end