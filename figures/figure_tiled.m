function figHandle=figure_tiled(figNumber,figSize)
% constructs a new figure window spread 
% as 6 tiles across the screen
%  [ ]  [ ]  [ ]
%  [ ]  [ ]  [ ]
%
%INPUTS
%figNumber : the argument passed to the standard figure function
%figSize: frame size compared to 1/6 of the screen, as [width;height]

%Author: Chris Rapson

if nargin<2 || length(figSize(:))~=2
    figSize=[1;1];
end

screenSize=get(0,'ScreenSize');%consider using MonitorPositions
screenSize(1:2)=screenSize(3:4);
height=screenSize(4)/2*0.86*figSize(2); %0.86 allows padding for window decoration and taskbar
width=screenSize(3)/3*0.98*figSize(1);  %0.98 allows padding for window decoration

figurePositions=[1,                     screenSize(4)/2*1.1,  width,height;  %1
                screenSize(3)/3*1.01    screenSize(4)/2*1.1,  width,height;  %2
                screenSize(3)*2/3*1.01  screenSize(4)/2*1.1,  width,height;  %3
                1,                      1,                    width,height;  %4
                screenSize(3)/3*1.01,   1,                    width,height;  %5
                screenSize(3)*2/3*1.01, 1,                    width,height]; %6

if nargin==0 || isempty(figNumber)
    figHandle=figure;
else
    figHandle=figure(figNumber);
end

if isnumeric(figHandle)
    set(gcf,'position',figurePositions(mod(figHandle-1,6)+1,:))
else
    set(gcf,'position',figurePositions(mod(get(gcf,'Number')-1,6)+1,:))
end