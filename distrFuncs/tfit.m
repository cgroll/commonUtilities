function nuHat = tfit(data)
% fit Student's t distribution to data
%
% Inputs:
%   data    nx1 vector of data
%
% Outputs:
%   nuHat   scalar value representing the estimated parameter

% specify optimization values
nuStart = 4;
nuLow = 1.2;
nuUp = 10000;

% define anonymous function
nllh = @(x)-sum(log(tpdf(data, x)));

% optimize parameter
nuHat = fmincon(nllh, nuStart, [], [], [], [], nuLow, nuUp);

end

