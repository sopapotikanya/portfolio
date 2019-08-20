function [numbers] = read_r2star_CMRED(phantoms_name,n_hole)

close all

% phantoms_name = '2015-2-4';
% phantoms_name = '2014-9-30';
path = ['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/' phantoms_name '/1.5T/ROI_sort_new/'];
cd(path)
h = figure('Name',phantoms_name),
for i=1:n_hole
    if i<10
        label = ['0' num2str(i)];
    else
        label = num2str(i);
    end
    
    orig_img = dicomread(['ROI_15T_' label '.rgb.dcm']);
%     w = 540-410;
    w = 760-710;
    h = 14;
    red(1,1,:) = [200,0,0];
    
    crop_img_a=imcrop(orig_img,[710 416 w h]);
    BW_a = ones(h+1,w+1);
    text = 'a';
    for m=1:h+1
        for n=1:w+1
            if (crop_img_a(m,n,1) == crop_img_a(m,n,2)) && (crop_img_a(m,n,1) == crop_img_a(m,n,3))
                BW_a(m,n) = 0;
            end
            if crop_img_a(m,n,:) == red
                BW_a(m,n) = 0;
            end
        end
    end
%     subplot(4,2,1), imshow(crop_img_a);
%     subplot(4,2,2), imshow(BW_a);
%     savetemplate(BW_a,text,i)
    
    
    subplot(n_hole,4,i*4-3), imshow(BW_a);
%     num_a = detectnumber(BW_a);
    savetemplate(BW_a,text,i);
   
    
%     numberss{i,1} = num_a;
%     numberss{i,2} = num_b;
%     numberss{i,3} = num_c;
%     numberss{i,4} = num_r;
%     
%     numbers(i,1) = str2num(num_a);
%     numbers(i,2) = str2num(num_b);
%     numbers(i,3) = str2num(num_c);
%     numbers(i,4) = str2num(num_r);
end

