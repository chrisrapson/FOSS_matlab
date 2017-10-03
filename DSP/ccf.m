function [corr,tau]=ccf(y1,y2,fs)
% Derived from a function by my professor Olaf Grulke.
% As the licensing is unclear, the code is not published here.
% 
%  this routine computes the crosscorrelation function between
%  datavectors y1 and y2 (same length):
%  
%  Usage:    [corr,tau]=ccf(y1,y2,fs)
%
%  Input:              y1, y2   data vectors
%                      fs       sampling frequency 
%                               
%  Output:             tau      vector of time lags 
%                      corr     resulting crosscorrelation function  
%
%!!!	TO GET THE RIGHT DIRECTIONS:  	y1 fixed probe
%					y2 movable probe		 
%

error('contact Chris Rapson or Olaf Grulke for implementation')