% LSD_type = 'LineSegmentDetection_normal';
LSD_type = 'LineSegmentDetection_s03-d01';

DB_type = 'YorkUrbanDB';
listfile = dir(['../Database/' DB_type ]);
j=0;
for i = 3:size(listfile,1)
    if listfile(i).isdir
        filename = listfile(i).name;
        if ~strncmp(filename, '.', 1)
            j=j+1;
            FilesName(j).name = filename;
            FilesName(j).type = '.jpg';
            FilesName(j).DB_type = DB_type;
            disp(['[VPdetection] ' DB_type ' ' filename ' ...' num2str(i) '/' num2str(size(listfile,1))])
            VPdetection(filename,DB_type,LSD_type)
        end
    end
end

DB_type = 'HedauDB';
listfile = dir(['../Database/' DB_type '/Images']);
for i = 3:size(listfile,1)
    filename = listfile(i).name;
    if ~strncmp(filename, '.', 1) && ~strncmp(filename, 'Thumb.db', 1)
        j=j+1;
        FilesName(j).name = filename(1,1:end-4);
        FilesName(j).type = filename(1,end-3:end);
        FilesName(j).DB_type = DB_type;
        disp(['[VPdetection] ' DB_type ' ' filename ' ...' num2str(i) '/' num2str(size(listfile,1))])
        VPdetection(filename(1,1:end-4),DB_type,LSD_type)
    end
end
% %%
% LSD_type = 'LineSegmentDetection_s 0.3 -d 0.1';
% 
% DB_type = 'YorkUrbanDB';
% listfile = dir(['../Database/' DB_type ]);
% for i = 3:size(listfile,1)
%     if listfile(i).isdir
%         filename = listfile(i).name;
%         if ~strncmp(filename, '.', 1)
%             disp(['[VPdetection] ' DB_type ' ' filename ' ...' num2str(i) '/' num2str(size(listfile,1))])
%             VPdetection(filename,DB_type,LSD_type)
%         end
%     end
% end
% 
% DB_type = 'HedauDB';
% listfile = dir(['../Database/' DB_type '/Images']);
% for i = 3:size(listfile,1)
%     filename = listfile(i).name;
%     if ~strncmp(filename, '.', 1) && ~strncmp(filename, 'Thumb.db', 1)
%         disp(['[VPdetection] ' DB_type ' ' filename ' ...' num2str(i) '/' num2str(size(listfile,1))])
%         VPdetection(filename(1,1:end-4),DB_type,LSD_type)
%     end
% end






