function [xo,yo,zo]=downscale_plot_data(x,y,z,image_size)
%If 2D data is too dense, plotting e.g. with pcolor
%can be slow and most data points may not even be 
%visible. Therefore downscale it before plotting.
%
%Use a custom routine because 
%- interp doesn't work because it only allows an increase in the number of
%points. It also seems to treat the entire matrix as one vector
%- resample doesn't work because it adds zero-pads at start and end
%- downsample picks every Nth data point. No averaging and N must be an
%integer
%- decimate only works with vectors.
%
% INPUTS
% x          : x-coordinate (1st independent variable)
% y          : y-coordinate (2nd independent variable)
% z          : data (dependent variable)
% image_size : desired maximum dimension in either x or y direction

%Author: Chris Rapson

if nargin<2
    help rescale_plot_data
    error
elseif nargin<3 || isempty(z)
    image_size=300;
    threeD=0;
elseif nargin<4 %&& ~isempty(z)
    image_size=300;
    threeD=1;
else
    threeD=1;
end

if min(size(x))>1 || min(size(y))>1
    error('x and y must be vectors')
end

if any(~isfinite(x))
    if all(~isfinite(x))
        error('no finite values in x')
    end
    warning('non finite values found and removed in x')
    %infs
    x=remove_infs(x);
    %nans
    x=remove_nans(x);
end
if any(~isfinite(y))
    if all(~isfinite(y))
        error('no finite values in y')
    end
    warning('non finite values found and removed in y')
    %infs
    y=remove_infs(y);
    %nans
    y=remove_nans(y);
end
if any(~isfinite(z(:)))
    if all(~isfinite(z(:)))
        error('no finite values in z')
    end
    warning('non finite values found and removed in z')
    %infs
    z=remove_infs(z);
    %nans
    z=remove_nans(z);
end

if length(x)>image_size
    if length(x)/image_size<13
        xo=decimate(x,round((length(x)/image_size)));%downsample(x,round(length(x)/image_size));
    else
        myPrimes=factor(round(length(x)/image_size));
        temp=x;
        for i=1:length(myPrimes)
            temp=decimate(temp,myPrimes(1));
        end
        xo=temp;
    end
else
    xo=x;
end

if length(y)>image_size
    if length(y)/image_size<13
        yo=decimate(y,round((length(y)/image_size)));%downsample(x,round(length(x)/image_size));
    else
        myPrimes=factor(round(length(y)/image_size));
        temp=y;
        for i=1:length(myPrimes)
            temp=decimate(temp,myPrimes(1));
        end
        yo=temp;
    end
else
    yo=y;
end

if threeD
    if ~(length(x)==size(z,1) && length(y)==size(z,2))
        if length(x)==size(z,2)&&length(y)==size(z,1)
            z=z';
        else
            error('z or z'' should have the dimensions length(x)*length(y)')
        end
    end
%     temp=downsample(z,round(length(y)/length(yo)));
%     zo=downsample(temp',round(length(x)/length(xo)))';
    if length(x)~=length(xo)
        for i=size(z,2):-1:1
            temp(:,i)=decimate(z(:,i),round(length(x)/length(xo)));
        end
    else
        temp=z;
    end
    if length(y)~=length(yo)
        for i=size(temp,1):-1:1
            zo(i,:)=decimate(temp(i,:),round(length(y)/length(yo)));
        end
    else
        zo=temp;
    end
end

return

