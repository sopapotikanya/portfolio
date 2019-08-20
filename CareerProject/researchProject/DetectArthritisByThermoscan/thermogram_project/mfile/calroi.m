function output = calroi(input,name)

%% get image and mormalize color range to (0 - 1)
FLIR1512 = input;
I = FLIR1512./(max(max(FLIR1512)));

Imax=max(max(I));
Imin=min(min(I));
range = Imax-Imin;

mmin=ones(size(I))*Imin;
Inew = I-mmin;

Inew2=Inew/range;

figure , imshow(Inew2);

%% select roi

BW = roipoly(Inew2);

%% match roi(BW) with NormalImg(Inew2)  

pos = []; % create matrix to save white position(roi) from BW

run = 1; % counter 

%run all pixel of image BW
for i=1:size(BW,1)
    for j=1:size(BW,2)

        if BW(i,j)==1  %if find white pixel , save coordinate to pos 

            pos(run,1) = i;
            pos(run,2) = j;

            run=run+1; 
        end

    end

end

Iroi = Inew2; %copy Inew2 to Iroi

run=1; % reset counter

%run all pixel of image Inew2
for i=1:size(Inew2,1)
    for j=1:size(Inew2,2)

        if i==pos(run,1) && j==pos(run,2) %if position matching , not happen
            
            run=run+1;
            
            if(run>size(pos,1))
                  run=1;
            end
        else %if position not matching change pixel to black
            
            Iroi(i,j)=0;
        end

    end

end

figure ,imshow(Iroi);
%% stat

m = mean(mean(Iroi));
sd = std(std(Iroi));
n = size(pos,1);

%%save
namestat = strcat(name,'_s');
nameimg = strcat(name,'_d');

save(namestat,'m','sd','n')
save(nameimg,'Iroi')
