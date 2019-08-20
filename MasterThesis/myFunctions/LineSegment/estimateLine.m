function new_lines = estimateLine(Lines,vp,img,Gap_dis,Gap_polar)

addpath('/Users/sopapotikanya/Documents/MATLAB/floorplan2/Code/calDistance')
% lines_polar = [];
lines_cartesian = line2cartesian(Lines,vp);
% lines_cartesian = [];
% for i=1:size(Lines,1)
%     point1 = Lines(i,1:2);
%     [angleD1, dis1] = point2polar(point1,vp);
%     
%     point2 = Lines(i,3:4);
%     [angleD2, dis2] = point2polar(point2,vp);
%     
%     mean_angleD = (angleD1 + angleD2)/2;
%     
%     if dis1 < dis2
%         lines_cartesian = cat(1,lines_cartesian,[point1,point2,angleD1, dis1,angleD2, dis2,mean_angleD]);
% %         lines_polar = cat(1,lines_polar,[angleD1, dis1,angleD2, dis2,mean_angleD]);
%     else
%         lines_cartesian = cat(1,lines_cartesian,[point2,point1,angleD2, dis2,angleD1, dis1,mean_angleD]);
% %         lines_polar = cat(1,lines_polar,[angleD2, dis2,angleD1, dis1,mean_angleD]);
%     end
%     
% end

lines_sort = sortrows(lines_cartesian,9);

g_polar=1;
g_line=1;
start_g_polar = 1;
angleD_ref = lines_sort(1,9);
lines_sort(1,10:11) = 1;


vect = vp - [size(img,1)/2,size(img,2)/2];
dis = hypot(vect(1),vect(2));
Gap_polar = Gap_polar*1000/dis;

for i=2:size(lines_sort,1)
    angleD = lines_sort(i,9);
    if abs(angleD - angleD_ref) >= Gap_polar
        start_g_polar = i;
        g_polar=g_polar+1;
        angleD_ref = angleD;
    end
    lines_sort(i,10) = g_polar;
    
    L1P1 = [lines_sort(i,1:2),1];
    L1P2 = [lines_sort(i,3:4),1];
    min_distLine = [];
    for j=start_g_polar:i-1
        L2P1 = [lines_sort(j,1:2),1];
        L2P2 = [lines_sort(j,3:4),1];
        distLine = shortDistBetweenLines(L1P1,L1P2,L2P1,L2P2);
        min_distLine = cat(1,min_distLine,[min(distLine(1:8)),lines_sort(j,11)]);
    end
    
    if isempty(min_distLine)
        g_line = g_line + 1;
        lines_sort(i,11) = g_line;
    else
        [Min_value, idx] = min(min_distLine(:,1));
        if Min_value < Gap_dis
            lines_sort(i,11) = min_distLine(idx,2);
        else
            g_line = g_line + 1;
            lines_sort(i,11) = g_line;
        end
    end
end

lines_sort = sortrows(lines_sort,11);
new_lines = [];
for i=1:g_line
    
    lines = [lines_sort(lines_sort(:,11) == i,[1,2,5,6]);lines_sort(lines_sort(:,11) == i,[3,4,7,8])];
    [~, idx_start] = min(lines(:,4));
    [~, idx_end] = max(lines(:,4));
    
    angleD_avg = mean(lines(:,3));
    dis_start = lines(idx_start,4);
    dis_end = lines(idx_end,4);
    point_start = polar2point(angleD_avg,dis_start,vp);
    point_end = polar2point(angleD_avg,dis_end,vp);
    lineABC = cross([point_start,1],[point_end,1]);
    width = abs(dis_end - dis_start);
    new_lines = cat(1,new_lines,[point_start,point_end,dis_start,dis_end,angleD_avg,lineABC,width]);
end






