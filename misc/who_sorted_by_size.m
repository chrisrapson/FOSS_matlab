% function who_sorted_by_size
% doesn't work as a function cos it needs access to current workspace
% therefore needs strange variable names to avoid overwriting others in the
% current workspace

%Author: Chris Rapson

who_sorted_by_size_my_who=whos;
who_sorted_by_size_my_numel={who_sorted_by_size_my_who(:).bytes};%cellfun(@numel,my_who);
who_sorted_by_size_my_numel=cell2mat(who_sorted_by_size_my_numel);
[who_sorted_by_size_sorted_numel,who_sorted_by_size_I]=sort(who_sorted_by_size_my_numel,'descend');
who_sorted_by_size_sorted_who=who_sorted_by_size_my_who(who_sorted_by_size_I);
for who_sorted_by_size_sorted_i=1:length(who_sorted_by_size_sorted_who)
	who_sorted_by_size_spacing=' '*ones(1,max([2,20-length(who_sorted_by_size_sorted_who(who_sorted_by_size_sorted_i).name)]));
	who_sorted_by_size_my_disp{who_sorted_by_size_sorted_i}=strcat(who_sorted_by_size_sorted_who(who_sorted_by_size_sorted_i).name, who_sorted_by_size_spacing, num2str(who_sorted_by_size_sorted_numel(who_sorted_by_size_sorted_i)));
end
who_sorted_by_size_my_disp'

who_sorted_by_size_total_mem=sum(who_sorted_by_size_sorted_numel);
disp(['total memory used by variables in current workspace: ',num2str(round(who_sorted_by_size_total_mem/1024/1024)),'MBytes']);

clear who_sorted_by_size_*