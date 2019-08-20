function [ROI, Y, ratio] = ratioDCM(IMG,ROIpng,DCM)


Y = DCM;
[rowDCM colDCM] = size(Y);
ROI = zeros(rowDCM,colDCM);
leftDCM = 0;
rightDCM = 0;
topDCM = 0;
for i = 1:colDCM
    for j = 1:rowDCM
        if Y(j,i) > 0
            leftDCM = i;
            break;
        end
    end
    if leftDCM > 0
        break;
    end
end

for i = colDCM: -1:0
    for j = 1:rowDCM
        if Y(j,i) > 0
            rightDCM = i;
            break;
        end
    end
    if rightDCM > 0
        break;
    end
    
end

for j = 1:rowDCM
    for i = 1:colDCM
        if Y(j,i) > 100
            topDCM = j;
            break;
        end
    end
    if topDCM > 0
        break;
    end
    
end

for j = 1:rowDCM
    Y(j,leftDCM) = 255;
    Y(j,rightDCM) = 255;
end
for i = 1:colDCM
    Y(topDCM,i) = 255;
end

%figure('name','DCM'), imshow(Y, 'DisplayRange',[]);





[rowIMG colIMG channel] = size(IMG);
leftIMG = 0;
rightIMG = 0;
topIMG = 0;
for i = 1:colIMG
    for j = 1:rowIMG
        if (IMG(j,i) > 0 && ((IMG(j,i,1)==IMG(j,i,2)) &&(IMG(j,i,1)==IMG(j,i,3))))
            leftIMG = i;
            break;
        end
    end
    if leftIMG > 0
        break;
    end
end

for i = colIMG: -1:0
    for j = 1:rowIMG
        if IMG(j,i) > 0 && (IMG(j,i,1)==IMG(j,i,2)) &&(IMG(j,i,1)==IMG(j,i,3))
            rightIMG = i;
            break;
        end
    end
    if rightIMG > 0
        break;
    end
    
end

for j = 1:rowIMG
    for i = 1:colIMG
        if IMG(j,i) > 100 && (IMG(j,i,1)==IMG(j,i,2)) &&(IMG(j,i,1)==IMG(j,i,3))
            topIMG = j;
            break;
        end
    end
    if topIMG > 0
        break;
    end
    
end

for j = 1:rowIMG
    IMG(j,leftIMG,:) = [255,255,255];
    IMG(j,rightIMG,:) = [255,255,255];
end

for j = 1:colIMG
    IMG(topIMG,j,:) = [255,255,255];
end

%figure('name','IMG'), imshow(IMG)

dxDCM = rightDCM - leftDCM;
dxIMG = rightIMG - leftIMG;
ratio = dxDCM/dxIMG;

resizeIMG = imresize(IMG,ratio);
% figure('name','resizeIMG'), imshow(resizeIMG);

ROIpng(:,rightIMG+1:colIMG) = [];
ROIpng(:,1:leftIMG-1) = [];
ROIpng(1:topIMG,:) = [];

% resizeROI = imresize(ROIpng,ratio);
%figure('name','resizeROInearest'), imshow(resizeROI);
resizeROI = imresize(ROIpng,ratio,'nearest');
%figure('name','resizeROI'), imshow(resizeROI);

ROI(topDCM:size(resizeROI,1)+topDCM-1,leftDCM:rightDCM) = resizeROI;
%figure('name','ROI'), imshow(ROI);
vmaxdcm = max(max(Y));
for i = 1:rowDCM
    for j = 1:colDCM
        if ROI(i,j) == 1
            Y(i,j) = vmaxdcm;
        end
    end
end

%% resize not use nearest
resizeROI_defaut = imresize(ROIpng,ratio);
resizeROI_bilinear = imresize(ROIpng,ratio,'bilinear');
resizeROI_bicubic = imresize(ROIpng,ratio,'bicubic');

ROI1(topDCM:size(resizeROI,1)+topDCM-1,leftDCM:rightDCM) = resizeROI_defaut;
ROI2(topDCM:size(resizeROI,1)+topDCM-1,leftDCM:rightDCM) = resizeROI_bilinear;
ROI3(topDCM:size(resizeROI,1)+topDCM-1,leftDCM:rightDCM) = resizeROI_bicubic;

%%
%  figure('name','DCMwithROI')
%  subplot(2,3,1), imshow(Y, 'DisplayRange',[]) 
% title('dicom')
%  subplot(2,3,2), imshow(ROI)
% title('nearest')
% subplot(2,3,3), imshow(resizeIMG);
% title('normal')
% subplot(2,3,4), imshow(ROI1)
% title('default ')
% subplot(2,3,5), imshow(ROI2)
% title('bilinear')
% subplot(2,3,6), imshow(ROI3)
% title('bicubic')






