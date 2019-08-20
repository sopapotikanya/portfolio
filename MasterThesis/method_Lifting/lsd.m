function [lines] = lsd(name,DB_type)
% INPUT
% name = 'P1020171';
% DB_type = 'YorkUrbanDB';

if strcmp(DB_type,'YorkUrbanDB')
    inputDir = ['../Database/' DB_type '/' name '/' name '.jpg'];
elseif strcmp(DB_type,'HedauDB')
    inputDir = ['../Database/' DB_type '/Images/' name '.jpg'];
end
outputDir_txt = ['../Results/LineSegmentDetection/data/' DB_type '/' name '.txt'];
outputDir_tmp = ['../Results/LineSegmentDetection/data/' DB_type '/' name '.tmp'];
outputDir_pgm = ['../Results/LineSegmentDetection/data/' DB_type '/' name '.pgm'];
outputDir_mat = ['../Results/LineSegmentDetection/data/' DB_type '/' name '.mat'];
outputDir_png = ['../Results/LineSegmentDetection/image/' DB_type '/' name '.png'];
outputDir_jpg = ['../Results/LineSegmentDetection/image/' DB_type '/' name '.jpg'];

disp(['[lsd] ' name ' processing...']);
RGB = imread(inputDir);
GRAY = rgb2gray(RGB);
imwrite(GRAY,outputDir_pgm);

tic
% system(['./vpdetection-master/lsd-1.5/lsd ' outputDir_pgm ' ' outputDir_txt]);
system(['./vpdetection-master/lsd-1.5/lsd -s 0.3 -d 0.1 ' outputDir_pgm ' ' outputDir_txt]);
t = toc;
disp(['[lsd] ' num2str(t) ' seconds elapsed.']);

fileID = fopen(outputDir_txt,'r');
lines = [];


i=0;
RGB_lines = RGB;
WHITE_lines = ones(size(GRAY))*255;
while 1
    FileLine = fgetl(fileID); 
    if FileLine == -1
        break
    end
    val = (sscanf(FileLine, '%f %f %f %f %f'))';
    slope = (val(2)-val(4))/(val(1)-val(3));
    lines = cat(1,lines,[val slope]);
    i = i+1;
end
RGB_lines = insertShape(RGB_lines,'Line',lines(:,1:4),'LineWidth',5);
WHITE_lines = insertShape(WHITE_lines,'Line',lines(:,1:4),'LineWidth',3,'Color','black');
% imshow(RGB_lines);
% imshow(WHITE_lines);

save(outputDir_tmp,'lines','-ascii','-tabs');
save(outputDir_mat,'lines','t')
imwrite(RGB_lines,outputDir_jpg);
imwrite(WHITE_lines,outputDir_png);
