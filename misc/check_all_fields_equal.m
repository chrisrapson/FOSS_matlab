function all_equal = check_all_fields_equal(a,b,silent)
%check whether all fields are equal.
%Check that b has the same fields first, then 
%that the contents are equal.
%
%Doesn't drill down to sub-fields.
%

%Author: Chris Rapson

all_equal=1;

if nargin<3 || isempty(silent)
  silent=0;
end

c=fieldnames(a);

for i=1:length(c)
    if ~isfield(b,(cell2mat(c(i))))
      all_equal=0;
      if ~silent  
          disp(c(i))
      else
          return
      end
    else
        if ~isequal(a.(cell2mat(c(i))),b.(cell2mat(c(i))))
            all_equal=0;
            if ~silent
                disp(c(i))
                disp(a.(cell2mat(c(i))))
                disp(b.(cell2mat(c(i))))
            else
              return
            end
        end
    end
end