function [map]=halfpastell(res,upperhalf);
%makes a colormap using one half of the pastell colormap.
%By default it is the upper half (white..red..yellow), but the second 
%argument can be set to 0 for inverted lower half (white..green..blue)
%
% See also: pastell

%Author: Chris Rapson

if nargin == 0
    res= 64;
end

if exist('pastell','file')
  fullpastell=pastell(res*2);
else
  fullpastell=pastell;
end

if ~exist('upperhalf','var') || upperhalf
    %upper half
    map=fullpastell(res+1:end,:);
else
    %lower half
    map=flipud(fullpastell(1:res,:));
end