close all
clear
path = '../Data/calibrate_image/';
img_path = [path 'mirror_triangle/mirror_triangle0001.bmp'];
%% camera calibration
figureShow = false;
squareSize = 21; % in millimeters
[cameraParams, rotationMatrix, translationVector, ...
    worldOrientation,worldLocation,chessPoints] = checkerboardCameraCalibrate(path,squareSize,figureShow);

img_test = imread(img_path);
[im_undistort, newOrigin] = undistortImage(img_test, cameraParams, 'OutputView', 'full');

%% get points
figure; imshow(im_undistort);
title('Undistorted Image');
% [x,y] = getpts;
hold on
x = [628;616;628;620;512;512;508;510;630;614;750;722;746;726];
y = [596;276;554;362;574;320;618;236;638;196;616;234;574;316];
p0_prime = [x(1),y(1)];
q0 = [x(2),y(2)];
p1_prime = [x(3),y(3);x(9),y(9)];
q1 = [x(4),y(4);x(10),y(10)];
p2_prime = [x(5),y(5);x(11),y(11)];
q2 = [x(6),y(6);x(12),y(12)];
p3_prime = [x(7),y(7);x(13),y(13)];
q3 = [x(8),y(8);x(14),y(14)];

p_prime = [p0_prime;p1_prime;p2_prime;p3_prime];
q = [q0;q1;q2;q3];

plot(p0_prime(1),p0_prime(2),'*b')
plot(q0(1),q0(2),'*r')
plot(p1_prime(:,1),p1_prime(:,2),'-ob','LineWidth',2)
plot(p2_prime(:,1),p2_prime(:,2),'--ob','LineWidth',2)
plot(p3_prime(:,1),p3_prime(:,2),'-.ob','LineWidth',2)
plot(q1(:,1),q1(:,2),'-or','LineWidth',2)
plot(q2(:,1),q2(:,2),'--or','LineWidth',2)
plot(q3(:,1),q3(:,2),'-.or','LineWidth',2)

%% pointsToWorld (center on check board)
points = [x,y];
WorldPoints = pointsToWorld(cameraParams,rotationMatrix, translationVector,points);
WorldPoints = [WorldPoints,zeros(size(WorldPoints,1),1)];

chessWorldPoints = pointsToWorld(cameraParams,rotationMatrix, translationVector,chessPoints);
chessWorldPoints = [chessWorldPoints,zeros(size(chessWorldPoints,1),1)];

% [m, n,ch] = size(img_test);
[m, n,ch] = size(im_undistort);
edges = [1,1; n,1; n,m; 1,m];
edgesPoints = pointsToWorld(cameraParams,rotationMatrix, translationVector,edges);
edgesPoints = [edgesPoints,zeros(size(edgesPoints,1),1)];

p = pointsToWorld(cameraParams,rotationMatrix, translationVector,p_prime);
p = [p,zeros(size(p,1),1)];
% p0 = pointsToWorld(cameraParams,rotationMatrix, translationVector,p0_prime);
% p0 = [p0,zeros(size(p0,1),1)];
% p1 = pointsToWorld(cameraParams,rotationMatrix, translationVector,p1_prime);
% p1 = [p1,zeros(size(p1,1),1)];
% p2 = pointsToWorld(cameraParams,rotationMatrix, translationVector,p2_prime);
% p2 = [p2,zeros(size(p2,1),1)];
% p3 = pointsToWorld(cameraParams,rotationMatrix, translationVector,p3_prime);
% p3 = [p3,zeros(size(p3,1),1)];
%% show 3D (center on check board)
figure; hold on
plotCamera('Location',worldLocation,'Orientation',worldOrientation,'Size',20);
pcshow(chessWorldPoints, 'VerticalAxisDir','down','MarkerSize',20);
pcshow(WorldPoints, 'VerticalAxisDir','down','MarkerSize',80);
pcshow(edgesPoints, 'VerticalAxisDir','down','MarkerSize',80);
grid on
hold off

%% convert to center in camera
% translationVector
% worldLocation
% rotationMatrix
% worldOrientation;
T = worldLocation;
R = inv(worldOrientation);
new_camLocation = (worldLocation - T)/worldOrientation;
new_camOrientation = worldOrientation/worldOrientation;
new_WorldPoints = (WorldPoints - T)/worldOrientation;
new_edgesPoints = (edgesPoints - T)/worldOrientation;
new_chessWorldPoints = (chessWorldPoints - T)/worldOrientation;
new_p = (p - T)/worldOrientation;
% new_p0 = (p0 - T)/worldOrientation;
% new_p1 = (p1 - T)/worldOrientation;
% new_p2 = (p2 - T)/worldOrientation;
% new_p3 = (p3 - T)/worldOrientation;

%% image plane from EDGE
imagePlane_depth = 160; % mm
edges_vect = zeros(4,3);
for i=1:4
    edges_vect(i,:) = new_edgesPoints(i,:)./norm(new_edgesPoints(i,:));
end
ImagePlane_edge = imagePlane_depth*edges_vect./edges_vect(:,3);

movingPoints = edges;
fixedPoints = ImagePlane_edge(:,1:2);
transformationType = 'projective';
tform = fitgeotrans(movingPoints,fixedPoints,transformationType);
% Jregistered = imwarp(im_undistort,tform);
% figure
% imshow(Jregistered)
% image3D = [edges,ones(4,1)] * tform.T;
% image3D = image3D./image3D(:,3)
q3D = [q,ones(size(q,1),1)] * tform.T;
q3D = q3D./q3D(:,3);
q3D(:,3) = imagePlane_depth;


%% image plane from camera cal
focalLenght = 16; % mm
unitCellSize = 5.6e-03; % mm
sizeImagePlaneX = m*unitCellSize;
sizeImagePlaneY = n*unitCellSize;

PrincipalPointX = cameraParams.PrincipalPoint(1,1);
PrincipalPointy = cameraParams.PrincipalPoint(1,2);
ImagePlane_CamCal = [-PrincipalPointX,m-PrincipalPointy; ...
    n-PrincipalPointX,m-PrincipalPointy; ...
    n-PrincipalPointX,-PrincipalPointy; ...
    -PrincipalPointX,-PrincipalPointy; ...
    ];

ImagePlane_CamCal = [ImagePlane_CamCal*unitCellSize,focalLenght*ones(4,1)];
ImagePlane_CamCal2 = ImagePlane_CamCal.*(imagePlane_depth/focalLenght);

%% show 3D (center in camera)
figure; hold on
plotCamera('Location',new_camLocation,'Orientation',new_camOrientation,'Size',20);
pcshow(new_chessWorldPoints, 'VerticalAxisDir','down', 'VerticalAxis','Y','MarkerSize',50);
% scatter3(new_chessWorldPoints(:,1),new_chessWorldPoints(:,2),new_chessWorldPoints(:,3),'filled');

% pcshow(new_WorldPoints, 'VerticalAxisDir','down', 'VerticalAxis','Y','MarkerSize',80);
% scatter3(new_WorldPoints(:,1),new_WorldPoints(:,2),new_WorldPoints(:,3),'filled');

% pcshow(new_edgesPoints, 'VerticalAxis','Y','MarkerSize',80);
scatter3(new_edgesPoints(:,1),new_edgesPoints(:,2),new_edgesPoints(:,3),'filled');

scatter3(new_p(1,1),new_p(1,2),new_p(1,3),'filled','MarkerFaceColor','b');
% plot3(new_p(1,1),new_p(1,2),new_p(1,3),'ob')
plot3(new_p(2:3,1),new_p(2:3,2),new_p(2:3,3),'-ob','MarkerSize',3,'MarkerFaceColor','b')
plot3(new_p(4:5,1),new_p(4:5,2),new_p(4:5,3),'--ob','MarkerSize',3,'MarkerFaceColor','b')
plot3(new_p(6:7,1),new_p(6:7,2),new_p(6:7,3),'-.ob','MarkerSize',3,'MarkerFaceColor','b')


fill3(ImagePlane_CamCal(:,1), ImagePlane_CamCal(:,2),ImagePlane_CamCal(:,3),1);
fill3(ImagePlane_CamCal2(:,1), ImagePlane_CamCal2(:,2),ImagePlane_CamCal2(:,3),1);

for i=1:4
    plot3([0;new_edgesPoints(i,1)],[0;new_edgesPoints(i,2)],[0;new_edgesPoints(i,3)])
end
fill3(ImagePlane_edge(:,1), ImagePlane_edge(:,2),ImagePlane_edge(:,3),[1 1 0]);

scatter3(q3D(:,1),q3D(:,2),q3D(:,3),'filled','MarkerFaceColor','b');

grid on
axis equal


%% estimate mirror plane
Xi = q3D(1,:)';
Xp = new_p(1,:)';
OQ_vect = q3D(1,:)./norm(q3D(1,:));
S = 200:50:600;
Oc = [0,0,0];
new_p(1,:);
for i=1:size(S,2)
    Xm_test(i,:) = OQ_vect*S(i);
    d_test(i) = norm(Xm_test(i,:) - new_p(1,:)) + norm(new_p(1,:) - Oc);
    plot3(Xm_test(i,1),Xm_test(i,2),Xm_test(i,3),'*k');
    text(Xm_test(i,1),Xm_test(i,2),Xm_test(i,3),['\leftarrow ' num2str(d_test(i),'%.f')]);
end

% ObjectiveFunction = @simple_objective;
ObjectiveFunction = @(s) simple_objective(s,Oc,new_p(1,:),OQ_vect); % define constant values
s0 = 200;   % Starting point
[Sm,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,s0);
Xm = OQ_vect*Sm;
plot3(Xm(1,1),Xm(1,2),Xm(1,3),'*r');
text(Xm(1,1),Xm(1,2),Xm(1,3),['\leftarrow ' num2str(fval,'%.f')]);

Np = cross(Xp,Xi);
Nm = cross(OQ_vect' - (Xm' - Xp)/norm(Xm' - Xp),Np);
Nm = Nm/norm(Nm);

plot3([Xm(1,1);Xm(1,1)+Nm(1,1)*100],[Xm(1,2);Xm(1,2)+Nm(2,1)*100],[Xm(1,3);Xm(1,3)+Nm(3,1)*100],'>-r');
% plot_mirror(Xm,Nm)

point = Xm;
normal = Nm';

%# a plane is a*x+b*y+c*z+d=0
%# [a,b,c] is the normal. Thus, we have to calculate
%# d and we're set
d = -point*normal'; %'# dot product for less typing

%# create x,y
[xx,yy]=ndgrid(-100:100,Xm(2)-50:Xm(2)+50);

%# calculate corresponding z
z = (-normal(1)*xx - normal(2)*yy - d)/normal(3);

%# plot the surface
surf(xx,yy,z,'FaceAlpha',0.5,'EdgeColor','none')

%% change to sx==sy 
% ratio = cameraParams.FocalLength(1)/cameraParams.FocalLength(2);
% new_WorldPoints2 = new_WorldPoints;
% new_WorldPoints2(:,2) =  new_WorldPoints2(:,2)./ratio;
% new_edgesPoints2 = new_edgesPoints;
% new_edgesPoints2(:,2) =  new_edgesPoints2(:,2)./ratio;
% new_chessWorldPoints2 = new_chessWorldPoints;
% new_chessWorldPoints2(:,2) =  new_chessWorldPoints2(:,2)./ratio;
% 
% figure; hold on, 
% plotCamera('Location',new_camLocation,'Orientation',new_camOrientation,'Size',20);
% pcshow(new_chessWorldPoints2, 'VerticalAxisDir','down', 'VerticalAxis','Y','MarkerSize',50);
% % scatter3(new_chessWorldPoints2(:,1),new_chessWorldPoints2(:,2),new_chessWorldPoints2(:,3),'filled');
% % pcshow(new_WorldPoints2, 'VerticalAxisDir','down', 'VerticalAxis','Y','MarkerSize',80);
% scatter3(new_WorldPoints2(:,1),new_WorldPoints2(:,2),new_WorldPoints2(:,3),'filled');
% % pcshow(new_edgesPoints2, 'VerticalAxis','Y','MarkerSize',80);
% scatter3(new_edgesPoints2(:,1),new_edgesPoints2(:,2),new_edgesPoints2(:,3),'filled');
% 
% 
% fill3(ImagePlane_CamCal2(:,1), ImagePlane_CamCal2(:,2),ImagePlane_CamCal2(:,3),1);
% for i=1:4
%     plot3([0;new_edgesPoints2(i,1)],[0;new_edgesPoints2(i,2)],[0;new_edgesPoints2(i,3)])
% end
% grid on
% axis equal

%%
% p0 = new_p(1,:);
% p1_line = [new_p(2,:); new_p(1,:); new_p(3,:)];
% p2_line = [new_p(4,:); new_p(1,:); new_p(5,:)];
% p3_line = [new_p(6,:); new_p(1,:); new_p(7,:)];
% 
% p1_vect = p1_line(1,:) - p1_line(3,:);
% p2_vect = p2_line(1,:) - p2_line(3,:);
% p3_vect = p3_line(1,:) - p3_line(3,:);
% delta_p1 = p1_vect/norm(p1_vect);
% delta_p2 = p2_vect/norm(p2_vect);
% delta_p3 = p3_vect/norm(p3_vect);
% 
% Bv1 = -delta_p1(2)/norm(p0);
% Bv2 = -delta_p2(2)/norm(p0);
% Bv3 = -delta_p3(2)/norm(p0);
% 
% 
% %
% sp_p1 = csapi(p1_line(:,1),p1_line(:,2));
% sp_p2 = csapi(p2_line(:,1),p2_line(:,2));
% sp_p3 = csapi(p3_line(:,1),p3_line(:,2));
% Bsp_p1=fn2fm(sp_p1,'B-');
% Bsp_p2=fn2fm(sp_p2,'B-');
% Bsp_p3=fn2fm(sp_p3,'B-');
% 
% 
% p1_prim_line = [p_prime(2,:); p_prime(1,:); p_prime(3,:)];
% p2_prim_line = [p_prime(4,:); p_prime(1,:); p_prime(5,:)];
% p3_prim_line = [p_prime(6,:); p_prime(1,:); p_prime(7,:)];
% sp_p1_prim = csapi(p1_prim_line(:,1),p1_prim_line(:,2));
% sp_p2_prim = csapi(p2_prim_line(:,1),p2_prim_line(:,2));
% sp_p3_prim = csapi(p3_prim_line(:,1),p3_prim_line(:,2));
% Bsp_p1=fn2fm(sp_p1_prim,'B-');
% Bsp_p2=fn2fm(sp_p2_prim,'B-');
% Bsp_p3=fn2fm(sp_p3_prim,'B-');
% 
% 
% 
% q1_line = [q(2,:); q(1,:); q(3,:)];
% q2_line = [q(4,:); q(1,:); q(5,:)];
% q3_line = [q(6,:); q(1,:); q(7,:)];
% sp_q1 = csapi(q1_line(:,1),q1_line(:,2));
% sp_q2 = csapi(q2_line(:,1),q2_line(:,2));
% sp_q3 = csapi(q3_line(:,1),q3_line(:,2));
% Bsp_q1=fn2fm(sp_q1,'B-');
% Bsp_q2=fn2fm(sp_q2,'B-');
% Bsp_q3=fn2fm(sp_q3,'B-');
% Bsp_diff_q1 = fnder(Bsp_q1);
% Bsp_diff_q2 = fnder(Bsp_q2);
% Bsp_diff_q3 = fnder(Bsp_q3);
% slope1 = fnval(Bsp_diff_q1,q(1,:));
% slope2 = fnval(Bsp_diff_q2,q(1,:));
% slope3 = fnval(Bsp_diff_q3,q(1,:));
% 
% syms Bu1 Bu2 Bu3
% H = [Bv1, -Bu1*slope1 Bu1-Bv1*slope1; ...
%     Bv2, -Bu2*slope2 Bu2-Bv2*slope2; ...
%     Bv3, -Bu3*slope3 Bu3-Bv3*slope3; ...
%     ];
% sol_Bu = solve(det(H'*H),[Bu1 Bu2 Bu3]);


%%
function d = simple_objective(S,Oc,p,OQ_vect)
% Oc = [0,0,0];
% p = [-2.88651868775208,-130.169947279441,407.815544439178];
% OQ_vect = [-0.00860491923348333,-0.461779937770008,0.886952785912595];
Xm = OQ_vect*S;
d = norm(Xm - p) + norm(p - Oc);
end

function plot_mirror(point,normalVector)
v = normalVector;
x1 = point(1);
y1 = point(2);
z1 = point(3);
   w = null(v); % Find two orthonormal vectors which are orthogonal to v
   [P,Q] = meshgrid(-50:50); % Provide a gridwork (you choose the size)
   X = x1+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
   Y = y1+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
   Z = z1+w(3,1)*P+w(3,2)*Q;
   surf(X,Y,Z,'FaceAlpha',0.5,'EdgeColor','none')
end



