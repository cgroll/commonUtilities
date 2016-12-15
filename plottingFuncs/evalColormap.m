function colors = evalColormap(vals, cmap, cbounds)
% evaluate the current colormap for some given values

% get colors used by colormap
if ~exist('cmap', 'var')
    usedColors = colormap();
else
    usedColors = colormap(cmap);
    close;
end

% get or set color mapping range
if ~exist('cbounds', 'var')
    cbounds = caxis;
end

% get number of used colors
nColors = size(usedColors, 1);

% interpolate values in color function
xx = interp1(linspace(cbounds(1), cbounds(2), nColors), 1:nColors, vals);
xx(vals > cbounds(2)) = nColors;
xx(vals < cbounds(1)) = 1;
xx(isnan(xx)) = 1;
colorInds = round(xx);

colors = usedColors(colorInds, :);

end