clear
close all


DB_type = 'HedauDB';
imdir=['../../Database/' DB_type '/Images/'];
load(['../../Database/' DB_type '/Allvpdata.mat']);
load(['../../Database/' DB_type '/imsegs.mat']);

Gap_dis = 15;
Gap_polar = 0.9;

d_img=dir([imdir '*.jpg']);

imgnum = 3;

% for imgnum = 1:size(d_img,1)


imagename=d_img(imgnum).name;
fileName = imagename(1,1:end-4);
disp(['[' num2str(imgnum) '/' num2str(size(d_img,1)) '] ' imagename])
img = imread([imdir imagename]);

lines = Allvpdata(imgnum).lines;
linemem = Allvpdata(imgnum).linemem;
VP = Allvpdata(imgnum).vp;

vp_honz = VP(2,:);
vp_vert = VP(1,:);
vp_center = VP(3,:);

figure, imshow(img);
hold on
for i=1:size(lines,1)
    color = [0 0 0];
    color(linemem(i,1)) = 1;
    plot(lines(i,1:2),lines(i,3:4),'-','LineWidth',3,'Color',color);
end
hold off

% format line
Lines = [lines(:,1),lines(:,3),lines(:,2),lines(:,4)];

tic
new_linesH = estimateLine(Lines(linemem == 2,:),vp_honz,img,Gap_dis,Gap_polar);
new_linesV = estimateLine(Lines(linemem == 1,:),vp_vert,img,Gap_dis,Gap_polar);
new_linesZ = estimateLine(Lines(linemem == 3,:),vp_center,img,Gap_dis,Gap_polar);
toc

figure, imshow(img);
hold on
for i=1:size(new_linesH,1)
    plot(new_linesH(i,1:2:4),new_linesH(i,2:2:4),'-','LineWidth',3,'Color','green');
end
for i=1:size(new_linesV,1)
    plot(new_linesV(i,1:2:4),new_linesV(i,2:2:4),'-','LineWidth',3,'Color','red');
end
for i=1:size(new_linesZ,1)
    plot(new_linesZ(i,1:2:4),new_linesZ(i,2:2:4),'-','LineWidth',3,'Color','blue');
end
hold off

