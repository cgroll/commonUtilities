function [tradeBalance, tradeCosts] = getTradeEffects(initVols, newVols, currPrices)
% get side effects for ETF volume changes
%
% Inputs:
%   initVols    1xnAss vector of initial volumes
%   newVols     1xnAss vector of new volumes
%   currPrices  1xnAss vector of current prices
%
% Outputs:
%   tradeBalance    income sold ETFs - costs bought ETFs
%   tradeCosts      trading costs for ETF changes
%   taxEffects      tax effects associated with trading
%   tradeCount      number of assets touched

%% get trade balance

deltaSell = initVols - newVols;
tradeBalance = sum(deltaSell .* currPrices);

%% get transaction costs
% relative or absolute
transactionCostType = 'absolute';
transactionCosts = 0.55; % in Euros
transactionCosts = 0.001;

% transactionCostType = 'relative';
% transactionCosts = 0.005; % in percentage points

switch transactionCostType
    case 'absolute' % internal bank rates
        % find changed positions
        touchedPositions = deltaSell ~= 0;
        
        % pay fix amount per changed position
        tradeCosts = sum(touchedPositions .* transactionCosts);
        
    case 'relative' % stock exchange rates
        % get money changes
        deltaAmounts = abs(deltaSell) .* currPrices;
        
        % pay fix percentage per trading volume
        tradeCosts = deltaAmounts .* transactionCosts;
        
end

%% get tax effects




end

