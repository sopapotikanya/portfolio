%---------------------------------------------------
% procetive_geometry.m
% Kurt Niel, Gernot Stuebl, AT
% using /MatlabFns/Projective
%   as part of the huge matlab library for machine vision
%   by Peter Kovesi, AU
% Nov 2017
%
% projective geometry by homography matrix
% modify parameters of the homography matrix
%   for getting a feeling of their impact to the translation
%---------------------------------------------------

% preamble
close all;
clear all;
clc;
addpath(genpath('Images'));
addpath(genpath('MatlabFns/Projective'));

% selecting input image by uncomment
%inimg = imread('chessboard.png');
% inimg = imread('kepleruhrS.JPG');
inimg = imread('duden.JPG');

% standard affine translation
scalex = 1; % scale factor
scaley = 1; % scale factor
shearx = 0;
sheary = 0;
angle = 0/180*pi; % rotation angle
tx =    0; % x translation
ty =    0; % y translation
bregion = [51 150 51 150];

% affine translation - rotation x scale x shear x translation
h11 = cos(angle)*scalex-sin(angle)*scaley*sheary;
h12 = -cos(angle)*scalex*shearx-sin(angle)*scaley;
h13 = cos(angle)*tx-sin(angle)*ty;
h21 = sin(angle)*scalex+cos(angle)*scaley*sheary;
h22 = sin(angle)*scalex*shearx+cos(angle)*scaley;
%h22 = scaley;
h23 = cos(angle)*ty+sin(angle)*tx;
h31 = 0;
h32 = 0;
h33 = 1;
Hsa = [h11 h12 h13;
       h21 h22 h23;
       h31 h32 h33;];
 
% general projective homography by empiric approach
Hsp = [ 1.0000  0.0001  0.0000;
        0.0001  1.0000  0.0000;
        0.0000  0.0000  1;];
% projective homography kepleruhr.JPG
Hspk = [ 3.0000 -0.2500  0.0000;
         1.0500  1.0000  0.0000;
         0.0045 -0.0005  1;];
% projective homography duden.JPG
Hspd = [ 0.0400  0.8800  0.0000;
        -0.4500  0.0800  0.0000;
        -0.0010 -0.0005  1;];

% calculating homography H by corresponding points x1, x2
% H = homography(x1, x2)
%       x1: 3xN set of homogeneous points
%       x2: 3xN set of homogeneous points such that x1<->x2
%       H:  the 3x3 homography such that x2 = H*x1
%
% x1: for checking the operation: here x1 = x2
% x1 = [ 20 450 450  20;
%        20  20 320 320;
%         1   1   1   1;];
% x1: actual points within the image/camera plane
x1 = [261 269  86  52;
      72 193 258 103;
       1   1   1   1;];
% x2: desired points for the output plane
x2 = [ 20 450 450  20;
       20  20 320 320;
        1   1   1   1;];
Hsc = homography2d(x1, x2);

% selecting operation by uncomment
% outimg = imTrans(inimg,Hsa);
% outimg = imTrans(inimg,Hsp);
% outimg = imTrans(inimg,Hspk);
% outimg = imTrans(inimg,Hspd);
outimg = imTrans(inimg,Hsc);
% outimg = imTrans(inimg,Hsp,bregion);

% display the result
subplot(2,1,1);
imshow(inimg);
subplot(2,1,2);
imshow(outimg,[0 255]);
