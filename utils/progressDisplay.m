function msgReset = progressDisplay(ii, nObs, msgReset, nSteps)
% display progress of for loop
%
% Input:
%   ii          iterator value
%   nObs        overall number of values to get percentage progress
%   msgReset    length of last display message to overwrite it
%   nSteps      each nth value will be displayed only
%
% Output:
%   msgReset    length of current display message to be able to overwrite
%               it in next iteration
%   
% Example:
%   msgReset = progressDisplay(ii, nAss, msgReset, 100);

% show progress
progressValue = ii/nObs*100;

if ~exist('nSteps', 'var')
    nSteps = 1;
end

% init old message length
if ~exist('msgReset', 'var')
    msgReset = 0;
end

if mod(ii, nSteps) == 0
    msg = ['Progress: ', num2str(progressValue), ' percent       '];
    fprintf(1, repmat('\b', 1, msgReset));
    fprintf(1, msg);
    msgReset = length(msg);
end

end