function T2s_sol7(machine_name,roi_path,position,roiname,Tesla)
% save_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/Result/sol5/';
% machine_name = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/DICOM/1.5T/2014-09-30/each_series/7';
% roi_path = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantomoftheopera/ROI/1.5T/2014-09-30/1/';

save_path = pwd;
tesla = 'T';
name = 'TRIMTESTAVG';
roi_name_save = 'ROI';
% roiname = 'roi.mat';
folder_name = num2str(position); %position
% position_name = '01';
if str2double(folder_name) < 10
    position_name = ['0' folder_name];
else
    position_name = folder_name;
end

cd(save_path);
mkdir matfile
cd matfile
mkdir(folder_name);
cd(folder_name);
[finfo,t_vector,z_vector,y_axis,x_axis,z_axis,t_axis] = dcmreadmultifile(machine_name,1);
mat5d = cremat5d;


% from Wit edit
neg_ind = find(mat5d <= 0);
dicom_min = 1/(2^10); % min of dicom image above 0
mat5d(neg_ind) = dicom_min;
nex = size(mat5d,5);
  

roi = readroi(roi_path,roiname);

mat5d_resize = roitrimmat5d(roi,mat5d);
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


[p,r_square,RSS,y_fitmatrix,x_fitmatrix] = pinvfit_edit2(trim_t_vector, a_l_fitmatrix, a_show_fitmatrix,Tesla);
cd(save_path);
mkdir screenshot
cd screenshot
printtiff(sprintf('%s_%s.tiff',name,[roi_name_save position_name]), roi, mat5d(:,:,1,1,1));
printgraph(sprintf('%s_%s',name,[tesla position_name]),p,r_square,RSS,a_show_fitmatrix,clean_t_vector,nvoxels,nex,name);
cd(save_path);
%printtxt('ALtrpinv_nvoxels.txt',nvoxels);
%printtxt('ALtrpinv_RSS.txt',RSS);