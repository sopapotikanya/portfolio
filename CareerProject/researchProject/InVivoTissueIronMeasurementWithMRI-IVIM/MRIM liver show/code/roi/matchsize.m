function [roi_resize,dicom_img] = matchsize(dcm_name,roi_img)

dcm = dicomread(dcm_name);
sizeDCM = size(dcm,1);
sizeIMG = size(roi_img,1);
% roi_resize=imresize(roi_img,sizeDCM/sizeIMG, 'nearest');
roi_resize=imresize(roi_img,sizeDCM/sizeIMG, 'bilinear');  %for phantom

dicom_img = dcm;
vmaxdcm = max(max(dicom_img));
for i = 1:size(dcm,1)
        for j = 1:size(dcm,2)
            if roi_resize(i,j) == 1
                dicom_img(i,j) = vmaxdcm;
            end
        end
end