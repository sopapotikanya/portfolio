function [j roi_edge] = detectColor(i)
j=zeros(size(i));
z=i;
roi_edge=zeros(size(i));
for m=1:size(i,1)
    
    check=0;
    check2=0;
    
    for n=1:size(i,2)
        if ((i(m,n,1)<=220) && (i(m,n,1)>=90)) && ((i(m,n,2)<=195) && (i(m,n,2)>=120)) && i(m,n,3)<=60 %cap from mac2
       % if ((i(m,n,1)<=220) && (i(m,n,1)>=190)) && ((i(m,n,2)<=195) && (i(m,n,2)>=170)) && i(m,n,3)<=60 %cap from mac
        %if ((i(m,n,1)<=206) && (i(m,n,1)>=180)) && ((i(m,n,2)<=185) && (i(m,n,2)>=150)) && i(m,n,3)<=25
            
            roi_edge(m,n,:)=1;
            if check2==1
                
                check=0;
            else
                check=1;
            end
        end
        if i(m,n,1)<=50 && ((i(m,n,2)>=70) && (i(m,n,2)<=130)) && i(m,n,3)<=50
%          if i(m,n,1)<=40 && ((i(m,n,2)>=70) && (i(m,n,2)<=120)) && i(m,n,3)<=40
%         if i(m,n,1)<=20 && ((i(m,n,2)>=70) && (i(m,n,2)<=100)) && i(m,n,3)<=20 %cap from mac3
        %if i(m,n,1)<=50 && ((i(m,n,2)>=110) && (i(m,n,2)<=130)) && i(m,n,3)<=50 %cap from mac2
        %if i(m,n,1)<=120 && ((i(m,n,2)>=135) && (i(m,n,2)<=190)) && i(m,n,3)<=108 %cap from mac
        %if i(m,n,1)<=65 && ((i(m,n,2)>=80) && (i(m,n,2)<=150)) && i(m,n,3)<=70
        
       % if i(m,n,1)<=65 && ((i(m,n,2)>=80) && (i(m,n,2)<=150)) && i(m,n,3)<=65
            
            if check==1
                z(m,n,:)=[255,255,255];
                j(m,n,:)=1;
                roi_edge(m,n,:)=1;
                check2=1;
                
            end
            
        end
    end
end

j=im2bw(j);
[label num]=bwlabel(j);
region=regionprops(label);
area=[region.Area];
box=[region.BoundingBox];
box=reshape(box,[4,num]);
if(num>1)
delindex=find(max(area));
box(:,delindex)=[];
numbox=size(box,2);
box=round(box);
for i=1:numbox
   j(box(2,i):box(2,i)+box(4,i)-1,box(1,i):box(1,i)+box(3,i)-1)=0;
end
end

j=imfill(j,'holes');



%% roi with edge
se = strel('diamond',2);
roi_edge=imdilate(roi_edge,se);
roi_edge=imerode(roi_edge,se);
roi_edge=imerode(roi_edge,se);
roi_edge=imdilate(roi_edge,se);

roi_edge=im2bw(roi_edge);
[label num]=bwlabel(roi_edge);
region=regionprops(label);
area=[region.Area];
box=[region.BoundingBox];
box=reshape(box,[4,num]);
if(num>1)
delindex=find(max(area));
box(:,delindex)=[];
numbox=size(box,2);
box=round(box);
for i=1:numbox
   roi_edge(box(2,i):box(2,i)+box(4,i)-1,box(1,i):box(1,i)+box(3,i)-1)=0;
end
end

roi_edge=imfill(roi_edge,'holes');
