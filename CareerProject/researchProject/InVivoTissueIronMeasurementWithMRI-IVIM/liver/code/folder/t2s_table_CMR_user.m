addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));

main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Result/CMRtools/';
cd(main_path);

load despath.mat
for u=1:3
    for d=1:15
        
    date_name = despath{d};
        for p=1:15
            if p < 10
                read_table = xlsread([date_name '/excel/CMRtools_user' num2str(u) '_0' num2str(p) '.xlsx']);
            else
                read_table = xlsread([date_name '/excel/CMRtools_user' num2str(u) '_' num2str(p) '.xlsx']);
            end
            T2s = read_table(17,2);
            T2s_table(d,p) = T2s;
        end
    end
    save(['/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/T2s_CMR_user' num2str(u)],'T2s_table');
end

