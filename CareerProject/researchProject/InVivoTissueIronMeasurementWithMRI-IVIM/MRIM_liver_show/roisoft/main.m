% name = 'test';
% image = [name '.JPG'];
% DCM = 'IM-0046-0001.dcm';
% 
% 
% cropimg = detectRoi(image);
% ROIpng = detectColor(cropimg);
% [ROI, ratio] = ratioDCM(cropimg,ROIpng,DCM);
% ROI = uint8(ROI);
% save([name '.mat'],'ROI');

%img = imread('/data2/data_staff/iEarth_data/Liver_project/data/1152034_KAMONTIP/1152034-T2STAR_LIVER_LT_4.JPG');
%img = imread('/data2/data_staff/iEarth_data/Liver_project/data/1152034_KAMONTIP/1152034-T2STAR_LIVER_LT_3.JPG');
%img = imread('/data2/data_staff/iEarth_data/Liver_project/data/1152034_KAMONTIP/1152034-T2STAR_LIVER_LT_2.JPG');
% img = imread('/data2/data_staff/iEarth_data/Liver_project/data/1152034_KAMONTIP/1152034-T2STAR_HEART_2.JPG');
% 2824720_T2star_HEART_1.JPG
img = imread('/data2/data_staff/iEarth_data/Liver_project/data/2824720_อิ่มทรัพย์/2824720_T2star_HEART_1.JPG');

normal_img=detectRoi2(img);
%figure, imshow(normal_img);
BW = zeros(size(normal_img,1),size(normal_img,2));
BWy = zeros(size(normal_img,1),size(normal_img,2));
BWg = zeros(size(normal_img,1),size(normal_img,2));
img = normal_img;
count = 0;
for m=1:size(normal_img,1)
    for n=1:size(normal_img,2)
        %if (normal_img(m,n,1)==normal_img(m,n,1)) && (normal_img(m,n,1)==normal_img(m,n,3)) || (normal_img(m,n,1)+normal_img(m,n,2)+normal_img(m,n,3) <= 20)            
        if (normal_img(m,n,2)-normal_img(m,n,3) > 30) %|| (normal_img(m,n,1)-normal_img(m,n,3) > 20)
            BW(m,n,1) = 1;
            count = count +1;
            R(count) = img(m,n,1);
            G(count) = img(m,n,2);
            B(count) = img(m,n,3);
            if normal_img(m,n,1) >= 140
                BWy(m,n,1) = 1;
            else
                BWg(m,n,1) = 1;
            end
        else
            BW(m,n,1) = 0;
            img(m,n,:) = 0;
        end
    end
end

% i = normal_img;
% j=zeros(size(i));
% roi_edge=zeros(size(i));
% 
% for m=1:size(i,1)
%     check=0;
%     check2=0;
%     for n=1:size(i,2)
%         if (i(m,n,2)-i(m,n,3) > 30)            
%               % yellow
%               if i(m,n,1) >= 100
%                   if check == 0 || check == 1
%                       check=1;
%                   end
%                   if check == 2 || check == 3
%                       check = 3;
%                   end
%                   roi_edge(m,n,:)=1;
%               % green
%               else
%                   if check == 1 || check == 2
%                       j(m,n,:)=1;
%                       roi_edge(m,n,:)=1;
%                       check = 2;
%                   else
%                       check = 0;
%                   end
%               end
%         else
%             check=0;
%             check2=0;
%         end
%     end
% end
     
figure, imshow(BW);
figure, imshow(BWy);
figure, imshow(BWg);
% figure, imshow(j);
% figure, imshow(roi_edge);
% %% roi with edge
% se = strel('diamond',3);
% j=imerode(j,se);
% j=imdilate(j,se);
% 
% j=imdilate(j,se);
% j=imerode(j,se);
% 
% figure, imshow(j);
% j=im2bw(j);
% [label num]=bwlabel(j);
% j=regionprops(label);
% area=[region.Area];
% box=[region.BoundingBox];
% box=reshape(box,[4,num]);
% if(num>1)
% delindex=find(max(area));
% box(:,delindex)=[];
% numbox=size(box,2);
% box=round(box);
% for i=1:numbox
%    j(box(2,i):box(2,i)+box(4,i)-1,box(1,i):box(1,i)+box(3,i)-1)=0;
% end
% end
% 
% j=imfill(j,'holes');
% 
% figure, imshow(j);
%figure, imshow(img);

figure, imhist(R);
figure, imhist(G);
figure, imhist(B);

% Rmax = max(max(img(:,:,1)));
% Gmax = max(max(img(:,:,2)));
% Bmax = max(max(img(:,:,3)));
% Rmin = min(min(img(:,:,1)));
% Gmin = min(min(img(:,:,2)));
% Bmin = min(min(img(:,:,3)));
%figure, imhist(img);
%[roi_img roi_img_edge]=detectColor2(normal_img);