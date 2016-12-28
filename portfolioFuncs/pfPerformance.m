function [pfRets, pfPerf] = pfPerformance(wgts, discPrices, dates)
% get portfolio returns and performance from weights and prices
%
% Inputs:
%   wgts            nObs x nAss matrix or table of weights
%   discPrices      nObs2 x nAss table of prices
%   dates           nObs x 1 vector of dates if wgts are matrix
%
% Outputs:
%   

% if weights are matrix, dates have to be existent
if ismatrix(wgts)
    if exist('dates', 'var') == false
        error('portfolioFuncs:pfPerformance', 'Dates need to be given for weights')
    else
        
    end
else % wgts as table
    assert(hasDateCol(wgts))
    dates = wgts.Date;
    wgts = wgts{:, 2:end};
end
    
% pick prices at required dates
relevantPrices = selRowsKey(discPrices, 'Date', dates);

% get discrete asset returns
relevantRets = price2retWithHolidays(relevantPrices, true);
relevantRets{:, 2:end} = exp(relevantRets{:, 2:end}) - 1;

% skip last wgts entry
wgts = wgts(1:end-1, :);

% calculate portfolio returns and performance
pfRets = sum(wgts .* relevantRets{:, 2:end}, 2);
%pfRets(isnan(pfRets)) = 0;
pfPerf = [1; cumprod(pfRets + 1)];

end
