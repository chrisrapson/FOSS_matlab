function c = genpath_exclude_rapsonc(d,excludeDirs)
%
% See also: genpath, genpath_exclude

% Author: Chris Rapson 20140407

	% if the input is a string, then use it as the searchstr
	if ischar(excludeDirs)
		excludeStr = excludeDirs;
	else
		excludeStr = '';
		if ~iscellstr(excludeDirs)
			error('excludeDirs input must be a cell-array of strings');
		end
		
		for i = 1:length(excludeDirs)
			excludeStr = [excludeStr '|' excludeDirs{i} ];
		end
	end

	a=genpath(d); %get all directories in one big string
	b=textscan(a,'%s','Delimiter',':'); b=b{1}; %convert the string to a cell array
	c=[]; %initialise output
	for ii=1:length(b)
		if isempty(regexp(b{ii},excludeStr)) 
			c=[c,b{ii},':'];
		end 
	end
	c=c(1:end-1); %remove final colon
end