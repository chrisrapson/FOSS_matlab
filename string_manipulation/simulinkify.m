function stringOut=simulinkify(stringIn)
% makes strings compatible with the simulink format
% Useful when generating blocks and blocknames programmatically
% Or for checking user input
%
% See also: latexify titleify bashify

%Author: Chris Rapson

illegalChars=':/\.([{}])@-';
replacementChars=[{'__'},{'_'},{'_'},{'__'},{'-B1-'},{'-B1-'},{'-B1-'},{'-B2-'},{'-B2-'},{'-B2-'},{'-at-'},{'_'}];

for i=1:length(illegalChars)
    stringIn=strrep(stringIn,illegalChars(i),replacementChars{i});
end

stringOut=stringIn;
return   