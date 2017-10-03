function increase_all_fonts(axis_handle)
%bumps up all font sizes
%axes labels, including colorbars, by 2pt
%others by 0.5pt

%Author: Chris Rapson

if nargin==0 || isempty(axis_handle)
    axis_handle=gca;
end

xl=get(gca,'xlabel');
yl=get(gca,'ylabel');
tl=get(gca,'title');
% 
% set(xl,'FontSize',18)
% set(yl,'FontSize',18)
% set(tl,'FontSize',20)
allAxes=findobj(gcf,'type','axes');
textObjects=[];
for i=1:length(allAxes)
    textObjects=[textObjects;findobj(allAxes(i),'type','text')];
    textObjects=[textObjects;get(allAxes(i),'xlabel')];
    textObjects=[textObjects;get(allAxes(i),'ylabel')];
    textObjects=[textObjects;get(allAxes(i),'title')];
end
for i=1:length(textObjects)
    fs=get(textObjects(i),'FontSize');
%     if strcmpi(get(get(textObjects(i),'parent'),'tag'),'legend')
%         keyboard
%     end
    if strcmpi(get(get(textObjects(i),'parent'),'tag'),'') || strcmpi(get(get(textObjects(i),'parent'),'tag'),'Colorbar')
        %labels
        set(textObjects(i),'FontSize',fs+2);
    else
        %legends
        set(textObjects(i),'FontSize',fs+0.5);
    end
end

return