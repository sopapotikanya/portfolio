function [roi2] = detectColor(img)
% detect green color from result of CMRtools
% result of CMRtools is rgb.dcm type file
%
%
normal_img = img;
roi = zeros(size(normal_img,1),size(normal_img,2));
count = 0;
check=0;
check2=0;
for m=1:size(normal_img,1)
    for n=1:size(normal_img,2)
        if (normal_img(m,n,2)-normal_img(m,n,3) > 30)
            count = count +1;
%             if normal_img(m,n,1) <= 140 
            if (abs(normal_img(m,n,1)-normal_img(m,n,3)) <30) %in phantom
                if check==1
                    count =count +1 ;
                    roi(m,n,:)=1;
                    check2=1;  %% have a seen green color
                end
            else
                if (abs(normal_img(m,n,1)-normal_img(m,n,3)) >30) %in phantom
                    if check2==1
                        check=0;
                    else
                        check=1; %% pass yellow
                    end
                end   %in phantom
            end
            
        else
            check=0;
            check2=0;
        end
    end
end


%figure ,imshow(j);

se = strel('diamond',1);
roi2= roi;
roi2=imerode(roi2,se);
roi2=imdilate(roi2,se);
se2 = strel('diamond',2);
roi2=imdilate(roi2,se2);
roi2=imerode(roi2,se2);

roi2=im2bw(roi2);