function [lines, labels, img] = readLineOut(name,DB_type,LSD_type)
% load FilesName
% 
% name = FilesName(1).name;
% DB_type = FilesName(1).DB_type;
% 
inputDir_out = ['../Results/' LSD_type '/data/' DB_type '/' name '.out'];

if strcmp(DB_type,'YorkUrbanDB')
    inputDir_img = ['../Database/' DB_type '/' name '/' name '.jpg'];
elseif strcmp(DB_type,'HedauDB')
    inputDir_img = ['../Database/' DB_type '/Images/' name '.jpg'];
end

img = imread(inputDir_img);

out = load(inputDir_out);
lines = out(:,1:4);
labels = out(:,5)+1; % make label subscritps starts from 1

% imshow(img);
% hold on;
colors = fixedcolor;
nc = length(colors);
nl = size(lines,1);
% for i=1:nl
%     plot(lines(i,1:2:4),lines(i,2:2:4),'-','color',colors(mod(uint8(labels(i)-1),nc)+1,:), 'LineWidth', 2);
% end
% hold off
img_lines = img;
for i=1:nl
    c(i,:) = colors(mod(uint8(labels(i)-1),nc)+1,:)*255;
end
img_lines = insertShape(img_lines,'Line',lines(:,1:4),'LineWidth',3,'Color',c);
imshow(img_lines);