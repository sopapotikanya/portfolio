function [indices, setH, setV, disH, disV] = mapLayout(gtPolyg,VP,no_ray,sizeImg,fields)

addpath('/Users/sopapotikanya/Documents/MATLAB/floorplan2/Code/LineSegment')
% DB_type = 'HedauDB';
% imdir=['../../Database/' DB_type '/Images/'];
% labeldir=['../../Database/' DB_type '/label/'];
% load(['../../Database/' DB_type '/Allvpdata.mat']);
% load(['../../Database/' DB_type '/imsegs.mat']);
% load('/Users/sopapotikanya/Documents/MATLAB/floorplan2/Database/sample/imgTypeAll.mat')

SetY = [];
C = nchoosek(1:no_ray+2,2);
for i=1:size(C,1)
    for j=1:size(C,1)
        SetY = cat(1,SetY,[C(i,:),C(j,:)]);
    end
end
vp_honz = VP(2,:);
vp_vert = VP(1,:);
vp_center = VP(3,:);

% imgnum = 36;
% 
% imagename = imgTypeAll(imgnum).imname;
% fileName = imagename(1,1:end-4);
% lines = Allvpdata(imgnum).lines;
% linemem = Allvpdata(imgnum).linemem;
% 
% VP = Allvpdata(imgnum).vp;
    
% load([labeldir fileName '_labels.mat']); % fields, gtPolyg, labels


celling = (fields == 2);
imshow(celling,'DisplayRange',[])
hold on

BW = edge(celling,'canny');
[H,T,R] = hough(BW);
P  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));
gtLines = houghlines(BW,T,R,P);
figure, imshow(BW), hold on

gtLines_bak = gtLines;
if length(gtLines) > 4
   while length(gtLines) >4
        temp = ones(length(gtLines),length(gtLines)).*999;
       for k=1:length(gtLines)
           for l=1:k-1
               a = [gtLines(k).theta,gtLines(k).rho];
               b = [gtLines(l).theta,gtLines(l).rho];
               temp(k,l) = norm(a - b);
           end
       end
       MIN = min(temp(:));
       [m,n] = find(temp == MIN);

       duplicatePoints = [gtLines(m).point1;gtLines(m).point2;gtLines(n).point1;gtLines(n).point2];
       [MAX1, idmax1] = max([norm(duplicatePoints(1,:) - duplicatePoints(1,:)), ...
           norm(duplicatePoints(1,:) - duplicatePoints(2,:)), ...
           norm(duplicatePoints(1,:) - duplicatePoints(3,:)), ...
           norm(duplicatePoints(1,:) - duplicatePoints(4,:))]);
       [MAX2, idmax2] = max([norm(duplicatePoints(idmax1,:) - duplicatePoints(1,:)), ...
           norm(duplicatePoints(idmax1,:) - duplicatePoints(2,:)), ...
           norm(duplicatePoints(idmax1,:) - duplicatePoints(3,:)), ...
           norm(duplicatePoints(idmax1,:) - duplicatePoints(4,:))]);
       if MAX1 > MAX2
           idmax2 = 1;
       end
       newLine_point1 = duplicatePoints(idmax1,:);
       newLine_point2 = duplicatePoints(idmax2,:);
       newLine_theta = mean(gtLines(m).theta,gtLines(n).theta);
       newLine_rho =  mean(gtLines(m).rho,gtLines(n).rho);

       gtLines([m,n]) = [];
       structrow = length(gtLines) + 1;
       gtLines(structrow).point1 = newLine_point1;
       gtLines(structrow).point2 = newLine_point2;
       gtLines(structrow).theta = newLine_theta;
       gtLines(structrow).rho = newLine_rho;
   end
end
H_line = [];
V_line = [];
for k=1:length(gtLines)
    if abs(gtLines(k).theta)>45 %horizontal
        H_line = cat(1,H_line,[gtLines(k).point1, gtLines(k).point2, gtLines(k).theta, gtLines(k).rho]);
    else % verticle
        V_line = cat(1,V_line,[gtLines(k).point1, gtLines(k).point2, gtLines(k).theta, gtLines(k).rho]);
    end
end
H_line = sortrows(H_line,6);
V_line = sortrows(V_line,6);
linesH_cartesian = line2cartesian(H_line(:,1:4),vp_honz);
linesV_cartesian = line2cartesian(V_line(:,1:4),vp_vert);
% celling_edge = gtPolyg{2};
% % convert start point
% dis12 = celling_edge(1,:) - celling_edge(2,:);
% if abs(dis12(1)) > abs(dis12(2)) % start horizontal
%     if dis12(2) < 0 % right direction
%         H_line1 = [celling_edge(1,:),celling_edge(2,:)];
%         V_line1 = [celling_edge(2,:),celling_edge(3,:)];
%         H_line2 = [celling_edge(3,:),celling_edge(4,:)];
%         V_line2 = [celling_edge(4,:),celling_edge(5,:)];
%     else % left direction
%         H_line2 = [celling_edge(1,:),celling_edge(2,:)];
%         V_line1 = [celling_edge(2,:),celling_edge(3,:)];
%         H_line1 = [celling_edge(3,:),celling_edge(4,:)];
%         V_line2 = [celling_edge(4,:),celling_edge(5,:)];
%     end
% else % start vertical
%     if dis12(2) < 0 % down direction
%         V_line2 = [celling_edge(1,:),celling_edge(2,:)];
%         H_line2 = [celling_edge(2,:),celling_edge(3,:)];
%         V_line1 = [celling_edge(3,:),celling_edge(4,:)];
%         H_line1 = [celling_edge(4,:),celling_edge(5,:)];
%     else % up direction
%         V_line1 = [celling_edge(1,:),celling_edge(2,:)];
%         H_line1 = [celling_edge(2,:),celling_edge(3,:)];
%         V_line2 = [celling_edge(3,:),celling_edge(4,:)];
%         H_line2 = [celling_edge(4,:),celling_edge(5,:)];
%     end
% end



                
% if vp_honz(1,1) < vp_center(1,1) % vp at left side
%     linesH_cartesian = line2cartesian([H_line1;H_line2],vp_honz);
% else % vp at right side
%     linesH_cartesian = line2cartesian([H_line2;H_line1],vp_honz);
% end
% 
% if vp_vert(1,2) > vp_center(1,2) % vp at bottom side
%     linesV_cartesian = line2cartesian([V_line2;V_line1],vp_vert);
% else % vp at up side
%     linesV_cartesian = line2cartesian([V_line1;V_line2],vp_vert);
% end
layout = [linesH_cartesian(:,end)',linesV_cartesian(:,end)'];
% [m n] = size(fields);
m = sizeImg(1);
n = sizeImg(2);
[angleH(1), disH(1)] = point2polar([0 0],vp_honz);
[angleH(2), disH(3)] = point2polar([n 0],vp_honz);
[angleH(3), disH(2)] = point2polar([0 m],vp_honz);
[angleH(4), disH(4)] = point2polar([n m],vp_honz);

[angleV(1), disV(1)] = point2polar([0 0],vp_vert);
[angleV(2), disV(3)] = point2polar([n 0],vp_vert);
[angleV(3), disV(2)] = point2polar([0 m],vp_vert);
[angleV(4), disV(4)] = point2polar([n m],vp_vert);

edgeH(1) = min(angleH);
edgeH(2) = max(angleH);
edgeV(1) = min(angleV);
edgeV(2) = max(angleV);
edgeH(3) = (edgeH(2) - edgeH(1))/(no_ray+1);
edgeV(3) = (edgeV(2) - edgeV(1))/(no_ray+1);

disH = sort(disH);
disV = sort(disV);

layout(2,1) = (layout(1,1) - edgeH(1))/edgeH(3);
layout(2,2) = (layout(1,2) - edgeH(1))/edgeH(3);
layout(2,3) = (layout(1,3) - edgeV(1))/edgeV(3);
layout(2,4) = (layout(1,4) - edgeV(1))/edgeV(3);

layout(3,:) = round(layout(2,:)) +1;
indices = find(ismember(SetY,layout(3,:),'rows')==1);

setH = [edgeH(1):edgeH(3):edgeH(2)]';
setV = [edgeV(1):edgeV(3):edgeV(2)]';
%% plot
% imshow(celling,'DisplayRange',[])
% hold on

for i=1:size(setH,1)
    pointH(i,1:2) = polar2point(setH(i),disH(1),vp_honz);
    pointH(i,3:4) = polar2point(setH(i),disH(end),vp_honz);
    plot(pointH(i,1:2:4),pointH(i,2:2:4),'-')
    if i == layout(3,1) || i == layout(3,2)
        plot(pointH(i,1:2:4),pointH(i,2:2:4),'c--','LineWidth',1.5)
    end
end

for i=1:size(setV,1)
    pointV(i,1:2) = polar2point(setV(i),disV(1),vp_vert);
    pointV(i,3:4) = polar2point(setV(i),disV(end),vp_vert);
    plot(pointV(i,1:2:4),pointV(i,2:2:4),'-')
    if i == layout(3,3) || i == layout(3,4)
        plot(pointV(i,1:2:4),pointV(i,2:2:4),'c--','LineWidth',1.5)
    end
end
testbug = 1;
