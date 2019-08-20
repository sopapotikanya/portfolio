function [numbers] = read_r2star_CMR_patient(part)

close all

%%
orig_img = dicomread([part '.rgb.dcm']);
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
    
    
    subplot(2,2,1), imshow(BW_a);
    num_a = detectnumber(BW_a);
%%    
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
    
    subplot(2,2,2), imshow(BW_b); 
    num_b = detectnumber(BW_b);
%%
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
    
    subplot(2,2,3), imshow(BW_c);
    num_c = detectnumber(BW_c);
%%        
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
    
    subplot(2,2,4), imshow(BW_r);
    num_r = detectnumber(BW_r);
    
    numberss{1,1} = num_a;
    numberss{1,2} = num_b;
    numberss{1,3} = num_c;
    numberss{1,4} = num_r;
    
    numbers(1,1) = str2num(num_a);
    numbers(1,2) = str2num(num_b);
    numbers(1,3) = str2num(num_c);
    numbers(1,4) = str2num(num_r);

test=0;
    
    
  