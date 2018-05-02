function text_handle=putlabel(axis_handle,label,inside,varargin)
%adds a label to an axis
% e.g. a) or b) in the top left of the axis
%
% INPUTS
% axis_handle   : which axis to label
% label         : how to label it
% inside        : place label inside axis? [boolean] default=no
% varargin      : other options which will be passed to text

%Author: Chris Rapson

if nargin<2
    help putlabel
    error('not enough arguments')
elseif nargin<3
    inside=[];
end

if isempty(axis_handle)
    axis_handle=gca;
end

if isempty(label)
    label='a)';
end

if isempty(inside)
    inside=0;
end

myAxis=axis(axis_handle);

yl=get(axis_handle,'ylabel');
if inside
    shift_factor_x=-0.02;
    shift_factor_y=-0.005;
else
    if isempty(get(yl,'String'))%no ylabel
        shift_factor_x=0.1;
    else
        shift_factor_x=0.25;
    end
    shift_factor_y=0;
end

if strcmp(get(axis_handle,'xscale'),'linear')
    xpos=myAxis(1)-(myAxis(2)-myAxis(1))*shift_factor_x;
else
    myAxis(1)=log10(max([eps,myAxis(1)]));
    myAxis(2)=log10(myAxis(2));
    xpos=myAxis(1)-(myAxis(2)-myAxis(1))*shift_factor_x;
    xpos=10^xpos;
end
if strcmp(get(axis_handle,'yscale'),'linear')
    ypos=myAxis(4)+(myAxis(4)-myAxis(3))*shift_factor_y;
else
    myAxis(3)=log10(max([eps,myAxis(3)]));
    myAxis(4)=log10(myAxis(4));
    ypos=myAxis(4)-(myAxis(4)-myAxis(3))*shift_factor_y;
    ypos=10^ypos;
end

tmp=text('parent',axis_handle,'position',[xpos,ypos],'String',label,'verticalAlignment','top',varargin{:});
if nargout>=1
	text_handle = tmp;
end