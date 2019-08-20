function sort_phantom(label_old,label_new,phantoms_name)

% label_old = '01';
% label_new = '05';
% phantoms_name = '2014-9-30';
path = ['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/' phantoms_name '/1.5T/ROI/'];
target = ['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/' phantoms_name '/1.5T/ROI_sort_new/'];
temp = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/temp';



cd(path)
movefile(['dicom_img_fig_ROI_15_' label_old '.jpg'],['dicom_img_fig_ROI_15T_' label_old '.jpg'])
movefile(['orig_img_ROI_15_' label_old '.jpg'],['orig_img_ROI_15T_' label_old '.jpg'])
movefile(['ROI_15_' label_old '.dcm'],['ROI_15T_' label_old '.dcm'])
movefile(['ROI_15_' label_old '.mat'],['ROI_15T_' label_old '.mat'])
movefile(['ROI_15_' label_old '.rgb.dcm'],['ROI_15T_' label_old '.rgb.dcm'])
movefile(['ROI_15_' label_old '.tts'],['ROI_15T_' label_old '.tts'])

copyfile(['dicom_img_fig_ROI_15T_' label_old '.jpg'],temp)
copyfile(['orig_img_ROI_15T_' label_old '.jpg'],temp)
copyfile(['ROI_15T_' label_old '.*'],temp)

cd(temp)
movefile(['dicom_img_fig_ROI_15T_' label_old '.jpg'],[target 'dicom_img_fig_ROI_15T_' label_new '.jpg'])
movefile(['orig_img_ROI_15T_' label_old '.jpg'],[target 'orig_img_ROI_15T_' label_new '.jpg'])
movefile(['ROI_15T_' label_old '.dcm'],[target 'ROI_15T_' label_new '.dcm'])
movefile(['ROI_15T_' label_old '.mat'],[target 'ROI_15T_' label_new '.mat'])
movefile(['ROI_15T_' label_old '.rgb.dcm'],[target 'ROI_15T_' label_new '.rgb.dcm'])
movefile(['ROI_15T_' label_old '.tts'],[target 'ROI_15T_' label_new '.tts'])
