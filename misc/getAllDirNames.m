function dirNames=getAllDirNames(varargin)
% returns the names of each directory in the folder
% but excludes '.' and '..' and '.directory'
% return format is in cells
%
% INPUT
% (1) : only directory names matching this string
%
% See also: getAllFileNames

%Author: Chris Rapson

fileNames=getAllFileNames(varargin{1});
fullpath=cd(cd(varargin{1}));
counter=1;
dirNames=[];
for i=1:length(fileNames)
	if isdir(fullfile(fullpath,fileNames{i}))
		dirNames{counter}=fileNames{i};
		counter=counter+1;
	end
end