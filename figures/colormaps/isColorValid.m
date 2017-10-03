function y = isColorValid(x)
%determines if x is a valid color to be used with the plot command in matlab

%Author: Chris Rapson

validChars={'b','g','r','c','m','y','k','w'};
validStrings={'blue','green','red','cyan','magenta','yellow','black','white','none'};

if ischar(x)
	if length(x)==1
		if any(strcmpi(validChars,x))
			y=1;
		else
			y=0;
		end
		return
	else
		if any(strcmpi(validStrings,x))
			y=1;
		else
			y=0;
		end
		return
	end
elseif isnumeric(x)
	if length(x)==3 && all(x>0) && all(x<1)
		y=1;
	else
		y=0;
	end
	return
else
	y=0;
	return
end
	
%% test isColorValid
% figure
% % c='m';
% % c='M';
% % c='j';
% % c=[0.5 0.5 0.5];
% % c=[1.1 1 0];
% % c=[0.5 NaN 0.5];
% % c='green';
% % c='Green';
% if ~isColorValid(c)
% 	if ischar(c)
% 		disp([c,' is not a valid color, but try anyway'])
% 	else
% 		disp([num2str(c),' is not a valid color, but try anyway'])
% 	end
% end
% % plot(1:10,c) %only works with letters
% plot(1:10,1:10,'color',c)
