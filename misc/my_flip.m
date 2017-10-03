function y=my_flip(x)
% flips the matrix about its longest dimension
% useful for vectors if you don't want to think about their orientation
%
% history:
% version 1.0 2011.05.12 Chris Rapson
%	superseded by matlab function in Matlab_2013b, renamed to my_flip
%
% See also fliplr flipud

%Author: Chris Rapson

[m,n]=size(x);

if m>n
    y=flipud(x);
elseif m==n
    y=flipud(x);
    warning('dimensions equal, using flipud as default')
else
    y=fliplr(x);
end

return