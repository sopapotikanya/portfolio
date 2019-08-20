
main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Result/CMRtools/2014-10-01/excel/';
cd(main_path);

for u=1:3
    for p=1:15
        if p < 10
            read_table = xlsread(['CMRtools_user' num2str(u) '_0' num2str(p) '.xlsx']);
        else
            read_table = xlsread(['CMRtools_user' num2str(u) '_' num2str(p) '.xlsx']);
        end
        T2s = read_table(17,2);
        T2s_table(p,u) = T2s;
    end
end
cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/');
save(['T2s_CMR_' date_name],'T2s_table');
