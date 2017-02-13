function ewmaStds = sampleStd(data, lambdaVal)
% exponentially weighted sample mean
%
% Inputs:
%   data        nObs x nAss vector of historic observations
%   lambdaVal   scalar value to determine exponential weighting

[nObs, nAss] = size(data);

% get weights
powVec    = (nObs-1 : -1 : 0)';
wgts = lambdaVal.^powVec;
wgts = wgts / sum(wgts);

% adjust observations for mean value
mus = mean(data, 'omitnan');
zeroMeanData = data - repmat(mus, nObs, 1);

% set NaNs to zero
zeroMeanData(isnan(zeroMeanData)) = 0;

ewmaStds = sum(zeroMeanData .* zeroMeanData .* repmat(wgts, 1, nAss));
