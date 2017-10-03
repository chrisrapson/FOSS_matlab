function align_y_labels(varargin)
%aligns the ylabels horizontally on two or more axes
%assumes that the axes are already aligned
%i.e. just sets a common distance between axis and label
%e.g. align_y_labels(p1,p2,p3) %where p1,p2,p3 are axes handles

%Author: Chris Rapson

if length(varargin)>=2
    for i=1:length(varargin)
        h(i)=varargin{i};
        if ~ishandle(h(i)) || ~strcmp(get(h(i),'type'),'axes')
            error('all arguments must be axis handles')
        end
    end
% elseif isempty(varargin)
%     h=findobj(gcf,'type','axes') %this will detect legends and colorbars too... complicated
else
%     error('only one axis handle supplied. Can''t align labels for just one axis')
    error('at least 2 axis handles must be supplied')
end


%drawnow to make sure the data I'm reading is up to date
drawnow

% find most left ylabel
xmin=inf;
for i=1:length(h)
    yl=get(h(i),'ylabel');
    ylp=get(yl,'position');
    
    xlims=get(h(i),'xlim');%
    norm_pos=(ylp(1)-xlims(1))/(xlims(2)-xlims(1));
    
    if norm_pos<xmin
        xmin=norm_pos;
    end
end

%move all xlabels down to this level
for i=length(h):-1:1
    yl=get(h(i),'ylabel');
    ylp=get(yl,'position');
    xlims=get(h(i),'xlim');%
    
    new_pos=xmin*(xlims(2)-xlims(1))+xlims(1);
    
    set(yl,'position',[new_pos ylp(2) ylp(3)])
end

return