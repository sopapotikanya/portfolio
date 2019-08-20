close all
clear all

load('conc_iron.mat')
load('despath.mat')
t2spath='/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart';
cd(t2spath);

total_t2s_us = [];
total_t2s_cmr = [];

user_index = [1 3];
fig1= figure;
hold on
for i=1:size(user_index,2)
    t2s15_us_name = ['T2s_MRIM3T_user' num2str(user_index(i)) '.mat'];
    t2s15_cmr_name = ['T2s_CMR_user' num2str(user_index(i)) '.mat'];
    
    load(t2s15_us_name);
    T2s_table(:,[4,5,10])='';

    t2s15_us_vector = reshape(T2s_table, size(T2s_table,1)*size(T2s_table,2), 1 );

    load(t2s15_cmr_name);
    T2s_table(:,[4,5,10])='';
    t2s15_cmr_vector = reshape(T2s_table, size(T2s_table,1)*size(T2s_table,2), 1 );
    
    
    if(i==1)
        
    plot(t2s15_cmr_vector, t2s15_us_vector,'*','Color',[0.8,0,0]);
    total_t2s_us = t2s15_us_vector;
    total_t2s_cmr = t2s15_cmr_vector;
    else
        
        t2s15_cmr_vector(95) = '';
        t2s15_us_vector(95) = '';
         plot(t2s15_cmr_vector, t2s15_us_vector,'*','Color',[0.8,0,0]);
        total_t2s_us =[total_t2s_us' t2s15_us_vector'];
        total_t2s_cmr =[total_t2s_cmr' t2s15_cmr_vector'];
    end
    
end

r = correlation_new(total_t2s_cmr', total_t2s_us');
% p = polyfit(total_t2s_cmr, total_t2s_us,1);
% f1 = polyval(p,total_t2s_cmr);
% plot(total_t2s_cmr, f1);

xlabel('t2* (ms) CMR 1.5T');
ylabel('t2* (ms) MRIM 3T');
% legend('t2*')
title('Corelation CMR 1.5T  &  MRIM 3T')
axis([0 25 0 25]);
print(fig1,'fig_CMRvs3T','-dpng');

hold off

y = p(1)*x + p(2);