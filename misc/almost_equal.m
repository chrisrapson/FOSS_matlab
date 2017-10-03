function al_eq = almost_equal(x,y,accuracy)
% determines if two inputs are equal within reasonable accuracy
% this tries to avoid errors comparing numbers which are not equal due to
% numerical limitations
% INPUTS
% x, y      : the numbers to be compared
% accuracy  : how close they need to be (default <0.001% of larger input)
%             or absolute difference <1e-5 if one of the inputs is 0.
%
% note only takes scalar inputs at this stage

% Author: Chris Rapson

if nargin<2
    error('at least 2 inputs required')
elseif nargin<3
    accuracy=1e-5;
end

%check if one of the inputs is 0, do absolute comparison
if x==0
    al_eq=abs(y)<accuracy;
elseif y==0
    al_eq=abs(x)<accuracy;
else
    al_eq=abs(x-y)/max(abs([x,y]))<accuracy;
end

return