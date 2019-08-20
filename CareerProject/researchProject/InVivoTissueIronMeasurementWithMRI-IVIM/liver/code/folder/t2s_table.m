% function t2s_table(Tesla)
%% T2s_table(Tesla,sol)
% Tesla = '1.5T';
% sol = 'sol2';
%
% exam : t2s_table('1.5T','sol2')
% exam : t2s_table('3T','sol2')
addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));
Tesla = '1.5T';
load despath.mat
main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Result';
cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/');
%% 1.5T
T2s_table = zeros(15,3);
for u=1:3
    date_name = despath{1};
    for position = 1:15
        path = [main_path '/' Tesla '/' date_name '/user' num2str(u) '/matfile/' num2str(position) '/ppinv.mat'];
%         cd(path)
        load(path,'p');
        t2s = 1/p(1);
        
        T2s_table(position,u) = t2s;
    end
end
if strcmp(Tesla,'1.5T')
    save(['T2s_15T_' date_name],'T2s_table');
elseif  strcmp(Tesla,'3T')
    save(['T2s_3T_' date_name],'T2s_table');
end

% end





