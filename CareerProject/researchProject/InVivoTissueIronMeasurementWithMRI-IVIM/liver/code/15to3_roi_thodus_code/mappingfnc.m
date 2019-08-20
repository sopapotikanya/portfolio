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

xlabel('t2* (ms) CMR 1.5T');
ylabel('t2* (ms) MRIM 1.5T');
% legend('t2*')
title('Corelation CMR 1.5T  &  MRIM 1.5T')

r = correlation_new(total_t2s_cmr', total_t2s_us');
p = polyfit(total_t2s_cmr, total_t2s_us,1);
f1 = polyval(p,total_t2s_cmr);
axis([0 25 0 25]);
print(fig1,'fig_CMRvs15T','-dpng');
plot(total_t2s_cmr, f1);
print(fig1,'fig_CMRvs15T_fit','-dpng');


hold off
x=[6.3 2.7 1.4];
x2=[20 14 10];
% 2.7-6.3 1.4-2.7 1.4
y = p(1)*x + p(2);
y2 = p(1)*x2 + p(2);

a15 = [0.797082250450882 0.995291911263413 0.999052158291008 ];
b15 = [0.861486550645987 2.03906009879046 2.6029464943595 ];
a3 = [0.961313477353498 1.15286681155156 0.922863162777503];
b3 = [0.845721789718313 1.89270764542586 2.30928553358689];
e = exp(1);
conc15_20 = e.^(b15(1)-a15(1)*log(y));
conc15_10 = e.^(b15(2)-a15(2)*log(y));
conc15_5 = e.^(b15(3)-a15(3)*log(y));

y33 = [4.97 1.96 0.87];

conc3_20 = e.^(b3(1)-(a3(1)*log(y)));
conc3_10 = e.^(b3(2)-(a3(2)*log(y)));
conc3_5 = e.^(b3(3)-(a3(3)*log(y)));
