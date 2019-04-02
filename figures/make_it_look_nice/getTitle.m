function filename=getTitle(fh,axh)
%extract the title from gca, or if that 
%fails, use the figure number from gcf.
%The title can be used for saving/exporting
%the figure.

%Author: Chris Rapson

if nargin < 1 || isempty(fh)
	fh = gcf;
end
if nargin < 2 || isempty(axh)
	axhs = get(fh,'Children'); %includes legends, but we only want axes
	for ii = length(axhs):-1:1
		if ~strcmpi(get(axhs(ii),'type'),'Axes')
			axhs(ii) = [];
		end
	end
	axh = axhs(1);
end

tmp=get(get(axh,'Title'));
if exist('tmp','var') && ~isempty(tmp.String)
		if iscell(tmp.String)
				tmp2=[tmp.String{1}];
				for i=2:length(tmp.String)
						tmp2=[tmp2,';_',tmp.String{i}];
				end
				filename=tmp2;
		else
				filename=tmp.String;
		end
else
		filename=get(fh, 'Number');
%     end
end