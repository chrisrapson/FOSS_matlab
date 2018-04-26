function varargout = stairs_unclipped(varargin)
%wrapper for stairs which doesn't leave off the last point in the vector
%
% See also: stairs

arg_pass_through = {};
x = [];
if nargin == 1
	y = varargin{1};
elseif nargin > 1
	if isnumeric(varargin{1}) && isnumeric(varargin{2})
		x = varargin{1};
		y = varargin{2};
		if nargin > 2
			arg_pass_through = varargin{3:end};
		end
	elseif isnumeric(varargin{1})
		y = varargin{1};
		arg_pass_through = varargin(2:end);
	end
end

if size(y,1) > 1
	%the default direction for plotting stairs for a matrix input
	%the same procedure will work for a column vector
	for ii = size(y,2):-1:1
		y(end+1,ii) = y(end,ii);
	end
	for ii = size(x,2):-1:1
		x(end+1,ii) = x(end,ii) + (x(end,ii)-x(end-1,ii));
	end
elseif size(y,2) > 1
	%y is a row vector (hopefully x is too)
	y(end+1) = y(end);
	x(end+1) = x(end) + (x(end)-x(end-1));
end

if isempty(x)
	tmp = stairs(y,arg_pass_through{:});
else
	tmp = stairs(x,y,arg_pass_through{:});
end

if nargout >= 1
	varargout = tmp;
end