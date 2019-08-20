
tesla = 'T';
name = 'TRIMTESTAVG';
roi_name = 'ROI';
machine_name = '1001';


[finfo,t_vector,z_vector,y_axis,x_axis,z_axis,t_axis] = dcmreadmultifile(machine_name,1);
mat5d = cremat5d;


neg_ind = find(mat5d <= 0);
dicom_min = 1/(2^10); % min of dicom image above 0
mat5d(neg_ind) = dicom_min;
nex = size(mat5d,5);

roiname = 'roi3t.mat';
roi = readroi('ROI/5',roiname);

mat5d_resize = roitrimmat5d(roi,mat5d);
fitmatrix = createfitmatrix(t_vector,mat5d_resize);

% Linearize + Average
[clean_t_vector,clean_fitmatrix] = cleannan(t_vector, fitmatrix);
n_repeat = 2;
repeat_thres = 6;
[trim_fitmatrix,trim_t_vector] = trimtail_edit1(clean_t_vector,clean_fitmatrix,n_repeat,repeat_thres);
[l_fitmatrix,min_residue] = linearize(trim_fitmatrix);
%[d_l_fitmatrix,mean_matrix] = demean(l_fitmatrix);
[a_l_fitmatrix,nvoxels] = average(l_fitmatrix);
% If show averaged
a_show_fitmatrix = average(clean_fitmatrix);

[p,r_square,RSS,y_fitmatrix,x_fitmatrix] = pinvfit(trim_t_vector, a_l_fitmatrix);
printtiff(sprintf('%s_%s.tiff',name,roi_name), roi, mat5d(:,:,1,1,1));
printgraph(sprintf('%s_%s',name,tesla),p,r_square,RSS,a_show_fitmatrix,clean_t_vector,nvoxels,nex,name);
%printtxt('ALtrpinv_nvoxels.txt',nvoxels);
%printtxt('ALtrpinv_RSS.txt',RSS);