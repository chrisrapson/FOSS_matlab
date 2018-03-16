%startup file
beep off

if ~isdeployed
	disp('adding directories from FOSS_matlab...')
	[my_matlab_root,~,~]=fileparts(mfilename('fullpath'));
	%careful: genpath_exclude can't handle folder names which include the character ':'
	addpath(fullfile(my_matlab_root,'misc','genpath_exclude'),'-end')
% 	addpath(genpath_exclude_rapsonc(my_matlab_root,...
% 		{'unused',...
% 		'testing',...
% 		'.hg',...
% 		'.svn',...
% 		'mcr',...
% 		'DCS_Projects',...
% 		fullfile('DCS_matlab','matlab_app'),...
% 		fullfile('DCS_matlab','XMprot_standalone')}),...
% 		'-end')
	addpath(genpath(fullfile(my_matlab_root,'FOSS_matlab')))
	
	%deployed programs should use the default lineWidth, markerSize and fontSize
	set(0,'defaultlinelinewidth',2)%make lines thick enough for ppts
	set(0,'defaultLineMarkerSize',6)
	set(0,'defaultaxesfontsize',18); %axes fonts big enough for ppts
	set(0,'defaulttextfontsize',18); %xlabels and titles big enough for ppts

	%deployed programs can't use dbstop
	dbstop if error
end

%does this line make the axes not successively zoomable?? Yes
% set(0,'defaultlinecreatefcn','axis tight')  %graphs scale after drawing each line?

set(0,'DefaultFigurePaperType','a4') %'print' command saves pdfs the right size
set(0,'DefaultFigurePaperUnits','centimeters')
set(0,'DefaultAxesFontName','Helvetica')%use arial cos helvetica is not always available %...nah, they (ie Corel in Windows) can change it later if needed
set(0,'DefaultTextFontName','Helvetica')%use arial cos helvetica is not always available
% set(0,'DefaultAxesColorOrder',[0 0 0;hsv(4)]*diag([1,0.5,1]))%change colour order to avoid yellow and green which don't work on projectors
set(0,'DefaultAxesColorOrder',[0 0 0;0 0 1;1 0 0;1 0 1;0 1 1])%;0.8 0.4 0.4;0.5 0.5 0.5])%change colour order
%[0 0 1;1 0 0;0 0 0])
set(0,'DefaultAxesLineStyleOrder','-|--|:')%if more than 4 lines, use different line types as well as colour differentiation
%set(0,'Units','normalized')
set(0,'showhiddenhandles','off');%make temphackytext not findable by findobj or children
set(0,'DefaultAxesPosition',[0.15,0.15,0.725,0.725])%shift axes to make room for xlabels and ylabels.
% set(0,'DefaultAxesFontName','CMU Serif Roman') %workaround for no helvetica in 'latex' interpreted text: make everything CMU serif
set(0, 'defaultLineMarkerSize', 6)

format long g %how to display numbers in the command window

%makes sensible axes placement with some space around labels etc:
% set(0,'DefaultAxesLooseInset',[0,0,0,0])
% set(gca,'LooseInset',get(gca,'TightInset'))

% end
