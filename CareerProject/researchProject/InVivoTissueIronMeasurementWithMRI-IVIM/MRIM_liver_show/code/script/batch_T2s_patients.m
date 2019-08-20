function batch_T2s_patients(tesla,target_path)
addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));
% save_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/Result/sol5/';
% machine_name = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/DICOM/1.5T/2014-09-30/each_series/7';
% roi_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/ROI/1.5T/2014-09-30/1/';

load despath.mat
close all
main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/';


%% 1.5T sol7

% tesla = '1.5T';
section = {'HEART','LIVER','LIVER','PANCREASE'};
% target_path = [main_path 'Adult/Thalassemic/'];
%   target_path = [main_path 'Child/Thalassemic/'];
cd(target_path)
!rm .DS_Store ._.DS_Store
patient_list = dir;


for i =3:size(patient_list,1)
    hn_path = [target_path patient_list(i).name '/'];
    for j = 1:4
        i
        dicom_path = [hn_path char(section(j)) '/' tesla '/DICOM/']
        cd(dicom_path);
        !rm .DS_Store ._.DS_Store
        dcm_dir = dir;
        stock =[];
        for z = 3:size(dcm_dir)
            temp = dcm_dir(z).name(end-1:end);
            if(strfind(temp,'_') == 1)
                temp = str2num(temp(end));
            else
                temp = str2num(temp);
            end
            stock(z-2,1) = temp;
            stock(z-2,2) = z;
            newdir = sortrows(stock);
        end
        cd(dcm_dir(newdir(1,2)).name);
        dcm_path = [dicom_path dcm_dir(newdir(1,2)).name]
        roi_path = [hn_path char(section(j)) '/' tesla '/ROI'];
        if(j==2)
            roi_name = ['roi_' dcm_dir(newdir(1,2)).name '_LT.mat'];
        elseif(j==3)
            roi_name = ['roi_' dcm_dir(newdir(1,2)).name '_RT.mat'];
        else
            roi_name = ['roi_' dcm_dir(newdir(1,2)).name '.mat'];
        end
        T2s_sol7_patients(dcm_path,roi_path,roi_name,tesla,j);
    end
end