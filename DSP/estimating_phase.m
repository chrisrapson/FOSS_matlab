%methods of calculating the phase of a signal

%Author: Chris Rapson

%% 1. Hilbert transform
%http://www.mathworks.com/matlabcentral/answers/22907-phase-angle-from-discrte-hilbert-tranform

close all
x = cos(pi/40*(0:100)-0.5);
y = hilbert(x);
% sigphase = atan2(imag(y),real(y))
% or
sigphase = angle(y);
figure,plot(x)

figure,plot(sigphase);
title('instantaneous phase')

figure,plot(abs(y))

figure,plot(y)

%% lsqcurvefit
clearvars
close all

xdata=linspace(0,1,1e3);
f=20;
ph=pi/6;
amp=0.5;
% offset=0.5;
ydata=amp*sin(2*pi*f*xdata+ph);

% true_x = [amp f ph]'
% est_x = [0.6 19 0];
% x = lsqcurvefit(@(x,xdata) x(1)*sin(2*pi*x(2)*xdata+x(3)),est_x,xdata,ydata);
% x'

true_x = [amp f ph]'
est_x = [0.4 19.9 0];
x = lsqcurvefit(@(x,xdata) x(1)*sin(2*pi*x(2)*xdata+x(3)),est_x,xdata,ydata);
x'

figure
hold all
plot(xdata,ydata)
plot(xdata, x(1)*sin(2*pi*x(2)*xdata+x(3)))

%% 2. difference between two signals
%https://www.reddit.com/r/DSP/comments/34w3d5/fft_to_measure_relative_phase_shift_of_two_signals/

%requires identical frequencies --> not possible for real data. There will 
%always be some slippage.
%For the same reason, fitting a sinusoid with a fixed frequency will also give an answer which depends on the length of the window.

% Find phase shift between two signals using FFT phase angles
% Note: to keep this simple I separated out steps that could be combined 
% I also didn't bother making the fft output one sided, so the phase plot
% extends from 0:2*pi (0:Fs) and contains the 'negative' frequencies

clear all
% Waveform Settings

Fs = 16000; % Sample frequency
Ts = 1/Fs; % sample period
sTime = 4; % Sampling time in seconds

freq = 1000; % Frequency in Hz
phase_deg_1 = 65; % Shift for signal 1 in Hz
phase_deg_2 = 15; % Shift for signal 2 in Hz


% 1: Generate two sine waves shifted by phase_deg degrees

% Convert degrees to radians 
phase_rad_1 = pi*phase_deg_1/180;
phase_rad_2 = pi*phase_deg_2/180;

% Input data to sin from 0 to sTime seconds in increments of sample period 
n = 0:(1/Fs):sTime;

% Here the actual sin waves are sampled
signal_1 = sin(2*pi*freq*n + phase_rad_1);
signal_2 = sin(2*pi*freq*n + phase_rad_2);


% 2: Take the FFT of each of the two signals
signal_1_fft = fft(signal_1);
signal_2_fft = fft(signal_2);

% Throw away DC component that should be at index 0 in a sane language
signal_1_fft = signal_1_fft(2:end);
signal_2_fft = signal_2_fft(2:end);


% 3: Find the phases of each signal

signal_1_phase = unwrap(angle(signal_1_fft));
signal_2_phase = unwrap(angle(signal_2_fft));


% 4: Now we can find the phase angle difference between the two signals
signal_phase_diff = signal_2_phase - signal_1_phase;

figure
hold all
plot(linspace(1/Fs,Fs,length(signal_1_phase)), signal_1_phase)
plot(linspace(1/Fs,Fs,length(signal_1_phase)), signal_2_phase)
plot(linspace(1/Fs,Fs,length(signal_1_phase)), signal_phase_diff)
plot(freq*[1 1], [0 pi])

% 5: Next we can pull out the phase diff at the frequency of interest:

% Convert from bin number to frequency from 0 to Fs
binNum = ((length(signal_1_fft))/Fs)*freq;
binNum = round(binNum);

phase_diff = signal_phase_diff(binNum);

% Display result in degrees
sprintf('Phase difference between signals at %d Hz is %f degrees', freq, (phase_diff*180)/pi)
