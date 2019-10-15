function cmap_out = rescale_cmap(cmap_in, x_out, x_in)
%rescales each of RGB components by interpolation. 
%INPUTS:
% cmap_in : existing colormap (Nx3)
% x_out   : indices to interpolate onto
% x_in    : (optional) indices to interpolate from. If not provided, x_in
%           will be created with linspace between the extremes of x_out, 
%           and length equal to cmap_in. If provided, length(x_in) must 
%           equal size(cmap_in, 1)
%
%OUTPUTS:
% cmap_out : rescaled colormap (Mx3), M = length(x_out)

if ischar(cmap_in)
	cmap_in = colormap(cmap_in);
elseif size(cmap_in,2 ~= 3)
	error('colormap input must have 3 columns')
end

if nargin < 3 || isempty(x_in)
% 	x_in = 1:size(cmap_in,1);
	x_in = linspace(x_out(1), x_out(end), size(cmap_in,1));
end

for RGB = 3:-1:1
	cmap_out(:,RGB) = interp1(x_in, cmap_in(:,RGB), x_out, 'pchip', 'extrap');
end