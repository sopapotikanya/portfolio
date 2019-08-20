close all
clear
path_input = '../Data/calibrate_image/';
typeCheckerboard = 'triangle';
cornerShape = 6;
% typeCheckerboard = 'chess';
% cornerShape = 4;
img_path = [path_input 'mirror_' typeCheckerboard '/mirror_' ...
    typeCheckerboard '000' num2str(1) '.bmp'];
%% camera calibration
figureShow = true;
squareSize = 21; % in millimeters
[cameraParams, rotationMatrix, translationVector, ...
    worldOrientation,worldLocation,chessPoints] = checkerboardCameraCalibrate(path_input,squareSize,figureShow);

I = imread(img_path);
[I_undistort, newOrigin] = undistortImage(I, cameraParams, 'OutputView', 'full');

%% get point on image
th = 0.8;
box = [15,19];
box = [15,15];
[mark, BW, edgeImg, score, scoreDilate] = detectTriangleboardPoints(I_undistort,box,cornerShape,th);
mark(2,:) = [];
mark(end+1,:) = [756,704];
pair_mark = matchMarkPointMirrorAndObj(mark,I_undistort);

%% pointsToWorld (center on check board)
ImgPoints_obj = pair_mark(:,3:4);
WorldPoints_obj = pointsToWorld(cameraParams,rotationMatrix, translationVector,ImgPoints_obj);
WorldPoints_obj = [WorldPoints_obj,zeros(size(WorldPoints_obj,1),1)];

[m, n, ch] = size(I_undistort);
ImEdges = [1,1; n,1; n,m; 1,m];
WorldPoints_edges = pointsToWorld(cameraParams,rotationMatrix, translationVector,ImEdges);
WorldPoints_edges = [WorldPoints_edges,zeros(size(WorldPoints_edges,1),1)];
%% show 3D (center on check board)
figure; hold on
plotCamera('Location',worldLocation,'Orientation',worldOrientation,'Size',20);
pcshow(WorldPoints_obj, 'VerticalAxisDir','down','MarkerSize',100);
pcshow(WorldPoints_edges, 'VerticalAxisDir','down','MarkerSize',80);
grid on
hold off
%% convert to center in camera
T = worldLocation;
R = inv(worldOrientation);
camLocation = (worldLocation - T)/worldOrientation;
camOrientation = worldOrientation/worldOrientation;
objPoints = (WorldPoints_obj - T)/worldOrientation;
edgesPoints = (WorldPoints_edges - T)/worldOrientation;

%% image plane from EDGE
imagePlane_depth = 160; % mm
edgesVect = zeros(4,3);
for i=1:4
    edgesVect(i,:) = edgesPoints(i,:)./norm(edgesPoints(i,:));
end
ImagePlaneEdge = imagePlane_depth*edgesVect./edgesVect(:,3);

movingPoints = ImEdges;
fixedPoints = ImagePlaneEdge(:,1:2);
transformationType = 'projective';
tform = fitgeotrans(movingPoints,fixedPoints,transformationType);

mirrorImPoints = [pair_mark(:,1:2),ones(size(pair_mark,1),1)] * tform.T;
mirrorImPoints = mirrorImPoints./mirrorImPoints(:,3);
mirrorImPoints(:,3) = imagePlane_depth;
%%
Oc = [0;0;0];
mirrorDistances = [];
mirrorPoints = [];
mirrorNormalVectors = [];
for i=1:size(mirrorImPoints,1)
    Q = mirrorImPoints(i,:)';
    P = objPoints(i,:)';
    OcQ_vect = Q./norm(Q);
    ObjectiveFunction = @(s) mirrorDistance_objective(s,Oc,P,OcQ_vect); % define constant values
    s0 = 200;   % Starting point
    [S,fval,exitFlag,output] = simulannealbnd(ObjectiveFunction,s0);
    M = OcQ_vect*S;
    Np = cross(P,Q);
    Nm = cross(OcQ_vect - (M - P)/norm(M - P),Np);
    Nm = Nm/norm(Nm);

    mirrorDistances = cat(1,mirrorDistances,S);
    mirrorPoints = cat(1,mirrorPoints,M');
    mirrorNormalVectors = cat(1,mirrorNormalVectors,Nm');
end
%% show 3D (center in camera)
figure; hold on
plotCamera('Location',camLocation,'Orientation',camOrientation,'Size',20);
pcshow(objPoints, 'VerticalAxisDir','down', 'VerticalAxis','Y','MarkerSize',50);

scatter3(edgesPoints(:,1),edgesPoints(:,2),edgesPoints(:,3),'filled');

for i=1:4
    plot3([0;edgesPoints(i,1)],[0;edgesPoints(i,2)],[0;edgesPoints(i,3)])
end
fill3(ImagePlaneEdge(:,1), ImagePlaneEdge(:,2),ImagePlaneEdge(:,3),[1 1 0],'FaceAlpha',0.5,'EdgeColor','none');


scatter3(mirrorImPoints(:,1),mirrorImPoints(:,2),mirrorImPoints(:,3), ...
    'filled','MarkerFaceColor','b');
scatter3(mirrorPoints(:,1),mirrorPoints(:,2),mirrorPoints(:,3),'filled');
grid on
axis equal



