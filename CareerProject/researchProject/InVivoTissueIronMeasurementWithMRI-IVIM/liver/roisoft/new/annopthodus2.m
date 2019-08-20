mainpath = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms';
cd(mainpath);
phantom_path = dir('20*');
% for j=1:size(phantom_path,1)
for j=[1:12,15:17]
    cd(phantom_path(j).name);
    phantom_path(j).name
    cd 1.5T/ROI_sort_new
    ROI_path = pwd;
    for i=1:15

        cd(num2str(i));
        cd sol3
        cd T2S
        load('ppinv.mat','p');
        t2 = 1/p(1);
        table{j,1}=phantom_path(j).name;
        table{j,i+1}=t2;

        cd(ROI_path);
    end
    cd(mainpath);
end

%% for phantom 3T

% mainpath = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms';
% cd(mainpath);
% phantom_path = dir('20*');
% figure;
% for j=[1:12,15:size(phantom_path,1)]
%     cd(phantom_path(j).name);
%     phantom_path(j).name
%     cd 3T/ROI
%     ROI_path = pwd;
%     for i=1:15
% 
%         cd(num2str(i));
% %         pic = imread('TRIMTESTAVG_ROI.tiff');
% %         chart = imread('TRIMTESTAVG_T.png');
% %         value = imcrop(chart,[700 90 400 200]);
% %         subplot(2,1,1)
% %         imshow(pic);
% %         title([phantom_path(j).name ':' num2str(i)])
% %         subplot(2,1,2)
% %         imshow(value);
%         cd sol3
%         cd T2S
%         load('ppinv.mat','p');
%         t2 = 1/p(1);
%         table{j,1}=phantom_path(j).name;
%         table{j,i+1}=t2;
% 
%         cd(ROI_path);
%     end
%     cd(mainpath);
% end