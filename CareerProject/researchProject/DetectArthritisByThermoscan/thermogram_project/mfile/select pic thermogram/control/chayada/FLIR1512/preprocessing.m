close all
%load FLIR1512.mat
FLIR1512 = panvasa3;
I = FLIR1512./(max(max(FLIR1512)));

Imax=max(max(I));
Imin=min(min(I));
range = Imax-Imin;

mmin=ones(size(I))*Imin;
Inew = I-mmin;

Inew2=Inew/range;

% Apply the colormap
% figure 2, imshow(Inew2);
% cmap = jet(100);
% colormap(cmap);
% freezeColors

subplot(3,2,1); imshow(Inew2);
subplot(3,2,2); imhist(Inew2);


th = 0.3;
range = Imax-th;

TH=ones(size(I))*th;
Inew3 = Inew2-TH;

Inew4=Inew3/range;




subplot(3,2,3); imshow(Inew4);
subplot(3,2,4); imhist(Inew4);

% % Apply the colormap
% subplot(3,2,5:6); imshow(Inew4);
% cmap = jet(100);
% colormap(cmap);
% colorbar;
