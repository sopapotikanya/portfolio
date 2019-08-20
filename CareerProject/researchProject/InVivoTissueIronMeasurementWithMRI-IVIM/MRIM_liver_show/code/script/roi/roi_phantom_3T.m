addpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code/')
path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantom/DICOM/3T/';
cd(path);
date_name = dir('20*');

for i=1:size(date_name,1)
    dcm_name  =  dir([path date_name(i).name '/each_series/7/']);
    
    save_path = ['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantom/ROI/3T/' date_name(i).name '/'];
    DICOM = dcm_name(3).name;
    
    draw_phantom(savepath,DICOM)
end
