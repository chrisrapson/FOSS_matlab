function y = set_all_fields_same_string_length(x, nchar)
%make sure all strings in a struct have the same number of characters

for ii=1:length(x)
	fn = fieldnames(x(1));
	
	for jj=1:length(fn)
		if ischar(x(ii).(fn{jj}))
		
			if length(x(ii).(fn{jj})) <= nchar
				%add blanks to pad the length to nchar
				x(ii).(fn{jj}) = [x(ii).(fn{jj}) blanks(nchar - length(x(ii).(fn{jj})))];
			else
				%can't pad to nchar if it's already longer than nchar!!
				error(['string ', x(ii).(fn{jj}), ' is too long, must be <',num2str(nchar),' characters'])
			end
		elseif isstruct(x(ii).(fn{jj}))
			%recurse
			x(ii).(fn{jj}) = set_all_fields_same_string_length(x(ii).(fn{jj}), nchar);
		else
			%do nothing
			%i.e. leave numeric elements unchanged
		end
	end
end

y=x;

return

