function maxminratio_table(Tesla,sol)
%% maxminratio_table(Tesla,sol)
% Tesla = '1.5T';
% sol = 'sol5';
%
% exam : maxminratio_table('1.5T','sol2')
%
addpath(genpath('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/code'));

load despath.mat
main_path =  '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Result';
cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/');
% sol = {'08user1','08user2','08user3'};
%% 1.5T
ratio1 = cell(15*3,17);
ratio2 = cell(15*3,17);
ratio3 = cell(15*3,17);
T2s_table = cell(15*3,17);
for d=1:15
    date_name = despath{d};
    
    carry = 0;
    for s=1:3
        ratio1((d-1)*3+s,1) = {date_name};
        ratio1((d-1)*3+s,2) = sol(s);
        ratio2((d-1)*3+s,1) = {date_name};
        ratio2((d-1)*3+s,2) = sol(s);
        ratio3((d-1)*3+s,1) = {date_name};
        ratio3((d-1)*3+s,2) = sol(s);
        T2s_table((d-1)*3+s,1) = {date_name};
        T2s_table((d-1)*3+s,2) = sol(s);
        for position = 1:15
            path = [main_path '/' Tesla '/' date_name '/' sol{s} '/matfile/' num2str(position) '/ppinv.mat'];
    %         cd(path)
            load(path,'ratioI1','ratioI2','ratioI3','p');
%             minV = min(a_show_fitmatrix);
%             maxV = max(a_show_fitmatrix);
%             ratioV = minV/maxV;

    %         t2s{d,position+1+carry} = minV;
    %         t2s{d,position+2+carry} = maxV;
            ratio1{(d-1)*3+s,position+2} = ratioI1;
            ratio2{(d-1)*3+s,position+2} = ratioI2;
            ratio3{(d-1)*3+s,position+2} = ratioI3;
            T2s_table{(d-1)*3+s,position+2} = 1/p(1);
            carry = carry + 2;
        end
    end
end
if strcmp(Tesla,'1.5T')
    save('Ratio1_15T','ratio1');
    save('Ratio2_15T','ratio2');
    save('Ratio3_15T','ratio3');
    save('T2s_15T'   ,'T2s_table');
elseif  strcmp(Tesla,'3T')
     save('Ratio1_3T','ratio1');
     save('Ratio2_3T','ratio2');
     save('Ratio3_3T','ratio3');
     save('T2s_3T'  ,'T2s_table');
end

end
