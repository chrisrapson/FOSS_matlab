function varargout=long_pwelch(varargin)
% divides long time series into portions of 32000 samples, inputs the
% pieces to pwelch and averages the output

%Author: Chris Rapson

n_bits=ceil(length(varargin{1})/32e3);
l_bits=floor(length(varargin{1})/n_bits);

for i=n_bits-1:-1:0
    if nargin>1
        [Pxx(i+1,:),F]=pwelch(detrend(varargin{1}(l_bits*i+1:l_bits*(i+1))),...
                    varargin{2:length(varargin)});
    else
        [Pxx(i+1,:),F]=pwelch(detrend(varargin{1}(l_bits*i+1:l_bits*(i+1))));
    end
end

if ~isreal(Pxx)
    a=find(imag(Pxx)~=0);
    if all(isnan(Pxx(a)))
        Pxx=real(Pxx);
    else
        disp('Pxx is not real');
        debug_pause;
    end
end

if n_bits>1
    varargout{1}=mean(Pxx);
else
    varargout{1}=Pxx;
end
if nargout>1
    varargout{2}=F;
end
return