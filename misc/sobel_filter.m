function f = sobel_filter(S)
%returns a sobel filter for vertical edge detection
%if you want horizontal edge detection, just take the transpose
%
%INPUTS:
% S     : size i.e. length of side of the square
%
%OUTPUTS:
% f     : sobel filter of size SxS

%see https://stackoverflow.com/questions/9567882/sobel-filter-kernel-of-large-size

assert(mod(S,2) == 1, ['size argument to sobel_filter must be odd. Your input was ',num2str(S)])

f = zeros(S,S);

for ii = 1:S
	i = ii - ceil(S/2);
	for jj = 1:S
		j = jj - ceil(S/2);
		if i==0 && j==0
			%do nothing to avoid div0 error
		else
			f(ii,jj) = i  / (i^2+j^2);
		end
	end
end