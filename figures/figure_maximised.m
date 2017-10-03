function figHandle = figure_maximised(figNumber)
%opens a maximised figure window

%Author: Chris Rapson

screenSize=get(0,'ScreenSize');%consider using MonitorPositions

if nargin==0 || isempty(figNumber)
    figHandle=figure;
    set(gcf,'position',screenSize)
else
    figHandle=figure(figNumber);
    set(gcf,'position',screenSize)
end