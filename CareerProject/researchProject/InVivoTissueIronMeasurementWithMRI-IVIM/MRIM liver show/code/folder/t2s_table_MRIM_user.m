addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));

main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Result/';
cd(main_path);
Tesla = '1.5T';
load despath.mat
T2s_table = zeros(15,15);
ratio_table = zeros(15,15);
for u=2
    cd(main_path);
    for d=1:15
        
    date_name = despath{d};
    
        for position=1:15
            path = [main_path Tesla '/' date_name '/user' num2str(u) '/matfile/' num2str(position) '/ppinv.mat'];
            load(path);
            t2s = 1/p(1);
            T2s_table(d,position) = t2s;
            ratio_table1(d,position) = ratioI1;
            ratio_table2(d,position) = ratioI2;
            ratio_table3(d,position) = ratioI3;
        end
    end
    save(['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/T2s_MRIM15T_user' num2str(u)],'T2s_table');
% save(['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/T2s_ratio3T_user' num2str(u)],'ratio_table');
end