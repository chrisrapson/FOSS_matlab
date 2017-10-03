function [vector_handles,bitmap_handles]=sort_out_handles(H)
%identify which elements of a figure are
%well suited to be saved in a vector format
%and which are better suited to raster format
%
%things to save as vectors:
%everything in the legend
%axes
%text, i.e. title and labels
%lines
%the complete colorbar
%
%things to save as bitmaps
%2D images, i.e. patch/surf/image EXCEPT those in the legend or colorbar

%Author: Chris Rapson

%just to cover all types of types
% figNur=findall(H,'type','figure'); 
% otherstuff=findall(H,'type','uimenu');

%stuff for vector output
allLines  = findall(H, 'type', 'line'); %includes lines in the legend
allText   = findall(H, 'type', 'text'); %includes text in the legend
allAxes   = findall(H, 'type', 'axes'); %includes legend and colorbar

%stuff for bitmap output
allImages = findall(H, 'type', 'image');%includes TMW_COLORBAR
allLights = findall(H, 'type', 'light');
allPatch  = findall(H, 'type', 'patch');
allSurf   = findall(H, 'type', 'surface');
allRect   = findall(H, 'type', 'rectangle');

vector_handles=[allLines;allText;allAxes];
% counter_vector=length(vector_handles);

% counter_bitmap=1;
bitmap_handles=[];

%extract TMW_COLORBAR handles from Images and include them in vector_handles
%Colorbar handles are in allAxes, and so are already included
cb_TMW=findall(allImages,'tag','TMW_COLORBAR');
if ~isempty(cb_TMW)
    for i=length(cb_TMW):-1:1
        cb_index(i)=find(allImages==cb_TMW(i));
    end
    vector_handles=[vector_handles;cb_TMW];
%     counter_vector=counter_vector+length(cb_TMW);
    allImages(cb_index)=[];
end

% %extract colorbar handles and include them in bitmap_handles
% %this is the reverse of the above process for TMW_COLORBAR
% %only one of these should be uncommented
% %usually the TMW_COLORBAR (other) one, since this ones creates problems
% %with changing colorbar handles on changing visibility
% cb_cb=findall(allAxes,'tag','colorbar')
% if ~isempty(cb_cb)
%     cb_index=find(allAxes==cb_cb);
%     bitmap_handles=[bitmap_handles;cb_cb];
%     allAxes(cb_index)=[];
% end

%extract the legend and all children and include them in vector_handles
lh=findall(H,'tag','legend'); %this is an axis, so already included in vector_handles
if ~isempty(lh)
    lh_children=get(lh,'Children');
    if ~isempty(lh_children)
        vector_handles=[vector_handles;lh_children];
%         counter_vector=counter_vector+length(lh_children);
        for i=1:length(lh_children)
            if ~iscell(lh_children) %cell type returned if more than one legend on the plot
                                    %since legends are lines and text, this can be ignored... right?
                lhc_type=get(lh_children(i),'type'); %lines, patches, surfs whatever
                if strcmp(lhc_type,'line') || strcmp(lhc_type,'axes') || strcmp(lhc_type,'text')
                    %do nothing
                elseif strcmp(lhc_type,'image')
                    lh_index=find(allImages==lh_children(i));
                    allImages(lh_index)=[];
                elseif strcmp(lhc_type,'light')
                    lh_index=find(allLights==lh_children(i));
                    allLights(lh_index)=[];
                elseif strcmp(lhc_type,'patch')
                    lh_index=find(allPatch==lh_children(i));
                    allPatch(lh_index)=[];
                elseif strcmp(lhc_type,'surface')
                    lh_index=find(allSurf==lh_children(i));
                    allSurf(lh_index)=[];
                elseif strcmp(lhc_type,'rectangle')
                    lh_index=find(allRect==lh_children(i));
                    allRect(lh_index)=[];
                end
            end
        end
    end
end
        
bitmap_handles=[allImages;allLights;allPatch;allSurf;allRect];
return