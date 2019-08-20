function batch_liver_ROI_RGBDCM(part,tesla)
% batch_liver_ROI_RGBDCM('HEART','1.5T')
% [roi, orig_img_fig, dicom_img_fig] = liver_ROI_RGBDCM('CMRtools/HEART_1.rgb.dcm','DICOM/Heart_T2_901/IM-0036-0001.dcm')
% cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Child/Normal/2516296/HEART/3T')
close all
dir_orig = pwd;
if strcmp(part,'PANCREAS')
    cd([part 'E/' tesla])
else
    cd([part '/' tesla])
end
dir_dcm = dir('DICOM/');
i1 = 1;
i2 = 1;
i3 = 1;
i4 = 1;
series1 =0;
series2 =0;
series3 =0;
series4 =0;
j = 2;
for i=1:(size(dir_dcm,1)-2)
    j = j+1;
%     dcm_list{i,1} = a(j).name;
    dcm_split = strsplit(dir_dcm(j).name,'_');
    dcm_series = dcm_split{1,size(dcm_split,2)};
    if ((size(dcm_split,2) == 3) && strcmpi(dcm_split{1,1},part) && strcmp(dcm_split{1,2},'T2'))
        if size(dcm_series,2) == 1
            dcm_list1{i1,1} = dir_dcm(j).name;
            i1 = i1+1;
            series1 = series1 +1;
        elseif size(dcm_series,2) == 2
            dcm_list2{i2,1} = dir_dcm(j).name;
            i2 = i2+1;
            series2 = series2 +1;
        elseif size(dcm_series,2) == 3
            dcm_list3{i3,1} = dir_dcm(j).name;
            i3 = i3+1;
            series3 = series3 +1;
        elseif size(dcm_series,2) == 4
            dcm_list4{i4,1} = dir_dcm(j).name;
            i4 = i4+1;
            series4 = series4 +1;
        end     
    end
end
sort1 = [];
sort2 = [];
sort3 = [];
sort4 = [];
if series1 ~= 0
    [sort1] = sort(dcm_list1);
end
if series2 ~= 0
    [sort2] = sort(dcm_list2);
end
if series3 ~= 0
    [sort3] = sort(dcm_list3);
end
if series4 ~= 0
    [sort4] = sort(dcm_list4);
end

dcm_folder_list = cat(1,sort1,sort2,sort3,sort4);
dcm_file_list = dir(['DICOM/' dcm_folder_list{1,1} '/IM-*']);


% CMRtool_name = 'CMRtools/HEART_1.rgb.dcm';
% dcm_name = 'DICOM/Heart_T2_901/IM-0036-0001.dcm';
% ROI_folder = 'ROI';

    


dcm_name = ['DICOM/' dcm_folder_list{1,1} '/' dcm_file_list(1).name]
ROI_folder = 'ROI';
CMRtool_name = ['CMRtools/' part '_1.rgb.dcm']
if strcmp(part,'LIVER')
    CMRtool_name = ['CMRtools/' part '_LT_1.rgb.dcm'];
    [roi, orig_img_fig, dicom_img_fig] = liver_ROI_RGBDCM(CMRtool_name,dcm_name);
    savePatient(CMRtool_name,dcm_name,ROI_folder,roi,orig_img_fig,dicom_img_fig);
    CMRtool_name = ['CMRtools/' part '_RT_1.rgb.dcm'];
    [roi, orig_img_fig, dicom_img_fig] = liver_ROI_RGBDCM(CMRtool_name,dcm_name);
    savePatient(CMRtool_name,dcm_name,ROI_folder,roi,orig_img_fig,dicom_img_fig);
else
    [roi, orig_img_fig, dicom_img_fig] = liver_ROI_RGBDCM(CMRtool_name,dcm_name);
    savePatient(CMRtool_name,dcm_name,ROI_folder,roi,orig_img_fig,dicom_img_fig);
end
 cd(dir_orig)
end
% cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Child/Normal/2516296/LIVER/3T')
% CMRtool_name = 'CMRtools/LIVER_LT_1.rgb.dcm';
% dcm_name = 'DICOM/LIVER_T2_1401/IM-0039-0001.dcm';
% ROI_folder = 'ROI';
% liver_ROI_RGBDCM(CMRtool_name,dcm_name,ROI_folder)
% 
% CMRtool_name = 'CMRtools/LIVER_RT_1.rgb.dcm';
% dcm_name = 'DICOM/LIVER_T2_1401/IM-0039-0001.dcm';
% ROI_folder = 'ROI';
% liver_ROI_RGBDCM(CMRtool_name,dcm_name,ROI_folder)
% 
% cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Child/Normal/2516296/PANCREASE/3T')
% CMRtool_name = 'CMRtools/PANCREAS_1.rgb.dcm';
% dcm_name = 'DICOM/PANCREAS_T2_1701/IM-0041-0001.dcm';
% ROI_folder = 'ROI';
% liver_ROI_RGBDCM(CMRtool_name,dcm_name,ROI_folder)