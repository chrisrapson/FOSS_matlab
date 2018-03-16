function s = date_for_filenames
%provides today's date in a format suitable for including in filenames
%files can then be sorted by this number
%e.g. on 5 March 2017, the output will be 20170305

c=clock;
s=[sprintf('%04d',c(1)),sprintf('%02d',c(2)),sprintf('%02d',c(3))];