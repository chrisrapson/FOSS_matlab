function data=remove_outliers(data)
%replaces outliers in the data with nan
%makes plots more prettier

%Author: Chris Rapson

myDim=ndims(data);
if myDim>2
    error('this function can''t handle 3D matrices yet')
end


myMean=mean(data(:));
mySD=std(data(:));

for i=1:size(data,1)
    for j=1:size(data,2)
        if abs(data(i,j)-myMean)>3*mySD
            data(i,j)=nan;
        end
    end
end