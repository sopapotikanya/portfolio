close all
clear
addpath('/Users/sopapotikanya/Desktop/MRIM liver show/code');
machine_name = '/Users/sopapotikanya/Desktop/MRIM liver show/phantom/DICOM/each_series/7/';
tesla = 'T';
Tesla = '1.5T';
name = 'phantom'

[finfo,t_vector,z_vector,y_axis,x_axis,z_axis,t_axis] = dcmreadmultifile(machine_name,1);
mat5d = cremat5d;

% from Wit edit
neg_ind = find(mat5d <= 0);
dicom_min = 1/(2^10); % min of dicom image above 0
mat5d(neg_ind) = dicom_min;
nex = size(mat5d,5);
  

%% roi poly
bit_depth = 16;
image_matrix = mat5d(:,:,1,1,1);
image_matrix = int16(image_matrix);
    
% Rescale keeping 16 bit depth but 
rescaled_image = image_matrix*((2^bit_depth)/2/max(image_matrix(:)));
figure, subplot(1,2,1), imshow(rescaled_image);
roi = roipoly(rescaled_image);

roi = double(roi);
%%

mat5d_resize = roitrimmat5d(roi,mat5d);
% mat5d_resize = mat5d;
fitmatrix = createfitmatrix(t_vector,mat5d_resize);

% Linearize + Average
[clean_t_vector,clean_fitmatrix] = cleannan(t_vector, fitmatrix);
n_repeat = 2;
repeat_thres = 6;
te_cut_index_min = 'none';

% [trim_fitmatrix,trim_t_vector] = trimtail(clean_t_vector,clean_fitmatrix,n_repeat,repeat_thres);
[trim_fitmatrix,trim_t_vector] = trimtail_edit1(clean_t_vector,clean_fitmatrix,n_repeat,repeat_thres,te_cut_index_min);
[l_fitmatrix,min_residue] = linearize(trim_fitmatrix);
%[d_l_fitmatrix,mean_matrix] = demean(l_fitmatrix);
[a_l_fitmatrix,nvoxels] = average(l_fitmatrix);
% If show averaged
a_show_fitmatrix = average(clean_fitmatrix);


%find max min of graph


[p,r_square,RSS,y_fitmatrix,x_fitmatrix] = pinvfit_edit3(trim_t_vector, a_l_fitmatrix, a_show_fitmatrix,Tesla);


printtiff('T2S/roi.tiff', roi, mat5d(:,:,1,1,1));
printgraph('T2S/result',p,r_square,RSS,a_show_fitmatrix,clean_t_vector,nvoxels,nex,name);







