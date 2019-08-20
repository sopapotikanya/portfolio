function [j roi_edge] = detectColor2(i)
j=zeros(size(i));
test = j;
z=i;
g=i;
roi_edge=zeros(size(i));

%yellow == R=G,R>B 100;
%green == R=B,G>R 50;
% for m=1:size(i,1)
%     
%     check=0;
%     check2=0;
%   
%     for n=1:size(i,2)
%         
%         % if green
%         %if (i(m,n,2)-i(m,n,3) > 30) && i(m,n,1) < 100
%         if i(m,n,1)<=100 && ((i(m,n,2)>=80) && (i(m,n,2)<=255)) && i(m,n,3)<=129
%         %if i(m,n,1)<=100 && ((i(m,n,2)>=130) && (i(m,n,2)<=255)) && i(m,n,3)<=129
%         %if ((abs(i(m,n,1)-i(m,n,3)) < 20) && ((abs(i(m,n,2)-i(m,n,1)) > 50) || (abs(i(m,n,2)-i(m,n,3)) > 50)))
%         
%         %if ((abs(i(m,n,2)-i(m,n,1)) > 50) && (abs(i(m,n,2)-i(m,n,3)) > 50))
%             z(m,n,:)=[0 255 0];
%            
%             if check==1
%                 z(m,n,:)=[255,255,255];
%                 
%                 j(m,n,:)=1;
%                 roi_edge(m,n,:)=1;
%                 check2=1;  %% have a seen green color
%             
%                     
%             end
%             
%         %end
%         
%         % if yellow
%         %elseif (i(m,n,2)-i(m,n,3) > 30) 
%         elseif ((i(m,n,1)<=195) && (i(m,n,1)>=101)) && ((i(m,n,2)<=200) && (i(m,n,2)>=100)) && (i(m,n,3)<=80)
%         %elseif ((i(m,n,1)<=195) && (i(m,n,1)>=101)) && ((i(m,n,2)<=200) && (i(m,n,2)>=130)) && (i(m,n,3)<=90)
%         %elseif ((((abs(i(m,n,1)-i(m,n,3)) > 100) || (abs(i(m,n,2)-i(m,n,3)) > 100))) && (i(m,n,3) ~= 0))
%             roi_edge(m,n,:)=1;
% %                z(m,n,:)=[255,0,0];
%             if check2==1
%                 
%                 check=0;
%                
%             else
%                 check=1; %% pass yellow
%             end
% 
%         end
%         
%         
%         
%         
%         if (i(m,n,1) == i(m,n,2)) && (i(m,n,1) == i(m,n,3))
%         %if ((~((abs(i(m,n,2)-i(m,n,1)) > 50) && (abs(i(m,n,2)-i(m,n,3)) > 50))) || (~((((abs(i(m,n,1)-i(m,n,3)) > 100) || (abs(i(m,n,2)-i(m,n,3)) > 100))))))
%         %if(~((((i(m,n,1)<=195)&(i(m,n,1)>=120)) & ((i(m,n,2)<=200)&(i(m,n,2)>=140)) & i(m,n,3)<=90) ||(i(m,n,1)<=100 & ((i(m,n,2)>=95)&(i(m,n,2)<=170)) & i(m,n,3)<=105)))
% 
%         %else
%             check=0;
%             check2=0;
%             
%         end
%         if ((abs(i(m,n,2)-i(m,n,1)) > 50) && (abs(i(m,n,2)-i(m,n,3)) > 50))
%             test(m,n,:)=1;
%         end
%         
%     end
% end
normal_img = i;
BW = zeros(size(normal_img,1),size(normal_img,2));
BWy = zeros(size(normal_img,1),size(normal_img,2));
BWg = zeros(size(normal_img,1),size(normal_img,2));
img = normal_img;
count = 0;
check=0;
check2=0;
for m=1:size(normal_img,1)
    for n=1:size(normal_img,2)
        if (normal_img(m,n,2)-normal_img(m,n,3) > 30)
            BW(m,n,1) = 1;
            count = count +1;
            R(count) = img(m,n,1);
            G(count) = img(m,n,2);
            B(count) = img(m,n,3);
            if normal_img(m,n,1) <= 140
                BWg(m,n,1) = 1;
                if check==1
                    z(m,n,:)=[255,255,255];

                    j(m,n,:)=1;
                    roi_edge(m,n,:)=1;
                    check2=1;  %% have a seen green color


                end
            else
                BWy(m,n,1) = 1;
                roi_edge(m,n,:)=1;
%                z(m,n,:)=[255,0,0];
                if check2==1

                    check=0;

                else
                    check=1; %% pass yellow
                end
            end
            
        else
            BW(m,n,1) = 0;
            img(m,n,:) = 0;
            check=0;
            check2=0;
        end
    end
end




%figure ,imshow(j);
se = strel('diamond',3);
j=imerode(j,se);
j=imdilate(j,se);
j=imdilate(j,se);
j=imerode(j,se);

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
%figure ,imshow(j);


%% roi with edge
se = strel('diamond',3);
roi_edge=imerode(roi_edge,se);
roi_edge=imdilate(roi_edge,se);
roi_edge=imdilate(roi_edge,se);
roi_edge=imerode(roi_edge,se);

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

