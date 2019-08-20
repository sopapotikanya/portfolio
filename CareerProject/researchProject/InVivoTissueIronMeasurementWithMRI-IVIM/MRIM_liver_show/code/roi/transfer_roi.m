function [roi, orig_img_fig, dicom_img_fig,crop_img, roi_img] = transfer_roi(CMRtool_name,dcm_name)
% tranfer ROI from picture.rgb.dcm that draw roi by CMRtools Program
% Method
% 1. crop image in dicom part , not have graft
% 2. extract color that draw by CMRtools Program. It have green color 
% 3. resize roi result equal to DICOM size
%
% Example
% transfer_roi('CMRtools.rgb.dcm','DICOM.dcm')

path = pwd;

orig_img = dicomread(CMRtool_name);

crop_img=imcrop(orig_img,[1 385 382 382]);

roi_img = detectColor(crop_img);

[roi,dicom_img] = matchsize(dcm_name,roi_img);

orig_img_fig = figure('Name', path);
imshow(orig_img);
dicom_img_fig = figure('Name', path);
imshow(dicom_img,'DisplayRange',[]);
