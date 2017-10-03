function varargout = loadData(filenames,row,col)
%loads data from a list of filenames. 
%Each file is assumed to contain 2D data which is combined into a 3D matrix
%
%row and col give the number(s) of the row(s) and column(s) to be loaded from each file
%if row or col is the string 'end', then the entire matrix will be loaded
%
%the resulting matrix will have a size: row x col x n(filenames)

%Author: Chris Rapson

temp=load(filenames(1).name);
if min(size(temp))>1 && length(row)>1 && length(col)>1 %strcmp(row,'end') && strcmp(col,'end')
    outData=zeros([size(temp)],length(filenames));
else
    outData=zeros(length(temp),length(filenames));
end

for i=1:length(filenames)
    if mod(i,100)==0
        i
    end
    
    if filenames(i).bytes>0
        temp=load(filenames(i).name);
        if min(size(temp))>1 && length(row)>1 && length(col)>1 %strcmp(row,'end') && strcmp(col,'end')
            if strcmp(row,'end')
                if strcmp(col,'end')
                    outData(:,:,i)=temp;
                else
                    outData(:,:,i)=temp(:,col);
                end
            else
                if strcmp(col,'end')
                    outData(:,:,i)=temp(row,:);
                else
                    outData(:,:,i)=temp(row,col);
                end           
            end
        else
            if strcmp(row,'end')
                if strcmp(col,'end')
                    outData(:,i)=temp;
                else
                    outData(:,i)=temp(:,col);
                end
            else
                if strcmp(col,'end')
                    outData(:,i)=temp(row,:);
                else
                    outData(:,i)=temp(row,col);
                end           
            end
        end
    end
end


varargout={outData};
if nargout==2
    varargout{2}=temp(:,1);
end

return