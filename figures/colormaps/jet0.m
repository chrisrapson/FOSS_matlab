function J = jet0(m)
%JET0    Variant of Jet, which is a variant of HSV
%Extends a jet colormap with white. Useful for 
%highlighting values close to the minimum
%or for clearly identifying the lower bound.
%
%   See also JET, HSV, HOT, PINK, FLAG, COLORMAP, RGBPLOT.

%Author: Chris Rapson

if nargin < 1
   m = size(get(gcf,'colormap'),1);
end
J=jet(m-1);
J=[1 1 1;J];
