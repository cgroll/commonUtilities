function [histInfo, futureVals] = getPredInfoSets(X, y, lagWindow, futureHorizon)
% create predictor from past observations and predict multi-period future
%
% Inputs:
%   X       nObs x nVars matrix of explanatory variables
%   Y       nObs x 1 variable to be predicted. X(ii) and Y(ii) must be
%           concurrent!
%   nPastWindow     specifying how much past observations may be used to
%                   predict Y
%   nFutureHoriz    specifying how many periods should be predicted
%
% Other possible inputs:
%   - which function to compress past information: exponential weighted,
%     mean?
%   - which measure to evaluate predictive power? R^2, correlation,
%     Kendall's tau, RMSE, MAE
%


%% aggregate historic information

nExplVars = size(X, 2);
histInfo = nan(size(X));

for ii=1:nExplVars
    %histInfo(:, ii) = tsmovavg(X(:, ii), 'e', lagWindow, 1);
    histInfo(:, ii) = movingAvg(X(:, ii), lagWindow, true);
end

% skip first values without historic information
histInfo(1:(lagWindow-1), :) = []; % no -1?
y(1:(lagWindow), :) = [];

%% get future realizations

% aggregate returns
futureVals = movingAvg(y, futureHorizon, true);
futureVals = [futureVals(futureHorizon:end); futureVals(1:futureHorizon-1)];

% skip last values where NaNs occur
futureVals = futureVals(1:(end-futureHorizon+1), :);
histInfo = histInfo(1:(end-futureHorizon), :);

%% make values non-overlapping

futureVals = futureVals(1:futureHorizon:end, :);
histInfo = histInfo(1:futureHorizon:end, :);


