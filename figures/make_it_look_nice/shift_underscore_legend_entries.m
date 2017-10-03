function shift_underscore_legend_entries(lh)
% shifts legend entries with an underscore down so they are properly aligned
%
% INPUTS: 
% lh = legend handle (optional, otherwise the routine tries to find one)
% 

%Author: Chris Rapson

if ~exist('lh','var') || isempty(lh)
    lh=findobj(gcf,'tag','legend');
end

lhc=get(lh,'children');

counter=1;
for i=1:length(lhc)
    if ~isempty(get(lhc(i),'Tag')) && strcmp(get(lhc(i),'Type'),'line')
        myMarker(counter)=lhc(i);
    elseif strcmp(get(lhc(i),'Type'),'text')
        myText(counter)=lhc(i);
        counter=counter+1;
    end
end

for i=1:length(myText)
    myString=get(myText(i),'String');
    if strfind(myString,'_')
        textPos=get(myText(i),'position');
        textExtent=get(myText(i),'extent');
        if any(ismember(myString,'A':'Z'))
            myShift=0.26;%magic number
				else
					if strfind(myString,'\') %greek letters are smaller, so don't move them as much
						myShift=0.17;%magic number
					else
            myShift=0.25;%magic number
					end
        end
        set(myText(i),'position',[textPos(1),textPos(2)-myShift*textExtent(4) textPos(3)]);
    end
end
%%
return

%% test routine
figure
plot(1:10)
hold all
plot(1:2:20)
plot(1:3:5)
plot((1:4).^2)
plot((1:4).^1.2)
plot(sin(1:10))
legend('C_s','c_s','Cc','c_S','\beta_c','\alpha_c',2)
% lh=legend('blah_1','blah^2','blah');
shift_underscore_legend_entries%(lh)