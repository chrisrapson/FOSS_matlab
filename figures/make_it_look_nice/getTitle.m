function filename=getTitle();
%extract the title from gca, or if that 
%fails, use the figure number from gcf.
%The title can be used for saving/exporting
%the figure.

%Author: Chris Rapson

    tmp=get(get(gca,'Title'));
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
        filename=get(gcf, 'Number');
%     end
    end
return