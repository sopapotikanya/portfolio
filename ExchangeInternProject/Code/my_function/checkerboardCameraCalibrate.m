function [cameraParams, rotationMatrix, translationVector, ...
    worldOrientation,worldLocation,chessPoints ...
    ] = checkerboardCameraCalibrate(path,squareSize,figureShow)
%% Prepare Calibration Images
numImages = 9;
imageFileNames = cell(1, numImages);
% path = '../Data/calibrate_image/';
for i = 1:numImages
    imageFileNames{i} = fullfile(path,'checkerboard_calibrate2', sprintf('calibrate000%d.bmp', i-1));
end
% figure; imshow(I, 'InitialMagnification', magnification);

if figureShow
    figure; montage(imageFileNames);
    title('Checkerboard Calibration Images');
end


%% Estimate Camera Parameters
% Detect the checkerboard corners in the images.
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);

% Generate the world coordinates of the checkerboard corners in the
% pattern-centric coordinate system, with the upper-left corner at (0,0).
% squareSize = 21; % in millimeters
worldPoints = generateCheckerboardPoints(boardSize, squareSize);
% worldPoints = generateCheckerboardPoints([10,7], squareSize);

% Calibrate the camera.
I = imread(imageFileNames{1});
imageSize = [size(I, 1), size(I, 2)];
cameraParams = estimateCameraParameters(imagePoints, worldPoints, ...
                                     'ImageSize', imageSize);
% Sx = norm(imagePoints(1,:,1) - imagePoints(2,:,1))/squareSize;
% Sy = norm(imagePoints(1,:,1) - imagePoints(7,:,1))/squareSize;
% cameraParams.FocalLength(1)/Sx


% Evaluate calibration accuracy.
if figureShow
    figure; showReprojectionErrors(cameraParams);
    title('Reprojection Errors');
end
% Visualize camera extrinsics.
if figureShow
    figure;
    showExtrinsics(cameraParams);
    drawnow;
end
% Plot detected and reprojected points.
calibrate_no = 1;
if figureShow
    figure; 
    imshow(imageFileNames{calibrate_no}); 
    hold on;
    plot(imagePoints(:,1,calibrate_no), imagePoints(:,2,calibrate_no),'go');
    plot(cameraParams.ReprojectedPoints(:,1,calibrate_no),cameraParams.ReprojectedPoints(:,2,calibrate_no),'r+');
    legend('Detected Points','ReprojectedPoints');
    hold off;
end
%%
[rotationMatrix, translationVector] = extrinsics(...
imagePoints(:,:,calibrate_no),worldPoints,cameraParams);

[worldOrientation,worldLocation] = estimateWorldCameraPose(...
    imagePoints(:,:,calibrate_no),[worldPoints,zeros(size(worldPoints,1),1)],cameraParams);

chessPoints = imagePoints(:,:,calibrate_no);
end
