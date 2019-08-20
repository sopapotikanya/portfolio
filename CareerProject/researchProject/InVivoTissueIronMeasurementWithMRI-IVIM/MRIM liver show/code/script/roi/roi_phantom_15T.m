addpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code/')
path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/';
cd(path);

load('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code/script/despath.mat', 'despath');
list_people = {'kaew', 'user1'; 'dun', 'user2'; 'noo', 'user3'};


for u=2 % forloop people 1=kaew 2=dun 3=noo
    user = list_people(u,:);
    for d=2:15 % forloop week
        date = despath{d,1}
        for p=1:15 %position forloop
            close all
            path_roi = [path 'ROI/1.5T/' date '/' num2str(p) '/'];
            path_roi2 = [path 'Result/CMRtools/' date '/matfile/' num2str(p) '/'];
            path_roi3 = [path 'ROI/CMRtools/' date '/' num2str(p) '/'];
            path_cmr = [path 'Result/CMRtools/' date '/DICOM/' num2str(p) '/'];
            path_dcm = [path 'DICOM/1.5T/' date '/each_series/7/'];
            CMRtool_name =  [path_cmr 'roi_user' num2str(u) '.rgb.dcm'];
            dcm_name  =  dir(path_dcm);
            DICOM_name = [path_dcm dcm_name(3).name];
            [roi, orig_img_fig, dicom_img_fig, crop_img, roi_img] = transfer_roi(CMRtool_name,DICOM_name);
            save([path_roi 'roi_user' num2str(u) '.mat'],'roi');
            save([path_roi2 'roi_user' num2str(u) '.mat'],'roi');
            save([path_roi3 'roi_user' num2str(u) '.mat'],'roi_img','crop_img');
            
            if p<10
                saveas(orig_img_fig,[path 'Result/CMRtools/' date '/screenshot/CMRtools_user' num2str(u) '_0' num2str(p) '.jpg']) ;
                saveas(dicom_img_fig,[path 'Result/CMRtools/' date '/screenshot/CMRtools_ROI_user' num2str(u) '_0' num2str(p) '.jpg']) ;
            else
                saveas(orig_img_fig,[path 'Result/CMRtools/' date '/screenshot/CMRtools_user' num2str(u) '_' num2str(p) '.jpg']) ;
                saveas(dicom_img_fig,[path 'Result/CMRtools/' date '/screenshot/CMRtools_ROI_user' num2str(u) '_' num2str(p) '.jpg']) ;
            end
        end
    end
    
end
