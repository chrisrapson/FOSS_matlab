function stringOut=bashify(stringIn)
%convert strings to be comatible with bash conventions
%e.g. prior to calling unix(string)
% using the following conversions:
%
% (       : \(     
% )       : \)
% [       : \[
% ]       : \]
% '       : \'
% _space_ : \ <-a space
%
% e.g. v(t) [ms^-^1]
% ---> v\(t\) \[ms^-^1\]
%
% take care not to bashify commands, i.e. don't turn ls -l into ls\ -l
%
% See also: latexify titleify simulinkify

%Author: Chris Rapson

illegalChars='()[]'' ';
replacementChars=[{'\('},{'\)'},{'\['},{'\['},{'\'''},{'\ '}];

for i=1:length(illegalChars)
    stringIn=strrep(stringIn,illegalChars(i),replacementChars{i});
end
% for i=1:length(illegalChars)
%     maxJ=length(stringIn);
%     j=1;
%     while j<=maxJ% j=1:maxJ%length(stringIn)
%         n=length(replacementChars{i});
%         if stringIn(j)==illegalChars(i);
%             stringIn=[stringIn,sprintf('%d',ones(1,n-1))];
%             stringIn(j+n:end)=stringIn(j+1:end-n+1);
%             stringIn(j:j+n-1)=replacementChars{i};
%             maxJ=length(stringIn);
%             j=j+length(replacementChars{i})-length(illegalChars(i));
%         end
%         j=j+1;
%     end
% end

stringOut=stringIn;
return          