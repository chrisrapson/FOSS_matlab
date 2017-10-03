function stringOut=latexify(stringIn)
% makes strings suitable for use with latex
% using the following conversions:
%
% -       : minus     
% (space) : -
% .       : point
% /       : SLASH
% \       : [nothing]
% ;       : :
% {       : [nothing]
% }       : [nothing]
%
% underscore is reserved for subscript notation
%
% e.g. graph of V_b=-1.45A
% ---> graph-of-V_b=minus1point45A
%
% See also: titleify bashify simulinkify

%Author: Chris Rapson


% %version 1 %until 20120725
% illegalChars='- ./\;{}#''';
% replacementChars=[{'minus'},{'-'},{'point'},{'SLASH'},{''},{':'},{''},{''},{''},{''}];

% %version 2 %from 20120725 til...
illegalChars='_ ./\:;{}#''?()';
replacementChars=[{'__'},{'_'},{'-DOT-'},{'-S-'},{'-BS-'},{'-C-'},{'-SC-'},{''},{''},{''},{''},{'-QM-'},{'-B1-'},{'-B2'}];

for i=1:length(illegalChars)
    stringIn=strrep(stringIn,illegalChars(i),replacementChars{i});
end
% for i=1:length(illegalChars)
%     maxJ=length(stringIn);
%     n_rep=length(replacementChars{i});
%     j=1;
%     while j<=maxJ% j=1:maxJ%length(stringIn)
%         if stringIn(j)==illegalChars(i);
%             n_out=length(illegalChars(i));
%             if n_rep>=n_out%                   %if replacement is longer than existing
%                 stringIn=[stringIn,sprintf('%d',ones(1,n_rep-1))]; %make extra space
%                 stringIn(j+n_rep:end)=stringIn(j+n_rep:end);           %shift the rest backwards
%                 stringIn(j:j+n_rep-1)=replacementChars{i};         %insert replacement
%             else
%                 stringIn(j:end-n_out)=stringIn(j+n_out:end);
%                 stringIn=stringIn(1:end-n_out);
%             end
%             maxJ=length(stringIn);
%         end
%         j=j+1;
%     end
% end

if strncmp(stringIn,'-',1)
	stringIn=['D',stringIn];
end

stringOut=stringIn;
return          