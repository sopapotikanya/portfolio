%%load roi

%from1.5 and 3
close all
clear all


main15path_core = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/ROI/1.5T/';
main3path_core = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/ROI/3T/';

save3path_core = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/ROI/3T/';

dcm15path_core = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/DICOM/1.5T/';
dcm3path_core = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/DICOM/3T/';

% main15path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/ROI/CMRtools/';
% dcm15path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/DICOM/1CMRtools/';


load('despath.mat')
for j=1:size(despath,1)
% subpath = '2014-10-01/';
subpath = [despath{j} '/'];

main15path =[main15path_core subpath];
main3path =[main3path_core subpath];

save3path =[save3path_core subpath];

dcm15path =[dcm15path_core subpath 'each_series/7/'];
dcm3path =[dcm3path_core subpath 'each_series/701/'];

cd(dcm15path);
!rm .DS_Store
!rm ._.DS_Store
dcm15_dir = dir;
info = dicominfo(dcm15_dir(3).name);
dcm15 = dicomread(info);

cd(dcm3path);
!rm .DS_Store
!rm ._.DS_Store
dcm3_dir = dir;
info = dicominfo(dcm3_dir(3).name);
dcm3 = dicomread(info);


for i=1:15
    main15path_ind = [main15path num2str(i)];
    main3path_ind = [main3path num2str(i)];
    dcm15path_ind = [dcm15path num2str(i)];
    dcm3path_ind = [dcm3path num2str(i)];
    save3path_ind =[save3path num2str(i)];
    cd(main15path_ind);    
    load('roi_user1.mat');
    roi15_1 = roi;
    load('roi_user2.mat');
    roi15_2 = roi;
    load('roi_user3.mat');
    roi15_3 = roi;

    cd(main3path_ind);
    load('roi.mat');
    roi3 = roi;
    
    roi = transfer15to3(dcm15,dcm3,roi15_1,roi3);
%      save(fullfile(save3path_ind,'/roi_user1.mat'),'roi');
    roi = transfer15to3(dcm15,dcm3,roi15_2,roi3);
     save(fullfile(save3path_ind,'/roi_user2.mat'),'roi');
    roi = transfer15to3(dcm15,dcm3,roi15_3,roi3);
%      save(fullfile(save3path_ind,'/roi_user3.mat'),'roi');
  
    i
end
end
