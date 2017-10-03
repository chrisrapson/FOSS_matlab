function align_titles(varargin)
%aligns the titles vertically on two or more axes
%assumes that the axes are already aligned
%i.e. just sets a common distance between axis and title

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
%     error('only one axis handle supplied. Can''t align titles for just one axis')
    error('at least 2 axis handles must be supplied')
end
    

% find lowest title
ymin=inf;
for i=1:length(h)
    xl=get(h(i),'title');
    xlp=get(xl,'position');
        
    %normalise to axis height, i.e. 0 is bottom, 1 is top, xlabel should be somewhere ~-0.2
%     axes_size=get(h(i),'position');
%     height=axes_size(2)-axes_size(1);
%     spacing=xlp(2)/height;
    ylims=get(h(i),'ylim');%
    if strcmp(get(h(i),'yscale'),'linear')
        %leave everything as is
    else %log scales
        %change scales to appear linear
        ylims(1)=log10(ylims(1));
        ylims(2)=log10(ylims(2));
        xlp(2)=log10(xlp(2));
    end
    norm_pos=(xlp(2)-ylims(1))/(ylims(2)-ylims(1));
    
    if norm_pos<ymin
        ymin=norm_pos;
    end
end

%move all xlabels down to this level
for i=length(h):-1:1
    xl=get(h(i),'title');
    xlp=get(xl,'position');
    ylims=get(h(i),'ylim');%
    
    if strcmp(get(h(i),'yscale'),'linear')
        new_pos=ymin*(ylims(2)-ylims(1))+ylims(1);
    else
        ylims(1)=log10(ylims(1));
        ylims(2)=log10(ylims(2));
        new_pos=ymin*(ylims(2)-ylims(1))+ylims(1);
        new_pos=10^(new_pos);
    end
    
    set(xl,'position',[xlp(1) new_pos xlp(3)])
end

return