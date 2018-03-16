function y = myLogspace(d1, d2, n, base)
%LOGSPACE Logarithmically spaced vector.
% similar to Matlab's logspace, but allows the base to be specified as an input

if nargin == 2
    n = 50;
    base=10;
elseif nargin ==3
    base=10;
end
n = double(n);

if d2 == pi || d2 == single(pi) 
    if base==10
        d2 = log10(d2);
    elseif base==exp(1)
        d2=log(d2);
    elseif base==2
        d2=log2(d2);
    else
        error('please use 2, exp or 10 for the base');
    end
end

y = (base).^ [d1+(0:n-2)*(d2-d1)/(floor(n)-1), d2];
