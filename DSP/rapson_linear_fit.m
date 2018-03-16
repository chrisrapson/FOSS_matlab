function [gradient,intersection]=rapson_linear_fit(x,y,thru0);
% function [gradient,intersection]=rapson_linear_fit(x,y);
%returns the least mean square linear fit between two variables
%non-finite numbers are removed before making the calculation
%
%INPUTS
% x     : the independent variable
% y     : the dependent variable
% thru0 : should the fit go through 0? [boolean]
%OUTPUTS
% gradient: m in y=mx+c
% intersection: c in y=mx+c

if min(size(x))>1 || min(size(y))>1
    error('rapson_linear_fit only takes vector inputs')
end

if nargin<3 || isempty(thru0) || thru0>1
    thru0=0;
end

%columnise
x=x(:);
y=y(:);

NaN_indices=find(~isfinite(x) | ~isfinite(y));
x(NaN_indices)=[];
y(NaN_indices)=[];

%add in x=0 y=0 if the fit should go through zero
if thru0
    x=[zeros(size(x));x];
    y=[zeros(size(y));y];
end

x=[x ones(size(x))];

if rank(x)~=1
    temp=x\y;
else
    if all(x(:,1)==x(1,1)) %guard against vertical case
        temp=[Inf,NaN];
    else
        if max(x(:))>1e13*min(x(:))%matlab has problems with numerical accuracy for large numbers
            if max(x(:))>1e6
                x=x(:,1:end-1)./1e10;
                [temp(1) temp(2)]=rapson_linear_fit(x,y);
                temp(1)=temp(1)/1e10;
            else %min(x(:))<1e6
                x=x(:,1:end-1).*1e10;
                [temp(1) temp(2)]=rapson_linear_fit(x,y);
                temp(1)=temp(1)*1e10;
            end
        else
            warning('x vector is constant')
            temp(1)=inf;
            temp(2)=0;%NaN;
        end
    end
end
gradient=temp(1);
intersection=temp(2);

return