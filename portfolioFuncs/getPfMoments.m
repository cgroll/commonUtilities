function [pfMus, pfVariances, pfSigmas] = getPfMoments(wgts, mus, covs)
% get portfolio moments for possibly multiple weights
%
% Inputs:
%   wgts    weight vector or matrix of weights per row
%   mus     vector of asset mus
%   covs    covariance matrix for assets
%
% Outputs:
%   pfMus           portfolio mu
%   pfVariances     portfolio variance
%   pfSigmas        portfolio standard deviation

% get number of assets
nAss = size(covs, 1);

assert(nAss == size(covs, 2), 'Covariance matrix must be square matrix')
assert(nAss == numel(mus), 'One mu per asset required')
assert(isvector(mus), 'Mus must be a vector')

% make column vector
mus = mus(:);

if isvector(wgts)
    assert(nAss == numel(wgts), 'One weight per asset required')
    wgts = wgts(:)'; % make row vector
else
    assert(nAss == size(wgts, 2), 'Weights must have columns equal to number of assets')
end

% get portfolio mus
pfMus = wgts * mus;

% get portfolio variances
xxFirst = wgts * covs; % row vector for each weights
pfVariances = sum(xxFirst .* wgts, 2);

pfSigmas = sqrt(pfVariances);

end