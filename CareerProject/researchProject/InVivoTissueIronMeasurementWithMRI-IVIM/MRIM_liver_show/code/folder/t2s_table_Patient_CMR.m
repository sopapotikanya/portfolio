%% 1.5T CMRtool
% save_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/Result/sol5/';
% machine_name = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/DICOM/1.5T/2014-09-30/each_series/7';
% roi_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/ROI/1.5T/2014-09-30/1/';

addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));

load despath.mat
clear
close all
main_path =  '/Volumes/data2-1/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/';

%   target_path = [main_path 'Adult/Normal/'];
% target_path = [main_path 'Adult/Thalassemic/'];
%   target_path = [main_path 'Child/Normal/'];
  target_path = [main_path 'Child/Thalassemic/'];

cd(target_path)
!rm .DS_Store ._.DS_Store
patient_list = dir;
T2s_table = cell(size(patient_list,1)-2,5);
for i =3:size(patient_list,1)
    result_path = [target_path patient_list(i).name '/15_results_data.mat'];
    load(result_path);
    
    T2s_table{i-2,1} = hn;
    T2s_table{i-2,2} = t2_h;
    T2s_table{i-2,3} = t2_ll;
    T2s_table{i-2,4} = t2_lr;
    T2s_table{i-2,5} = t2_p;
end

