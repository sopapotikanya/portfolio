close all
load FLIR1512.mat
% FLIR1512 = panvasa3;
FLIR1512 = FLIR1512;
I = FLIR1512./(max(max(FLIR1512)));

Imax=max(max(I));
Imin=min(min(I));
range = Imax-Imin;

mmin=ones(size(I))*Imin;
Inew = I-mmin;

Inew2=Inew/range;
%% select roi

BW = roipoly(Inew2);

%%
pos = [];

run = 1; 

for i=1:size(BW,1)
    for j=1:size(BW,2)

        if BW(i,j)==1

            pos(run,1) = i;
            pos(run,2) = j;

            run=run+1;
        end

    end

end

Iroi = Inew2;

run=1;
for i=1:size(BW,1)
    for j=1:size(BW,2)

        if i==pos(run,1) && j==pos(run,2) 
            
            
            
            run=run+1;
            
            if(run>size(pos,1))
                  run=1;
            end
        else
            
            Iroi(i,j)=0;
        end

    end

end

m = mean(mean(Iroi));
sd = std(std(Iroi));
n = size(pos,1);


%%

figure ,imshow(Iroi)
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
