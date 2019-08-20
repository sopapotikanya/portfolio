function batch_Phantom_ROI
dir_dcm = dir('DICOM/');
dcm_name = dir_dcm(3).name;
dir_cmr = dir('ROI/ROI*');
ROI_folder = 'ROI';
for  j=1:size(dir_cmr,1)
    filename = strsplit(dir_cmr(j).name,'.');
    if size(filename,2) == 3
        CMRtool_name = dir_cmr(j).name
        [roi, orig_img_fig, dicom_img_fig] = liver_ROI_RGBDCM(['ROI/' CMRtool_name],['DICOM/' dcm_name]);
        delete([ROI_folder '/' filename{1,1} ' .mat']);
        delete([ROI_folder '/orig_img_' filename{1,1} ' .jpg']);
        delete([ROI_folder '/dicom_img_fig_' filename{1,1} ' .jpg']);
        save([ROI_folder '/' filename{1,1} '.mat'],'roi');
        saveas(orig_img_fig,[ROI_folder '/orig_img_' filename{1,1} '.jpg']) ;
        saveas(dicom_img_fig,[ROI_folder '/dicom_img_fig_' filename{1,1} '.jpg']) ;
        close all;
    end
end

