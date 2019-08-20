clear

% [angleD, dis] = point2polar(point,vp,varargin)
% lines_cartesian = line2cartesian(Lines,vp);

no_ray = 10;
sizeImg = [480,640];
m = sizeImg(1);
n = sizeImg(2);

img = zeros(m,n);
vp_honz = [10000,m/2];
vp_vert = [n/2,-10000];
vp_center = [m/2,n/2];

[angleH(1), disH(1)] = point2polar([0 0],vp_honz);
[angleH(2), disH(2)] = point2polar([n 0],vp_honz);
[angleH(3), disH(3)] = point2polar([0 m],vp_honz);
[angleH(4), disH(4)] = point2polar([n m],vp_honz);

[angleV(1), disV(1)] = point2polar([0 0],vp_vert);
[angleV(2), disV(2)] = point2polar([n 0],vp_vert);
[angleV(3), disV(3)] = point2polar([0 m],vp_vert);
[angleV(4), disV(4)] = point2polar([n m],vp_vert);

pointH(1,:) = polar2point(angleH(1),disH(1),vp_honz);
pointH(2,:) = polar2point(angleH(2),disH(2),vp_honz);
pointH(3,:) = polar2point(angleH(3),disH(3),vp_honz);
pointH(4,:) = polar2point(angleH(4),disH(4),vp_honz);

pointV(1,:) = polar2point(angleV(1),disV(1),vp_vert);
pointV(2,:) = polar2point(angleV(2),disV(2),vp_vert);
pointV(3,:) = polar2point(angleV(3),disV(3),vp_vert);
pointV(4,:) = polar2point(angleV(4),disV(4),vp_vert);

pointH
pointV

edgeH(1) = min(angleH);
edgeH(2) = max(angleH);
edgeV(1) = min(angleV);
edgeV(2) = max(angleV);
edgeH(3) = (edgeH(2) - edgeH(1))/(no_ray+1);
edgeV(3) = (edgeV(2) - edgeV(1))/(no_ray+1);

disH = sort(disH);
disV = sort(disV);

setH = [edgeH(1):edgeH(3):edgeH(2)]';
setV = [edgeV(1):edgeV(3):edgeV(2)]';

imshow(img);
hold on

for i=1:size(setH,1)
    pointH(i,1:2) = polar2point(setH(i),disH(1),vp_honz);
    pointH(i,3:4) = polar2point(setH(i),disH(end),vp_honz);
    plot(pointH(i,1:2:4),pointH(i,2:2:4),'-')
end

for i=1:size(setV,1)
    pointV(i,1:2) = polar2point(setV(i),disV(1),vp_vert);
    pointV(i,3:4) = polar2point(setV(i),disV(end),vp_vert);
    plot(pointV(i,1:2:4),pointV(i,2:2:4),'-')
end