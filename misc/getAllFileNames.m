function fileNames = getAllFileNames(search_string,hidden)
% returns the names of each file in the folder
% always excludes '.' and '..' and '.directory'
% return format is in cells
%
% INPUTS
% search_string : only filenames matching this string
% hidden        : include hidden files? (names starting with '.' or ending with '~')
%
% See also: getAllDirNames

%Author: Chris Rapson

if nargin==0 || isempty(search_string)
    fN=dir;
elseif ~isstr(search_string)
	error('input parameter must be a string')
else
    fN=dir(search_string);
end
counter=1;
fileNames=[];

for i=1:length(fN)
	if exist('hidden','var') && ~isempty(hidden) && ~hidden
		if ~strncmp(fN(i).name,'.',1) && ~strncmp(fliplr(fN(i).name),'~',1)
			fileNames{counter}=fN(i).name;
			counter=counter+1;
		end
	else
    if (~strcmp(fN(i).name,'.') && ~strcmp(fN(i).name,'..') && ~strcmp(fN(i).name,'.directory'))
        fileNames{counter}=fN(i).name;
        counter=counter+1;
		end
	end
end