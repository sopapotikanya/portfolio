addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));
% save_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/Result/sol5/';
% machine_name = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/DICOM/1.5T/2014-09-30/each_series/7';
% roi_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/ROI/1.5T/2014-09-30/1/';

load despath.mat
clear all
close all
main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/';

%% 1.5T sol7
  
  tesla = '1.5T';
  section = {'HEART','LIVER','LIVER','PANCREASE'};
%   target_path = [main_path 'Adult/Normal/'];
   target_path = [main_path 'Adult/Thalassemic/'];
%    target_path = [main_path 'Child/Normal/'];
%   target_path = [main_path 'Child/Thalassemic/'];
  cd(target_path)
  !rm .DS_Store ._.DS_Store
  patient_list = dir;
 
  
                for i =3:size(patient_list,1)
                    
                    hn_path = [target_path patient_list(i).name '/'];
                    T2s_table0{i-2,1} = patient_list(i).name;
                    T2s_table1{i-2,1} = patient_list(i).name;
                    T2s_table2{i-2,1} = patient_list(i).name;
                    T2s_table3{i-2,1} = patient_list(i).name;
                    ratio_table1{i-2,1} = patient_list(i).name;
                    ratio_table2{i-2,1} = patient_list(i).name;
                    ratio_table3{i-2,1} = patient_list(i).name;
                    for j = 1:4
                        if(j==2)
                            result_path = [hn_path char(section(j)) '/' tesla '/Result/LT'];
                        elseif(j==3)
                            result_path = [hn_path char(section(j)) '/' tesla '/Result/RT'];
                        else
                            result_path = [hn_path char(section(j)) '/' tesla '/Result/'];
                        end
                        path = [result_path '/matfile/ppinv.mat'];
                        load(path);
%                         t2s = 1/p(1);
                        p_orig = pinv(x_fitmatrix)*y_fitmatrix;
                        T2s_table0{i-2,j+1} = 1/p_orig(1);
                        T2s_table1{i-2,j+1} = 1/p(1,1);
                        T2s_table2{i-2,j+1} = 1/p(2,1);
                        T2s_table3{i-2,j+1} = 1/p(3,1);
                        ratio_table1{i-2,j+1} = ratioI1;
                        ratio_table2{i-2,j+1} = ratioI2;
                        ratio_table3{i-2,j+1} = ratioI3;
                    end
                   
                    
                    
                end
    
