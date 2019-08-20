clear
close all
load FilesName
% n = 131;
n = 180;
fileName = FilesName(n).name;
DB_type = FilesName(n).DB_type;
LSD_type = 'LineSegmentDetection_normal';
% LSD_type = 'LineSegmentDetection_s03-d01';
% inputDir_out = ['../Results/LineSegmentDetection_normal/data/' DB_type '/' fileName '.out'];
% 
% if strcmp(DB_type,'YorkUrbanDB')
%     inputDir_img = ['../Database/' DB_type '/' fileName '/' fileName '.jpg'];
% elseif strcmp(DB_type,'HedauDB')
%     inputDir_img = ['../Database/' DB_type '/Images/' fileName '.jpg'];
% end




[lines, vp_association, img] = readLineOut(fileName,DB_type,LSD_type);
[VP, LINES] = getMainVP([lines,vp_association]);
% LINES = (x1,y1,x2,y2,group,A,B,C,Vx,Vy,origin vector,sort orig =>x1,y1,x2,y2,width)
JunctionDetection_Lift(fileName,DB_type,VP, LINES,img)
% JunctionDetection_Group(fileName,DB_type,VP, LINES,img)

% LiftingLine(DB_type,fileName,img,LINES,lines_out(:,5),vp_make);
% Grouping(DB_type,fileName,img,LINES,lines_out(:,5),vp_make);



