function z=make_all_possible_combinations_of_two_vectors(x,y)
% output is a 2xN matrix with all possible combinations of the values in the 
% input vectors. Elements from first vector are in the first row.
% There is no check for duplicates.
%
% See also: perms

%Author: Chris Rapson

%check that x and y are vectors
if ~isvector(x) || ~isvector(y)
	error('both inputs must be vectors')
end
%make them row vectors
x=x(:)';
y=y(:)';

length_x=length(x);

z=[];
for i=length(y):-1:1
	z=[[x;y(i)*ones(1,length_x)] z];
end

return