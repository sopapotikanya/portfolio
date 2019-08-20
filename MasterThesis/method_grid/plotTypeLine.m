function fig_lines_new = plotTypeLine(linesH,linesV,linesZ,img)

fig_lines_new = figure;
imshow(img);
hold on
for i=1:size(linesH,1)
    plot(linesH(i,1:2:4),linesH(i,2:2:4),'-','LineWidth',2,'Color','green');
end
for i=1:size(linesV,1)
    plot(linesV(i,1:2:4),linesV(i,2:2:4),'-','LineWidth',2,'Color','red');
end
for i=1:size(linesZ,1)
    plot(linesZ(i,1:2:4),linesZ(i,2:2:4),'-','LineWidth',2,'Color','blue');
end
hold off