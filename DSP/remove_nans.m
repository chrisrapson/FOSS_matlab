function xo=remove_nans(x);
%removes nans from a vector or matrix
%has a few bugs for matrices with large numbers of nans

%Author: Chris Rapson

if all(isnan(x(:)))
    warning('this matrix has only nans')
    xo=x;
    return
end

if min(size(x))==1 %vector
    while any(isnan(x(2:end-1)))
        nan_indices=find(isnan(x(2:end-1)));
        x(nan_indices+1)=my_nanmean(x(nan_indices:nan_indices+2));
    end
    if isnan(x(1)), x(1)=x(2); end
    if isnan(x(end)), x(end)=x(end-1); end
else %matrix
    column_length=size(x,1);%=n_rows
    safety_counter=1; %avoid infinite loop
    while any(isnan(x(1,:))) || any(isnan(x(:,1))) || any(isnan(x(end,:))) || any(isnan(x(:,end)))
        if safety_counter>5
            warning('not all nans could be removed')
            xo=x;
            return
        end
        safety_counter=safety_counter+1;
        
        %corners
        if isnan(x(1,1)),     x(1,1)    =my_nanmean(my_nanmean(x(1:2,1:2))); end
        if isnan(x(1,end)),   x(1,end)  =my_nanmean(my_nanmean(x(1:2,end-1:end))); end
        if isnan(x(end,1)),   x(end,1)  =my_nanmean(my_nanmean(x(end-1:end,1:2))); end
        if isnan(x(end,end)), x(end,end)=my_nanmean(my_nanmean(x(end-1:end,end-1:end))); end
        %edges
        if any(isnan(x(1,:)))
            nan_indices=find(isnan(x(1,:)));
            x(1,nan_indices)=my_nanmean(my_nanmean(x(1:2,max(2,min(nan_indices))-1:min(size(x,2)-1,max(nan_indices))+1)));
        end
        if any(isnan(x(end,:)))
            nan_indices=find(isnan(x(end,:)));
            x(end,nan_indices)=my_nanmean(my_nanmean(x(end-1:end,max(2,min(nan_indices))-1:min(size(x,2)-1,max(nan_indices))+1)));
        end
        if any(isnan(x(:,1)))
            nan_indices=find(isnan(x(:,1)));
            x(nan_indices,1)=my_nanmean(my_nanmean(x(max(2,min(nan_indices))-1:min(size(x,1)-1,max(nan_indices))+1,1:2)));
        end
        if any(isnan(x(:,end)))
            nan_indices=find(isnan(x(:,end)));
            x(nan_indices,end)=my_nanmean(my_nanmean(x(max(2,min(nan_indices))-1:min(size(x,1)-1,max(nan_indices))+1,end-1:end)));
        end
    end
    %inside of matrix
    while any(isnan(x(:)))
        nan_indices=find(isnan(x));
        nan_indices=[mod(nan_indices,column_length) ceil(nan_indices/column_length)];
        for i=1:size(nan_indices,1);
            x(nan_indices(i,1),nan_indices(i,2))=my_nanmean(my_nanmean(x(nan_indices(i,1)-1:nan_indices(i,1)+1,nan_indices(i,2)-1:nan_indices(i,2)+1)));
        end
    end

end
xo=x;
return

function y=my_nanmean(u)
%use nanmean from the statistics toolbox if available
try
  y=nanmean(u);
catch
  u=u(~isnan(u));
  y=mean(u);
end
