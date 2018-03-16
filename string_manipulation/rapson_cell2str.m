function y = rapson_cell2str(x)
%converts a multi-element array to a single string

y='';
%x={x{:}};%merges columns first, then rows
for ii=1:size(x,2)
	for jj=1:size(x,1)
		if ischar(x{jj,ii})
			y=[y,cell2mat(x(jj,ii))];
		elseif isnumeric(x(jj,ii))
			y=[y,num2str(x(jj,ii))];
		end
		y=[y,', '];
	end
end
y=y(1:end-2);

return