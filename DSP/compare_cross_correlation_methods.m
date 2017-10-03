%compare cross correlation methods
%
%all results identical for small |tau|
%method 3 deviates for large |tau|, 
%probably a windowing/padding issue
%
%method 1 is fastest
%method 3 is much slower

%Author: Chris Rapson

x=randn(1,10000);
y=randn(1,10000);
maxlags=50;
fs=1;
dt=1/fs;

%calculate cross correlation
tic
[xcorr1,tau]=ccf(x,y,fs); %routine written by Olaf Grulke
tau_start=find(tau>-maxlags,1);
tau_stop=find(tau>maxlags,1);
xcorr1=xcorr1(tau_start:tau_stop);
tau=tau(tau_start:tau_stop);
toc

tic
[xcorr2,tau2]=xcorr(x,y,maxlags,'coef'); %matlab toolbox
tau2=tau2*dt;
toc

tic
xcorr3=normxcorr2(x,y); %matlab toolbox
tau3=(1:size(xcorr3,2))*dt;
tau3=tau3-tau3(round(size(xcorr3,2)/2));
toc

figure
plot(tau,xcorr1)
hold all
plot(-tau2,xcorr2)
plot(tau3,xcorr3)