%compare pwelch, psd with welch and msspectrum
%conclusion: pwelch is easiest and best: 
%narrowest spectra
%least noise ripple
%shows peak high proportional (but not equal to) amplitude, units=dB/Hz

%Author: Chris Rapson

Fs = 1000;   t = 0:1/Fs:.4;
x = 3*cos(2*pi*t*20)+3*cos(2*pi*t*100)+3*cos(2*pi*t*400);  
x=x/2;
h = spectrum.welch;           % Create a Welch spectral estimator. 


figure(1)
subplot(411)%
msspectrum(h,x,'Fs',Fs,'NFFT',2^15);
myAxis=axis;
% axis([myAxis(1) myAxis(2) myAxis(4)-16 myAxis(4)])
title('msspectrum')

subplot(412)%figure
psd(h,x,'Fs',Fs);                    % Calculate and plot the PSD.
myAxis=axis;
% axis([myAxis(1) myAxis(2) myAxis(4)-16 myAxis(4)])
title('psd')

subplot(413)%figure
pwelch(x,[],[],[],Fs); % Uses default window, overlap & NFFT.
myAxis=axis;
% axis([myAxis(1) myAxis(2) myAxis(4)-16 myAxis(4)])
title('pwelch')

subplot(414)
hh=spectrum.music(3);
pseudospectrum(hh,x,'Fs',Fs,'NFFT',2^15);
myAxis=axis;
% axis([myAxis(1) myAxis(2) myAxis(4)-64 myAxis(4)])
