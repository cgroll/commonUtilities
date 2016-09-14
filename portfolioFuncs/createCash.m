function bestVols = createCash(targetWgts, currVols, bestVols, currPrices, cashVal)
% realize target weights by guaranteeing positive cash value

%% get weight deviation losses for ETF modifications

nEtfs = numel(currVols);
modWgtLoss = zeros(1, nEtfs);

improvementRequired = true;

while improvementRequired
    isNegativeCash = true(1, nEtfs);
    
    for ii=1:nEtfs
        % buy one more ETF
        modifiedVols = bestVols;
        modifiedVols(ii) = modifiedVols(ii) - 1;
        
        % get associated weights
        newWgts = getNewWgts(currVols, modifiedVols, currPrices, cashVal);
        
        % check whether cash is still negative
        if newWgts(1) > 0
            isNegativeCash(ii) = false;
        end
        
        % get associated weight loss
        modWgtLoss(ii) = sum((newWgts - targetWgts).^2);
    end
    
    % find minimum loss function
    [~, I] = min(modWgtLoss);
    
    % conduct modification
    bestVols(I) = bestVols(I) - 1;
    
    % check whether sufficient cash
    if ~isNegativeCash(I)
        improvementRequired = false;
    end

end