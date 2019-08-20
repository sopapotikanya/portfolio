addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));
% save_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/Result/sol5/';
% machine_name = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/DICOM/1.5T/2014-09-30/each_series/7';
% roi_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/ROI/1.5T/2014-09-30/1/';

load despath.mat
list_people = {'kaew', 'user1'; 'dun', 'user2'; 'noo', 'user3'};
list_people2 = {'kaew', '08user1'; 'dun', '08user2'; 'noo', '08user3'};
%% Phantom 1.5T sol8

main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/';

for u=1:3 % forloop people 1=kaew 2=dun 3=noo
    user_roi = list_people(u,:);
    user = list_people2(u,:);
    for d=1:15
        date_name = despath{d}
        result_path = [main_path 'Result/1.5T/' date_name];
        machine_name =  [main_path 'DICOM/1.5T/' date_name '/each_series/7'];
        cd(result_path)
            mkdir(user{2});
            cd(user{2});
            roiname = ['roi_' user_roi{2} '.mat'];
                for position = 1:15
                    roi_path =  [main_path 'ROI/1.5T/' date_name '/' num2str(position)];
                    T2s_sol8(machine_name,roi_path,position,roiname,'1.5T');
                end
    end
end
%% Phantom 3T sol8

% for u=1:3 % forloop people 1=kaew 2=dun 3=noo
%     user_roi = list_people(u,:);
%     user = list_people2(u,:);
%     for d=1:15
%         date_name = despath{d}
%         result_path = [main_path 'Result/3T/' date_name];
%         machine_name =  [main_path 'DICOM/3T/' date_name '/each_series/701'];
%         cd(result_path)
%             mkdir(user{2});
%             cd(user{2});
%             roiname = ['roi_' user_roi{2} '.mat'];
%                 for position = 1:15
%                     roi_path =  [main_path 'ROI/3T/' date_name '/' num2str(position)];
%                     T2s_sol8(machine_name,roi_path,position,roiname,'3T');
%                 end
%     end
% end

%% Patient

% main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/';
% tesla = '1.5T';
% % target_path = [main_path 'Adult/Thalassemic/'];
% % batch_T2s_patients(tesla,target_path)
% 
% target_path = [main_path 'Child/Normal/'];
% batch_T2s_patients(tesla,target_path)
% 
% target_path = [main_path 'Child/Thalassemic/'];
% batch_T2s_patients(tesla,target_path)