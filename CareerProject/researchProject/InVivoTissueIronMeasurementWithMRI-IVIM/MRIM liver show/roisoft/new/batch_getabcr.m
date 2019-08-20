
clear all
close all
mainpath='/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Adult/Thalassemic/';

cd(mainpath);

!rm .DS_Store ._.DS_Store

patients = dir;

for i=133:size(patients,1)

cd(patients(i).name);
patientpath = pwd;
cd('HEART/1.5T/CMRtools');
numbers_h = read_r2star_CMR_patient('HEART_1');
abc_h = numbers_h(:,1:3);
r2_h = numbers_h(:,4);
cd(patientpath);

cd('LIVER/1.5T/CMRtools');
numbers_ll = read_r2star_CMR_patient('LIVER_LT_1');
numbers_lr = read_r2star_CMR_patient('LIVER_RT_1');
abc_ll = numbers_ll(:,1:3);
r2_ll = numbers_ll(:,4);
abc_lr = numbers_lr(:,1:3);
r2_lr = numbers_lr(:,4);
cd(patientpath);

cd('PANCREASE/1.5T/CMRtools');
numbers_p = read_r2star_CMR_patient('PANCREAS_1');
abc_p = numbers_p(:,1:3);
r2_p = numbers_p(:,4);
cd(patientpath);

hn = patients(i).name;

[t2_h, t2_ll, t2_lr, t2_p, plt_h, plt_ll, plt_lr, plt_p] = read_plot_t2star_patient(hn);
save('15_results_data.mat','hn','abc_h','r2_h','abc_ll','r2_ll','abc_lr','r2_lr','abc_p','r2_p','t2_h','t2_ll','t2_lr','t2_p','plt_h','plt_ll','plt_lr','plt_p');
cd(mainpath);
end