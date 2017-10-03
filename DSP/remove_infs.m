function out=remove_infs(in)
%replaces inf with the highest number in the matrix
%replaces -inf with the lowest number in the matrix
%NaNs are not dealt with

%Author: Chris Rapson

if all(~isinf(in(:)))
    out=in;
    return
elseif all(isinf(in(:)))
    warning('this matrix has only infs')
    out=zeros(size(in));
    return
else
    [inf_indices_x,inf_indices_y]=find(in==inf);
    in(inf_indices_x,inf_indices_y)=-inf;
    in(inf_indices_x,inf_indices_y)=max(in(:));
    
    [inf_indices_x,inf_indices_y]=find(in==-inf);
    in(inf_indices_x,inf_indices_y)=inf;
    in(inf_indices_x,inf_indices_y)=min(in(:));
end
out=in;