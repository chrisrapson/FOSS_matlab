function y=rapsonc_resample(x,R)
% resamples y at a higher frequency. The result is a true linear fit to the
% nearest neighbours. i.e it doesn't give messed up numbers 
% e.g. resample(linspace(1,20,20),2,1)
%
% only works on vectors
%
% See also: resample, upsample, upfirdn, decimate, downsample, interp

%Author: Chris Rapson

if min(size(x))>1 || max(size(size(x)))>2
	error('rapsonc_resample only works on vectors')
end

y=zeros(length(x)*R,1);
for i=1:length(x)-1
	for j=1:R
		y((i-1)*R+j)=x(i)+(j-1)/R*(x(i+1)-x(i));
	end
end

y((i-1)*R+j+1)=x(end);
y((i-1)*R+j+2:end)=[];