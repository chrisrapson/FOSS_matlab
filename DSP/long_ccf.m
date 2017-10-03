function varargout=long_ccf(varargin)
% divides long time series into portions of 32000 samples, inputs the
% pieces to ccf and averages the output
%
%INPUTS
%x  : first time series
%y  : second time series
%dt : sample time [s]
%
%OUTPUTS
%XC     : Cross correlation between x and y
%tau    : time lag [s]

%Author: Chris Rapson

if nargin<3
    varargin{3}=1;
end

n_bits=ceil(length(varargin{1})/32e3);
l_bits=floor(length(varargin{1})/n_bits);
if mod(l_bits,2)==0
    l_bits=l_bits-1;
end

Pxy=nan(n_bits,l_bits);
for i=0:n_bits-1
        [Pxy(i+1,:),tau]=ccf(detrend(varargin{1}(l_bits*i+1:l_bits*(i+1))),...
                    detrend(varargin{2}(l_bits*i+1:l_bits*(i+1))),...
                    varargin{3:length(varargin)});
end

Pxy(~isfinite(Pxy))=0;

varargout{1}=mean(Pxy,1);
if nargout>1
    varargout{2}=tau;
end
return