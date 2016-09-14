function bestVols = burnCash(targetWgts, currVols, bestVols, currPrices, cashVal)
% realize target weights more efficiently by spending additional cash

%% get current weight deviation loss

% get current weights
pfVal = sum(bestVols .* currPrices) + cashVal;
wgts = [cashVal, bestVols .* currPrices]./pfVal;

% require as benchmark
optSingleWgtLoss = sum((wgts - targetWgts).^2);

%% get weight deviation losses for ETF modifications

nEtfs = numel(currVols);
modWgtLoss = zeros(1, nEtfs);

improvementPossible = true;

while improvementPossible
    
    for ii=1:nEtfs
        % buy one more ETF
        modifiedVols = bestVols;
        modifiedVols(ii) = modifiedVols(ii) + 1;
        
        % get associated weights
        newWgts = getNewWgts(currVols, modifiedVols, currPrices, cashVal);
        
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
            bestVols(I) = bestVols(I) + 1;
        else
            improvementPossible = false;
        end
    end

end