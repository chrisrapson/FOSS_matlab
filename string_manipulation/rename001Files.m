function rename001Files
%corrects naming order of hdf or files

fileNames=dir('*hdf');%getAllFileNames;
if isempty(fileNames)
    fileNames=dir('*h5');
end

maxLength=0;
for i=1:length(fileNames)
    maxLength=max(maxLength,length(fileNames(i).name));
end

for i=1:length(fileNames)
    temp=fileNames(i).name;
    if length(temp)<maxLength
        point_location=find(temp=='.',1,'last')-1;
        myIsNum=true;
        while point_location>=1 && myIsNum
%             temp2=str2double(temp(point_location))
            if isnan(str2double(temp(point_location)))% || isempty(str2double(temp(point_location)))
                myIsNum=false;
            else
                point_location=point_location-1;
            end
        end
        filler=mat2str(zeros(1,maxLength-length(temp)));
        temp=[temp(1:point_location),filler,temp(point_location+1:end)];
        myString=['mv ',fileNames(i).name,' ',temp];
        unix(myString);
    end
end

return