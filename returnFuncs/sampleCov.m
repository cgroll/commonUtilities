function covMatr = sampleCov(data, covLambdaVal, meanLambdaVal)
% exponentially weighted sample covariance

[nObs, nAss] = size(data);

% get weights
powVec    = (nObs-1 : -1 : 0)';
wgts = covLambdaVal.^powVec;
wgts = wgts / sum(wgts);

% get sample mean
mus = sampleMean(data, meanLambdaVal);

% adjust observations for mean value
zeroMeanData = data - repmat(mus, nObs, 1);

% set NaNs to zero
zeroMeanData(isnan(zeroMeanData)) = 0;

% compute EWMA covariance matrix
covMatr = zeroMeanData' * (zeroMeanData .* repmat(wgts, 1, nAss));

% enforce numerical symmetry
covMatr = 0.5 * (covMatr + covMatr');

