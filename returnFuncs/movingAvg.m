function thisMvAvg = movingAvg(dataVals, windowSize, skipWarmup)
% apply moving average to vector of data vals

% specify filter
dataWgts = 1/windowSize * ones(1, windowSize);

% apply filter
thisMvAvg = filter(dataWgts, 1, dataVals);

% treat first values as NaNs
if skipWarmup
    maxSkip = min(windowSize-1, length(thisMvAvg));
    thisMvAvg(1:maxSkip) = NaN;
end

end