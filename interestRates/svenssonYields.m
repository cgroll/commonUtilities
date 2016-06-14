function [fowRates, yields] = svenssonYields(params, maturs)
% get forward rates from Svensson model

% extract parameters
beta0 = params(1);
beta1 = params(2);
beta2 = params(3);
beta3 = params(4);
tau1 = params(5);
tau2 = params(6);

% get helping terms to reduce computational burden
term1 = maturs/tau1;
term2 = maturs/tau2;
expTerm1 = exp(-term1);
expTerm2 = exp(-term2);

% calculate forward rates elementwise
fowRates = beta0 + beta1*expTerm1 + beta2*term1.*expTerm1 + beta3*term2.*expTerm2;

% calculate continuously compounded zero-coupon yields elementwise
yields = beta0 + beta1*(1 - expTerm1)./term1 + ...
    beta2*( (1 - expTerm1)./term1 - expTerm1) +...
    beta3*( (1 - expTerm2)./term2 - expTerm2);

end