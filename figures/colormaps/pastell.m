function cmap=pastell(l,zero_fraction)
%creates a variable resolution colormap with 
%white at the centre
%
% INPUTS
% l							: length of colormap
% zero_fraction	: number [0..1] of where to put the zero (default 0.5)
%
% See also: halfpastell

%Author: Chris Rapson
% history:
% v1.0		: Chris Rapson 2011 - rewrite Olaf Grulke's pastell.m to allow variable length
% v2.0		: Chris Rapson 2013 - add ability to shift zero position

% TODO: r2 is unstable for very small values of l. Consider using linspace instead

if nargin<1 || isempty(l)
    l=128;
end
if nargin<2 || isempty(zero_fraction)
	zero_fraction=0.5;
end

x=1:l;
zf=round(zero_fraction*l);
index_eighth = round(zf/4);
index_quarter = round(zf/2);
index_five_eigths = min([round(zf*1.25), l-2]);
index_three_quarters = zf + round((l-zf)/2);

%red
r1=(x(1:zf)/zf).^2;
r2=(x(min([zf+1, index_five_eigths-1]):index_five_eigths)-x(zf))*(-0.125/(zf*0.25))+1;
x_r3=x(index_five_eigths+1:end);
if isempty(x_r3)
	r3=[];
else
	r3=(x_r3-x(end))/(x_r3(1)-x(end))*abs(r2(end)-1).^0.75;
	r3=-r3.^(4/3)+1;
end
r=[r1 r2 r3];

%green
g1=x(1:index_quarter)/x(index_quarter)*0.9;
g2=x(1:index_quarter)/x(index_quarter)*0.1+0.9;
g3=(x(1:max([1, l-zf]))/x(max([1, l-zf]))-1).^2;
g=[g1 g2 g3(1:round((l-zf)/2)) fliplr(g3(1:round((l-zf)/2)))];

%blue
b1=1-x(1:index_quarter)/x(index_quarter)*0.05;
b2=b1(end)-x(1:index_eighth)/x(index_eighth)*0.2;
b3=b2(end)+x(1:index_eighth)/x(index_eighth)*0.25;
b4=x(1:max([1, l-zf]))/x(max([1, l-zf]));
b=[b1 b2 b3 fliplr(b4)];

%hack around size approximation problem
if length(r)~=length(g) || length(g)~=length(b) || length(g)~=l
	if l>size(g,2);
		r=[r ones(1,l-size(r,2))];
		g=[g ones(1,l-size(g,2))];
		b=[b zeros(1,l-size(b,2))];
	else
		r=r(1:l);
		g=g(1:l);
		b=b(1:l);
	end
end

cmap=[r' g' b'];
return