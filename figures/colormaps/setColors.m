function setColors(nColours)
%sets up the colourmap for the current plot
%using JET as a basis for maximum contrast
%avoids green & yellow shades cos they don't work on presentations
%input is the number of lines that will appear on the plot

set(gca,'ColorOrder',[0 0 0;jet(floor(nColours/(ceil(nColours/5))))*diag([1,0.5,1])]);
set(0,'DefaultAxesLineStyleOrder','-|--|:|-.')

return