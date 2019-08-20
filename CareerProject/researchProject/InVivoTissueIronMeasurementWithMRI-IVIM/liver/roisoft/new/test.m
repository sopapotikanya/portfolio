% %% Transfer ROI
% clear
% clc
% close all
% addpath '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/roisoft'
% cd '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Adult/Thalassemic'
% path = pwd;
% delete '.DS_Store'
% delete '._.DS_Store'
% 
% d_name = dir;
% 
% for i =137:size(d_name,1)
%     cd(d_name(i).name)
%     pwd
%      batch_liver_ROI_RGBDCM('HEART','1.5T')
%      batch_liver_ROI_RGBDCM('LIVER','1.5T')
%      batch_liver_ROI_RGBDCM('PANCREAS','1.5T')
%     cd(path)
% end

% for i =[3:12,14:(size(d_name,1)-1)]
%     cd(d_name(i).name)
%     pwd
%      batch_liver_ROI_RGBDCM('HEART','3T')
%      batch_liver_ROI_RGBDCM('LIVER','3T')
%      batch_liver_ROI_RGBDCM('PANCREAS','3T')
%     cd(path)
% end

% cd '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Child/Thalassemic'
% path = pwd;
% delete '.DS_Store'
% delete '._.DS_Store'
% 
% d_name = dir;
% 
% for i =3:size(d_name,1)
%     cd(d_name(i).name)
%     pwd
%      batch_liver_ROI_RGBDCM('HEART','1.5T')
%      batch_liver_ROI_RGBDCM('LIVER','1.5T')
%      batch_liver_ROI_RGBDCM('PANCREAS','1.5T')
%     cd(path)
% end


%% %%%%%%%%%%%% phantom
% 
% cd '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms'
% path = pwd;
% 
% delete '.DS_Store'
% delete '._.DS_Store'
% 
% d_name = dir;
% 
% 
% 
% for i =3:(size(d_name,1)-2)
% % for i =18:19?
%     cd(d_name(i).name)
%     cd 1.5T
%         batch_Phantom_ROI
%     cd(path);
% %     cd(d_name(i).name)
% %     cd 3T
% %         batch_Phantom_ROI
% %     cd(path);
% end


% %%%%show img for check
clear all
close all
cd '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Adult/Thalassemic'
path = pwd;
d_name = dir;

% f
% or i =[3:12,14:(size(d_name,1)-1)]
figure;
for i= 42:(size(d_name,1))
    cd(d_name(i).name)
    load('15_results_data.mat');
    cd 'HEART/1.5T/ROI'
    pwd
    dir_dcm = dir('dicom*');
    dir_orig = dir('orig*');
    orig = imread(dir_orig(1).name);
    crop_img=imcrop(orig,[181 440 860 420]);
    dcm = imread(dir_dcm(1).name);
%     figure('Name',d_name(i).name),
    
    subplot(2,1,1,'replace'),imshow(crop_img);
    title(d_name(i).name)
    subplot(2,1,2,'replace'),imshow(dcm);
    disp(['t2* Heart = ' num2str(t2_h)]);
    disp(['r2 Heart = ' num2str(r2_h)]);
    
%     pause;
    cd(path)
%     close all
    
    cd(d_name(i).name)
    cd 'LIVER/1.5T/ROI'
    pwd
    dir_dcm = dir('dicom*');
    dir_orig = dir('orig*');
    orig = imread(dir_orig(1).name);
    crop_img=imcrop(orig,[181 440 860 420]);
    dcm = imread(dir_dcm(1).name);
%     figure('Name',d_name(i).name),
    subplot(2,1,1,'replace'),imshow(crop_img);
    title(d_name(i).name)
    subplot(2,1,2,'replace'),imshow(dcm);
    disp(['t2* LiverL = ' num2str(t2_ll)]);
    disp(['r2 LiverL = ' num2str(r2_ll)]);
%     pause;
    cd(path)
%     close all
    
    cd(d_name(i).name)
    cd 'LIVER/1.5T/ROI'
    pwd
    dir_dcm = dir('dicom*');
    dir_orig = dir('orig*');
    orig = imread(dir_orig(2).name);
    crop_img=imcrop(orig,[181 440 860 420]);
    dcm = imread(dir_dcm(2).name);
%     figure('Name',d_name(i).name),
    subplot(2,1,1,'replace'),imshow(crop_img);
    title(d_name(i).name)
    subplot(2,1,2,'replace'),imshow(dcm);
    disp(['t2* LiverR = ' num2str(t2_lr)]);
    disp(['r2 LiverR = ' num2str(r2_lr)]);
%     pause;
    cd(path)
%     close all
    
    cd(d_name(i).name)
    cd 'PANCREASE/1.5T/ROI'
    pwd
    dir_dcm = dir('dicom*');
    dir_orig = dir('orig*');
    orig = imread(dir_orig(1).name);
    crop_img=imcrop(orig,[181 440 860 420]);
    dcm = imread(dir_dcm(1).name);
%     figure('Name',d_name(i).name),
    subplot(2,1,1,'replace'),imshow(crop_img);
    title(d_name(i).name)
    subplot(2,1,2,'replace'),imshow(dcm);
    disp(['t2* Pancrease = ' num2str(t2_p)]);
    disp(['r2 Pancrease = ' num2str(r2_p)]);
%     pause;
    cd(path)
%     close all
    
end

%% show label image
% clear
% cd '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms'
% pathP = pwd;
% 
% delete '.DS_Store'
% delete '._.DS_Store'
% 
% d_name = dir;
% label_old = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]; 
% label_new(1,:) = zeros(1,15);
% label_new(2,:) = zeros(1,15);
% label_new(3,:) = [9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 15, 11, 12, 13, 14]; 
% label_new(4,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11]; 
% label_new(5,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11]; 
% label_new(6,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11];  
% label_new(7,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11]; 
% label_new(8,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11]; 
% label_new(9,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11]; 
% label_new(10,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11]; 
% label_new(11,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11]; 
% label_new(12,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11];   
% label_new(13,:) = [4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 12, 13, 14, 15, 11];  
% label_new(14,:) = [5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 13, 14, 15, 11, 12]; 
% label_new(15,:) = [8, 7, 6, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0];
% label_new(16,:) = [2, 1, 8, 7, 6, 5, 4, 3, 0, 0, 0, 0, 0, 0, 0];
% label_new(17,:) = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]; 
% label_new(18,:) = [9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 15, 11, 12, 13, 14]; 
% label_new(19,:) = [6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 14, 15, 11, 12, 13]; 
% % for i =[3:14,17:19]
% for i=19
%     phantoms_name = d_name(i).name
%     mkdir(['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/' phantoms_name '/1.5T/ROI_sort_new'])
%     for j=1:15
%         if label_old(1,j)<10
%             old = ['0' num2str(label_old(1,j))];
%             
%         else
%             old = num2str(label_old(1,j));
%         end
%         if label_new(i,j)<10
%             new = ['0' num2str(label_new(i,j))]
%             
%         else
%             new = num2str(label_new(i,j))
%         end
%         
%         sort_phantom(old,new,phantoms_name);
%         cd(pathP);
%     end
% end

% for i =[15,16]
%     phantoms_name = d_name(i).name;
%     mkdir(['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/' phantoms_name '/1.5T/ROI_sort_new'])
%     for j=1:8
%         if label_old(1,j)<10
%             old = ['0' num2str(label_old(1,j))];
%             
%         else
%             old = num2str(label_old(1,j));
%         end
%         if label_old(1,j)<10
%             new = ['0' num2str(label_new(i,j))]
%             
%         else
%             new = num2str(label_new(i,j))
%         end
%         
%         sort_phantom(old,new,phantoms_name);
%         cd(pathP);
%     end
% end


%% extract font from pic phantom
% clear
% clc
% close all
% addpath '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/roisoft'
% cd '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms'
% path = pwd;
% delete '.DS_Store'
% delete '._.DS_Store'
% 
% d_name = dir('20*');
% 
% for i =1:size(d_name,1)
%     close all
%     phantoms_name = d_name(i).name;
% % phantoms_name = '2015-2-4';
%     tesla = '15T';
%     FileReportName = ['report_cmrtool_' phantoms_name '_' tesla '.xlsx'];
%     if i==13 || i==14
%         n_hole = 8;
%     else
%         n_hole = 15;
%     end
%     [numbers] = read_r2star_CMR(phantoms_name,n_hole)
%     a = numbers(:,1);
%     b = numbers(:,2);
%     c = numbers(:,3);
%     r = numbers(:,4);
%     cd(['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/' phantoms_name '/1.5T/'])
%    
%     saveExcel(a, b, c, r, phantoms_name, FileReportName, tesla, n_hole)
% end
% 
% %% extract font from pic patient
% cd '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Child/Normal'
% path = pwd;
% d_name = dir;
% 
% for i =[3:12,14:(size(d_name,1)-1)]
%     cd(d_name(i).name)
%     cd 'HEART/1.5T/CMRtools'
%     pwd
%     dir_dcm = dir('dicom*');
%     dir_orig = dir('orig*');
%     orig = imread(dir_orig(1).name);
%     dcm = imread(dir_dcm(1).name);
%     figure('Name',d_name(i).name),
%     subplot(1,2,1),imshow(orig);
%     subplot(1,2,2),imshow(dcm);
%     cd(path)
% %     close all
%     
%     cd(d_name(i).name)
%     cd 'LIVER/3T/ROI'
%     pwd
%     dir_dcm = dir('dicom*');
%     dir_orig = dir('orig*');
%     orig = imread(dir_orig(1).name);
%     dcm = imread(dir_dcm(1).name);
% %     figure('Name',d_name(i).name),
%     subplot(1,2,1,'replace'),imshow(orig);
%     subplot(1,2,2,'replace'),imshow(dcm);
%     cd(path)
% %     close all
%     
%     cd(d_name(i).name)
%     cd 'LIVER/3T/ROI'
%     pwd
%     dir_dcm = dir('dicom*');
%     dir_orig = dir('orig*');
%     orig = imread(dir_orig(2).name);
%     dcm = imread(dir_dcm(2).name);
% %     figure('Name',d_name(i).name),
%     subplot(1,2,1,'replace'),imshow(orig);
%     subplot(1,2,2,'replace'),imshow(dcm);
%     cd(path)
% %     close all
%     
%     cd(d_name(i).name)
%     cd 'PANCREASE/3T/ROI'
%     pwd
%     dir_dcm = dir('dicom*');
%     dir_orig = dir('orig*');
%     orig = imread(dir_orig(1).name);
%     dcm = imread(dir_dcm(1).name);
% %     figure('Name',d_name(i).name),
%     subplot(1,2,1,'replace'),imshow(orig);
%     subplot(1,2,2,'replace'),imshow(dcm);
%     cd(path)
%     close all
%     
% end
