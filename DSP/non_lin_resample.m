function [xo,yo]=non_lin_resample(x,y)
%resamples y such that the intervals in xo are uniform
%linear interpolation is used for each point
%i.e
%
% x_in y_in      ->   x_out y_out
% 1     10             1    10
% 2      9             3.3  8.3
% 4      8             5.7  7.6
% 8      7             8    7
%

%Author: Chris Rapson

if length(x)~=length(y)
    error('x and y must be equal length')
end

%check that x is monotonously increasing/decreasing
xd=diff(x);
if ~(all(xd<=0) || all(xd>=0))
    help non_lin_resample
    error('x input must be monotonously increasing or decreasing')
end

xo=linspace(x(1),x(end),length(x));

yo=zeros(size(y));

for i=1:length(x)
    if xo(i)==x(i)
        yo(i)=y(i);
    else
        index1=find(x<xo(i),1,'last');
        index2=find(x>xo(i),1);

        numerator=xo(i)-x(index1);
        denominator=x(index2)-x(index1);
        
        if denominator==0
            denominator=eps;
        end

        yo(i)=numerator/denominator*(y(index2)-y(index1))+y(index1);
    end
end

return