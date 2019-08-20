function [ultimate_extra_translator_roi3] = transfer15to3(dcm15,dcm3,roi15,roi3)
%% convert uint16 to unit8
dcm15_8 = uint8(dcm15);
dcm3_8 = uint8(dcm3);


%% convert to binary by set threshold (and imfill)
bw_dcm15 = im2bw(dcm15_8);
bw_dcm15 = imfill(bw_dcm15, 'holes');

bw_dcm3 = im2bw(dcm3_8);
bw_dcm3 = imfill(bw_dcm3, 'holes');

%% find ratio of 1.5t and 3t circle form region prop
re15 = regionprops(bw_dcm15);
re3 = regionprops(bw_dcm3);

del_index15 = [re15.Area] < 2000;
del_index3 = [re3.Area] < 2000;
 
re15(del_index15) = '';
re3(del_index3) = '';

r15 = (re15.BoundingBox(3)+re15.BoundingBox(4))/2;
r3 = (re3.BoundingBox(3)+re3.BoundingBox(4))/2;
ratio153 = r15/r3;
ratio315 = r3/r15;

%% extract 1.5t from background and resize to same ratio 3t
res_b15 = imresize(bw_dcm15, ratio315);
res_dcm15 = imresize(dcm15_8, ratio315);
res_roi15 = imresize(roi15, ratio315);

reB15= regionprops(res_b15);


%% create zeros to putdown crop15->3
new = zeros(240,240);
new2 = zeros(240,240);
new2 = uint8(new2);

new_roi15 = zeros(240,240);


str3_y = re3.BoundingBox(2);
wide315_y = re3.BoundingBox(2)+reB15.BoundingBox(4);
str3_x = re3.BoundingBox(1);
wide315_x = re3.BoundingBox(1)+reB15.BoundingBox(3);

str15_y = reB15.BoundingBox(2);
wide15_y = reB15.BoundingBox(2)+reB15.BoundingBox(4);
str15_x = reB15.BoundingBox(1);
wide15_x = reB15.BoundingBox(1)+reB15.BoundingBox(3);

new(str3_y:wide315_y,str3_x:wide315_x)=res_b15(str15_y:wide15_y,str15_x:wide15_x);
new2(str3_y:wide315_y,str3_x:wide315_x)=res_dcm15(str15_y:wide15_y,str15_x:wide15_x);
new_roi15(str3_y:wide315_y,str3_x:wide315_x)=res_roi15(str15_y:wide15_y,str15_x:wide15_x);

re_roi15 = regionprops(new_roi15); %regionprop roi15
re_roi3 = regionprops(roi3);       %regionprop roi3

% figure ,imshow(new2)
% figure('dicom 3') ,imshow(dcm3_8)
% figure('dicom 1.5') ,imshow(dcm15_8)

%% rotate 1.5  to same 3t  by using ?

re_roi15.Centroid; 
re_roi3.Centroid;
origin = re3.Centroid;

vo15(1,1) =  re_roi15.Centroid(1) - origin(1);
vo15(2,1) =  re_roi15.Centroid(2) - origin(2);

vo15_euclid = sqrt((vo15(1,1)^2)+(vo15(2,1)^2));

vo3(1,1) =  re_roi3.Centroid(1) - origin(1);
vo3(2,1) =  re_roi3.Centroid(2) - origin(2);

vo3_euclid = sqrt((vo3(1,1)^2)+(vo3(2,1)^2));

angle_rotate = acos(dot(vo15,vo3)/(vo15_euclid*vo3_euclid))*180/pi;

if(angle_rotate >=5)
    
    if( (vo3(1) >= vo15(1)) && (vo3(2) <= vo15(2)) || (vo3(1) <= vo15(1)) && (vo3(2) >= vo15(2)))
    %     rotROI = imrotate(new_roi15,angle_rotate*1,'bilinear','CROP');
        rotROI = imrotate(new_roi15,angle_rotate*1);
    %     rotROI = imrotate(new_roi15,angle_rotate*1,'CROP');
        rotDCM = imrotate(new2,angle_rotate*1,'bilinear','CROP');
    elseif( (vo3(1) >= vo15(1)) && (vo3(2) >= vo15(2)) || (vo3(1) <= vo15(1)) && (vo3(2) <= vo15(2)))
    %     rotROI = imrotate(new_roi15,angle_rotate*-1,'bilinear','CROP');
            rotROI = imrotate(new_roi15,angle_rotate*-1);
    %         rotROI = imrotate(new_roi15,angle_rotate*-1,'CROP');
        rotDCM = imrotate(new2,angle_rotate*-1,'bilinear','CROP');
    end
    
else
    rotROI = new_roi15;
    rotDCM = new2;
end

% figure('Name','rotate 1.5 roi') ,imshow(rotROI)
% % figure('Name','rotate- 1.5 roi') ,imshow(rotROIminus)
% figure('Name','rotate 1.5 dcm') ,imshow(rotDCM)
% figure('Name','1.5 dcm') ,imshow(new2)
% % figure ,imshow(roi15)
% figure('Name','dicom 3') ,imshow(dcm3_8)
% figure('Name','3 roi') ,imshow(roi3)

%% move roi15_rotate to roi3 centroid

re_rotate_roi15 = regionprops(uint8(rotROI));

super_new_roi15 = zeros(240,240);


str3_y = re_roi3.Centroid(2)-(re_rotate_roi15.BoundingBox(4)/2);
wide315_y = str3_y+re_rotate_roi15.BoundingBox(4);
str3_x = re_roi3.Centroid(1)-(re_rotate_roi15.BoundingBox(3)/2);
wide315_x = str3_x+re_rotate_roi15.BoundingBox(3);

str15_y = re_rotate_roi15.BoundingBox(2);
wide15_y = re_rotate_roi15.BoundingBox(2)+re_rotate_roi15.BoundingBox(4);
str15_x = re_rotate_roi15.BoundingBox(1);
wide15_x = re_rotate_roi15.BoundingBox(1)+re_rotate_roi15.BoundingBox(3);

super_new_roi15(str3_y:wide315_y,str3_x:wide315_x)=rotROI(str15_y:wide15_y,str15_x:wide15_x);

ultimate_extra_translator_roi3 = logical(round(super_new_roi15));

super_new_roi15 = uint8(super_new_roi15);
super_new_roi15_16 = uint16(super_new_roi15);

super_new_roi15(super_new_roi15>0)=255;
super_new_roi15_16(super_new_roi15_16>0)=1000;

% god_roi = (dcm3)+super_new_roi15;
% god_roi_16 = (dcm3)+super_new_roi15_16;

% figure ,imshow(super_new_roi15)
% figure ,imshow(god_roi)


%% save
% god_roi_fig = figure;
% imshow(god_roi_16);
%     imcontrast;
% saveas(god_roi_fig,'testsave.png');

