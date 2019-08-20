
load('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code/script/despath.mat', 'despath');

% 
% path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/';
% list_people = {'kaew', 'user1'; 'dun', 'user2'; 'noo', 'user3'};
% 
% for u=1:3 % forloop people 1=kaew 2=dun 3=noo
%     user = list_people(u,:);
%     for d=1:15 % forloop week
%         date = despath{d,1}
%             
%         for p=1:15
%             orig_path = [path 'PhantomCMRtoolsAddON/CMRtools_' user{1} '/' date '/' num2str(p) '/'];
%             
%             target_path = [path 'PhantomNEW/Result/CMRtools/' date '/DICOM/' num2str(p) '/'];
%             
%             copyfile([orig_path 'roi.dcm'],[path 'temp']);
%             movefile([path 'temp/roi.dcm'],[target_path 'roi_' user{2} '.dcm']);
%             copyfile([orig_path 'roi.rgb.dcm'],[path 'temp']);
%             movefile([path 'temp/roi.rgb.dcm'],[target_path 'roi_' user{2} '.rgb.dcm']);
%             copyfile([orig_path 'roi.tts'],[path 'temp']);
%             movefile([path 'temp/roi.tts'],[target_path 'roi_' user{2} '.tts']);
%             
%             copyfile([orig_path 'excel_roi.xlsx'],[path 'temp']);
%             if p < 10
%                 movefile([path 'temp/excel_roi.xlsx'],[path 'PhantomNEW/Result/CMRtools/' date '/excel/CMRtools_' user{2} '_0' num2str(p) '.xlsx']);
%             else
%                 movefile([path 'temp/excel_roi.xlsx'],[path 'PhantomNEW/Result/CMRtools/' date '/excel/CMRtools_' user{2} '_' num2str(p) '.xlsx']);
%             end
%             
%         end
%     end
% end

% make folder ROI
path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/ROI/CMRtools/';
    for d=1:15 % forloop week
        cd(path);
        date = despath{d,1};
        mkdir(date);
        for p=1:15
            mkdir([path '/' date],num2str(p));
        end
        
    end
    
%% makefolder
% path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Result/3T/';
% 
%     for d=1:15 % forloop week
%         cd(path);
%         date = despath{d,1};
%         mkdir(date);
% %         cd(date);
% %         current = pwd
% %         
% %         mkdir('DICOM');
% %         for p=1:15
% %             mkdir([current '/DICOM'],num2str(p));
% %         end
% %         
% %         mkdir('matfile');
% %         for p=1:15
% %             mkdir([current '/matfile'],num2str(p));
% %         end
% %         
% %         
% %         mkdir('excel');
% %         mkdir('screenshot');
% %         
%     end





