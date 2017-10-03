function out=remove_running_average(in,span)
%removes the running average from a signal
%
%INPUTS
% in : signal to be filtered
% span : length over which to average, before removing
%
%OUTPUTS
% out: the filtered signal

%Author: Chris Rapson

if nargin<1 || nargin>2
    help remove_running_average
elseif nargin==1
    span=round(length(in)/10);
end

running_average=filter(ones(1,span),span,in);


out=in-running_average;

figure
plot(in)
hold all
plot(running_average)
% plot(out)
return