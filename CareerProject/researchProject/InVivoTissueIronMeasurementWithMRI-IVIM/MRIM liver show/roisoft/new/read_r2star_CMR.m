function [numbers] = read_r2star_CMR(phantoms_name,n_hole)

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
    w = 540-410;
    h = 14;
    green(1,1,:) = [0,200,0];
    
    crop_img_a=imcrop(orig_img,[410 656 w h]);
    BW_a = ones(h+1,w+1);
    text = 'a';
    for m=1:h+1
        for n=1:w+1
            if (crop_img_a(m,n,1) == crop_img_a(m,n,2)) && (crop_img_a(m,n,1) == crop_img_a(m,n,3))
                BW_a(m,n) = 0;
            end
            if crop_img_a(m,n,:) == green
                BW_a(m,n) = 0;
            end
        end
    end
%     subplot(4,2,1), imshow(crop_img_a);
%     subplot(4,2,2), imshow(BW_a);
%     savetemplate(BW_a,text,i)
    
    
    subplot(n_hole,4,i*4-3), imshow(BW_a);
    num_a = detectnumber(BW_a);
    
    crop_img_b=imcrop(orig_img,[410 674 w h]);
    BW_b = ones(h+1,w+1);
    text = 'b';
    for m=1:h+1
        for n=1:w+1
            if (crop_img_b(m,n,1) == crop_img_b(m,n,2)) && (crop_img_b(m,n,1) == crop_img_b(m,n,3))
                BW_b(m,n) = 0;
            end
            if crop_img_b(m,n,:) == green
                BW_b(m,n) = 0;
            end
        end
    end
%     subplot(4,2,3), imshow(crop_img_b);
%     subplot(4,2,4), imshow(BW_b);
%     savetemplate(BW_b,text,i)
    
    subplot(n_hole,4,i*4-2), imshow(BW_b); 
    num_b = detectnumber(BW_b);
    
    crop_img_c=imcrop(orig_img,[410 692 w h]);
    text='c';
    BW_c = ones(h+1,w+1);
    for m=1:h+1
        for n=1:w+1
            if (crop_img_c(m,n,1) == crop_img_c(m,n,2)) && (crop_img_c(m,n,1) == crop_img_c(m,n,3))
                BW_c(m,n) = 0;
            end
            if crop_img_c(m,n,:) == green
                BW_c(m,n) = 0;
            end
        end
    end
%     subplot(4,2,5), imshow(crop_img_c);
%     subplot(4,2,6), imshow(BW_c);
%     savetemplate(BW_c,text,i)
    
    subplot(n_hole,4,i*4-1), imshow(BW_c);
    num_c = detectnumber(BW_c);
        
    crop_img_r=imcrop(orig_img,[410 710 w h]);
    text='r';
    BW_r = ones(h+1,w+1);
    for m=1:h+1
        for n=1:w+1
            if (crop_img_r(m,n,1) == crop_img_r(m,n,2)) && (crop_img_r(m,n,1) == crop_img_r(m,n,3))
                BW_r(m,n) = 0;
            end
            
            if crop_img_r(m,n,:) == green
                BW_r(m,n) = 0;
            end
        end
    end
%     subplot(4,2,7), imshow(crop_img_r);
%     subplot(4,2,8), imshow(BW_r);
%     savetemplate(BW_r,text,i)
    
    subplot(n_hole,4,i*4), imshow(BW_r);
    num_r = detectnumber(BW_r);
    
    numberss{i,1} = num_a;
    numberss{i,2} = num_b;
    numberss{i,3} = num_c;
    numberss{i,4} = num_r;
    
    numbers(i,1) = str2num(num_a);
    numbers(i,2) = str2num(num_b);
    numbers(i,3) = str2num(num_c);
    numbers(i,4) = str2num(num_r);
end

