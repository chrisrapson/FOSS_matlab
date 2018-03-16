cd /afs/ipp-garching.mpg.de/home/r/rapsonc/rapsonc/MATLAB/DCS/kk/archive_20110513/
files_dir1=getAllFileNames;

cd /afs/ipp-garching.mpg.de/common/soft/matlab_app/lib/kk/
files_dir2=getAllFileNames;

n_found=0;

for i=1:length(files_dir1)
% 	if ~isempty(strfind(files_dir2,files_dir1{i}))
	if sum(strcmp(files_dir2,files_dir1{i}))==1
		n_found=n_found+1;
	elseif sum(strcmp(files_dir2,files_dir1{i}))==0
		disp([files_dir1{i},' not found in dir2'])
	else
		disp('that''s weird...')
	end
end

if n_found==i
	disp('all files in dir1 are also in dir2')
else
	disp([num2str(i-n_found),' files from dir1 are missing from dir2'])
end
