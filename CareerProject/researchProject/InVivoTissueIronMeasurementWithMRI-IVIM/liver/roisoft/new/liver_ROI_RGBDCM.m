function [roi, orig_img_fig, dicom_img_fig] = liver_ROI_RGBDCM(CMRtool_name,dcm_name)
% liver_ROI_RGBDCM('CMRtools/H1.rgb.dcm','DICOM/Heart_T2_901/IM-0036-0001.dcm','ROI')
%path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Child/Normal/2516296';
%addpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/roisoft/');
%cd(path)
path = pwd;

orig_img = dicomread(CMRtool_name);
dcm = dicomread(dcm_name);

crop_img=imcrop(orig_img,[1 385 382 382]);
% [roi_img roi_img_edge]=detectColor2(crop_img);
[roi_img] = detectColorRGBDCM(crop_img);
sizeDCM = size(dcm,1);
sizeIMG = size(roi_img,1);
% roi_resize=imresize(roi_img,sizeDCM/sizeIMG, 'nearest');
roi_resize=imresize(roi_img,sizeDCM/sizeIMG, 'bilinear');  %for phantom
roi = roi_resize;
dicom_img = dcm;
vmaxdcm = max(max(dicom_img));
for i = 1:size(dcm,1)
        for j = 1:size(dcm,2)
            if roi_resize(i,j) == 1
                dicom_img(i,j) = vmaxdcm;
            end
        end
end
orig_img_fig = figure('Name', path);
imshow(orig_img);
% crop_img_fig = figure;
% imshow(crop_img);
dicom_img_fig = figure('Name', path);
imshow(dicom_img,'DisplayRange',[]);



%     CMRtool_path = strsplit(CMRtool_name,'/');
%     
%     dcm_path = strsplit(dcm_name,'/');
%     dcm_folder = dcm_path{1,size(dcm_path,2)-1};
%     if size(strfind(CMRtool_path{1,size(CMRtool_path,2)},'LIVER'),1) == 1
%         if size(strfind(CMRtool_path{1,size(CMRtool_path,2)},'LT'),1) == 1
%             part = [dcm_folder '_LT'];
%         elseif size(strfind(CMRtool_path{1,size(CMRtool_path,2)},'RT'),1) == 1
%             part = [dcm_folder '_RT'];
%         end
%     else
%         part = dcm_folder;
%     end
% save([ROI_folder '/roi_' part ' .mat'],'roi');
% saveas(orig_img_fig,[ROI_folder '/orig_img_' part ' .jpg']) ;
% saveas(dicom_img_fig,[ROI_folder '/dicom_img_fig_' part ' .jpg']) ;
