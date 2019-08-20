function numbers = read_font_CMR(CMRtools_DCM)

orig_img = dicomread(CMRtools_DCM);
w = 540-410;
h = 14;

green(1,1,:) = [0,200,0];
red(1,1,:) = [200,0,0];

%% read variable a 
crop_img_a=imcrop(orig_img,[410 656 w h]);
BW_a = extract_font(crop_img_a,green);
num_a = detectnumber(BW_a);

%% read variable b 
crop_img_b=imcrop(orig_img,[410 674 w h]);
BW_b = extract_font(crop_img_b,green);
num_b = detectnumber(BW_b);

%% read variable c 
crop_img_c=imcrop(orig_img,[410 692 w h]);
BW_c = extract_font(crop_img_c,green);
num_c = detectnumber(BW_c);

%% read variable r 
crop_img_r=imcrop(orig_img,[410 710 w h]);
BW_r = extract_font(crop_img_r,green);
num_r = detectnumber(BW_r);

%% read variable t2* 
% w = 760-710;
% h = 14;
% crop_img_t2s=imcrop(orig_img,[710 416 w h]);
% BW_t2s = extract_font(crop_img_t2s,red);
% num_t2s = detectnumber(BW_t2s);


%% 
numbers(1) = str2double(num_a);
numbers(2) = str2double(num_b);
numbers(3) = str2double(num_c);
numbers(4) = str2double(num_r);
% numbers(5) = str2double(num_t2s);




