function exportFig(h, figName, projPath, fmt, closeInd, rescaleInd)
% save figure unchanged to cd-subfolder /pics with given format
%
% Inputs:
%   h           figure handle
%   figName     file name (no path, no extension) of figure
%   projPath    path to picture directory; current directory if empty
%   fmt         figure format: eps | png
%   closeInd    indicator whether figure shall be closed after export
%   rescaleInd  indicator whether figure should be re-scaled to absolute
%               target size

%% treat optional inputs

if ~exist('projPath', 'var')
    projPath = './';
end

if ~exist('fmt', 'var')
    fmt = 'eps';
end

if ~exist('closeInd', 'var')
    closeInd = true;
end

if ~exist('rescaleInd', 'var')
    rescaleInd = true;
end

% output directory
outDir = fullfile(projPath, 'pics');
if ~exist(outDir, 'dir')
    mkdir(outDir)
end

% get figure file
fname = fullfile(outDir, [figName, '.', fmt]);

%% set figure size

% auto: match displayed figure size
%set(h, 'PaperPositionMode', 'auto');

% manual: specify size different to screen size
%set(h, 'PaperPositionMode', 'manual');
%set(h, 'Units', 'centimeters', 'PaperUnits', 'centimeters');
%set(h, 'PaperPosition', [0.25 0.25 8 6]);

%% modifications

if rescaleInd == false
    % mape size to output size
    defaultUnit = 20;
    figureFrame = get(h, 'Position');
    figWidth = figureFrame(3);
    figHeight = figureFrame(4);
    outFigWidth = figWidth / 1200 * defaultUnit; % 1200 pixels represent 8 cm
    outFigHeight = figHeight / 1200 * defaultUnit;
    set(h, 'Units', 'centimeters')
    set(h, 'Position', [1, 1, outFigWidth, outFigHeight])
end

%%

% chose renderer:
% - opengl: for saving bitmap images
% - painters: when saving vector graphics

% change axes font size
allAxesInFigure = findall(h, 'type', 'axes');
for ii=1:length(allAxesInFigure)
    set(allAxesInFigure(ii), 'FontSize', 10);
end

% refine line width
set(get(h, 'children'), 'LineWidth', 1);

% make background color white
set(h, 'Color', 'w');

%% do actual printing

export_fig(fname)
% switch fmt
%     case 'png'
%         print('-dpng', '-r200', fname)
%     case 'eps'
%         print('-depsc', '-r200', fname)
%     case 'pdf'
%         print('-dpdf', '-r200', fname)
% end

% close if required
if closeInd
    figNumber = get(h, 'Number');
    close(figNumber)
end