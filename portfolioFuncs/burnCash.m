function bestETFVols = burnCash(targetWgts, currETFVols, bestETFVols, currPrices, cashVal)
% realize target weights more efficiently by spending additional cash

%% get current weight deviation loss

% get current weights
pfVal = sum(bestETFVols .* currPrices) + cashVal;
wgts = [cashVal, bestETFVols .* currPrices]./pfVal;

% require as benchmark
optSingleWgtLoss = sum((wgts - targetWgts).^2);

%% get weight deviation losses for ETF modifications

nEtfs = numel(currETFVols);
modWgtLoss = zeros(1, nEtfs);

improvementPossible = true;

while improvementPossible
    
    for ii=1:nEtfs
        % buy one more ETF
        modifiedVols = bestETFVols;
        modifiedVols(ii) = modifiedVols(ii) + 1;
        
        % get associated weights
        [newWgts, ~] = getNewWgts(currETFVols, modifiedVols, currPrices, cashVal);
        
        if newWgts(1) < 0
            modWgtLoss(ii) = inf;
        else
            % get associated weight loss
            modWgtLoss(ii) = sum((newWgts - targetWgts).^2);
        end
    end
    
    % find minimum
    [~, I] = min(modWgtLoss);
    
    % check whether sufficient cash
    if isinf(modWgtLoss(I))
        improvementPossible = false;
    else
    
        %% conduct modification
        if modWgtLoss(I) < optSingleWgtLoss
            bestETFVols(I) = bestETFVols(I) + 1;
        else
            improvementPossible = false;
        end
    end

end