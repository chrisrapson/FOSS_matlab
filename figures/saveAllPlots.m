function saveAllPlots(leaveOpen, imgFormat)
%saveAllPlots
%
% use export_fig to save all open figures
% usually close figures after saving, but allow user to specify
% 'leaveOpen = 1' to keep them open
%
% file format is png by default, but can be specified in arg2
%
%
% Chris Rapson 2019-02-15

if nargin < 2 || isempty(imgFormat)
	imgFormat = '-png';
end
if nargin < 1 || isempty(leaveOpen)
	leaveOpen = 0;
end

fH = get(groot, 'Children');

for fH_ix = 1:length(fH)
	T = getTitle(fH(fH_ix));
	if isnumeric(T)
		T = num2str(T);
	end
	T = latexify(T);
	export_fig(fH(fH_ix), T, imgFormat);
	
	if ~leaveOpen
		close(fH(fH_ix))
	end
end