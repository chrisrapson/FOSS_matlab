function new_axes=axis_loose(axh)
% sets the axes like tight, but with a little bit more breathing room on
% all sides
% See Also: axis

%Author: Chris Rapson

if ~exist('axh','var') || isempty(axh)
    axh=gca;
end

axis(axh,'tight')
myAxis=axis(axh);

if strcmp(get(axh,'xscale'),'lin') || strcmp(get(axh,'xscale'),'linear')
    xSpan=myAxis(2)-myAxis(1);
    xMin=myAxis(1)-0.1*xSpan;
    xMax=myAxis(2)+0.1*xSpan;
else
    if myAxis(1)==0
        myPlot=get(get(axh,'Children'));
        xd=myPlot.XData;
        myAxis(1)=min(xd(xd~=0));
    end
%     xSpan=myAxis(2)/myAxis(1);
%     xMin=myAxis(1)*2/mySpan%(1-log10(xSpan));
%     xMax=myAxis(2)*(1+log10(xSpan));
    myAxis(1)=log10(max([eps,myAxis(1)]));
    myAxis(2)=log10(myAxis(2));
    
    xSpan=myAxis(2)-myAxis(1);
    xMin=myAxis(1)-0.1*xSpan;
    xMax=myAxis(2)+0.1*xSpan;
    
    xMin=10^xMin;
    xMax=10^xMax;
end

if strcmp(get(axh,'yscale'),'lin') || strcmp(get(axh,'yscale'),'linear')
    ySpan=myAxis(4)-myAxis(3);
    yMin=myAxis(3)-0.1*ySpan;
    yMax=myAxis(4)+0.1*ySpan;
else
    if myAxis(3)==0
        myPlot=get(get(axh,'Children'));
        yd=myPlot.YData;
        myAxis(3)=min(yd(yd~=0));
    end
%     ySpan=myAxis(4)/myAxis(3);
%     yMin=myAxis(3)*(1-log10(ySpan));
%     yMax=myAxis(4)*(1+log10(ySpan));
    myAxis(3)=log10(max([eps,myAxis(3)]));
    myAxis(4)=log10(myAxis(4));
    
    ySpan=myAxis(4)-myAxis(3);
    yMin=myAxis(3)-0.1*ySpan;
    yMax=myAxis(4)+0.1*ySpan;
    
    yMin=10^yMin;
    yMax=10^yMax;
end

axis(axh,[xMin,xMax,yMin,yMax]);
if nargout==1
    new_axes=axis(axh);
end
return 