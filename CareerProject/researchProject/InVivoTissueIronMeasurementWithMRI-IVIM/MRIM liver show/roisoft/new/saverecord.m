clear all
close all
mainpath='/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Adult/Thalassemic/';

cd(mainpath);

!rm .DS_Store ._.DS_Store
dir1 = dir;

for i = 3:size(dir1,1)
    cd(dir1(i).name);
    
    
    
    load('15_results_data.mat');
      g{i-2,1} =  dir1(i).name
%      g(i-2,2:10) =  [t2_h r2_h t2_ll r2_ll t2_lr r2_ll r2_lr t2_p r2_p];
     g{i-2,2} = t2_h;
     g{i-2,3} = r2_h;
     g{i-2,4} = t2_ll;
     g{i-2,5} = r2_ll;
     g{i-2,6} = t2_lr;
     g{i-2,7} = r2_lr;
     g{i-2,8} = t2_p;
     g{i-2,9} = r2_p;
     
     
    
    cd ../
end
