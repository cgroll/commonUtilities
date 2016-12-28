function mus = sampleMean(data, lambdaVal)
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

% get weighted observations
wgtedObs = repmat(wgts, 1, nAss) .* data;

% get weighted sample means
mus = sum(wgtedObs, 'omitnan');
