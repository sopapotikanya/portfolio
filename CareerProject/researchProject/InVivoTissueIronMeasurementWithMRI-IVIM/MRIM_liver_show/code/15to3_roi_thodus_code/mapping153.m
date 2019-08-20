close all
clear all

load('conc_iron.mat')
load('despath.mat')
t2spath='/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart';
cd(t2spath);

total_t2s_us = [];
total_t2s_cmr = [];

user_index = [1 3];
fig1 = figure;
hold on
for i=1:size(user_index,2)
    t2s15_us_name = ['T2s_MRIM15T_user' num2str(user_index(i)) '.mat'];
    t2s15_cmr_name = ['T2s_MRIM3T_user' num2str(user_index(i)) '.mat'];
    
    load(t2s15_us_name);
%     T2s_table(:,[4,5,10])='';

    t2s15_us_vector = reshape(T2s_table, size(T2s_table,1)*size(T2s_table,2), 1 );

    load(t2s15_cmr_name);
%     T2s_table(:,[4,5,10])='';
    t2s15_cmr_vector = reshape(T2s_table, size(T2s_table,1)*size(T2s_table,2), 1 );
    
    
    if(i==1)
        
    plot(t2s15_us_vector,t2s15_cmr_vector,'*','Color',[0.8,0,0]);
    total_t2s_us = t2s15_us_vector;
    total_t2s_cmr = t2s15_cmr_vector;
    else
        
        
         plot(t2s15_us_vector,t2s15_cmr_vector,'*','Color',[0.8,0,0]);
        total_t2s_us =[total_t2s_us' t2s15_us_vector'];
        total_t2s_cmr =[total_t2s_cmr' t2s15_cmr_vector'];
    end
    
end
      
r = correlation_new(total_t2s_us',total_t2s_cmr');
p = polyfit(total_t2s_us,total_t2s_cmr,1);
f1 = polyval(p,total_t2s_us);
axis([0 25 0 25]);
ylabel('t2* (ms) MRIM 3T');
xlabel('t2* (ms) MRIM 1.5T');
% legend('t2*')
title('Corelation MRIM 3T  &  MRIM 1.5T')
% print(fig1,'fig_15Tvs3T','-dpng');
plot(total_t2s_us, f1);
% print(fig1,'fig_15Tvs3T_fit','-dpng');



hold off

x=[6.02934053991697 2.41335138740159 1.10757752677103];
x2=[19.7901881481005 13.7635395605749 9.74577383555779];
% 2.7-6.3 1.4-2.7 1.4
y = p(1)*x + p(2);
y2 = p(1)*x2 + p(2);

a3 = [0.961313477353498 1.15286681155156 0.922863162777503];
b3 = [0.845721789718313 1.89270764542586 2.30928553358689];

e = exp(1); 

conc3_20 = e.^(b3(1)-(a3(1)*log(y)));
conc3_10 = e.^(b3(2)-(a3(2)*log(y)));
conc3_5 = e.^(b3(3)-(a3(3)*log(y)));