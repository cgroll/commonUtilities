function wgts = checkWgts(wgts)

wgtTol = 1e-6;

if any(any(wgts > 1+wgtTol))
    error('commonUtils:checkWgts', 'Some weight larger than 1')
end
if any(any(wgts < 0-wgtTol))
    error('commonUtils:checkWgts', 'Some weight is smaller than 0')
end
if any(sum(wgts, 2) > 1+wgtTol)
    error('commonUtils:checkWgts', 'Total weights are larger than 1')
end

wgts(wgts < 0) = 0;
wgts(wgts > 1) = 1;
wgts = wgts ./ repmat(sum(wgts, 2), 1, size(wgts, 2));
