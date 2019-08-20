close all
cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/');

load T2s_CMR_2014-10-01.mat
table(:,1) = mean(T2s_table,2);
load T2s_15T_2014-10-01.mat
table(:,2) = mean(T2s_table,2);
load T2s_3T_2014-10-01.mat
table(:,3) = mean(T2s_table,2);

load conc_iron.mat

%% T2*
% CMR = figure;
% hold on
% plot(mM(1:5,1),table(1:5,1),'-o',mM(6:10,1),table(6:10,1),'-x',mM(11:15,1),table(11:15,1),'-*','LineWidth',1.5)
% xlabel('Conc.(mM)');
% ylabel('t2* (ms)');
% axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('CMRtools')
% hold off
% print(CMR,'CMR','-dpng')
% 
% T15 = figure;
% hold on
% plot(mM(1:5,1),table(1:5,2),'-o',mM(6:10,1),table(6:10,2),'-x',mM(11:15,1),table(11:15,2),'-*','LineWidth',1.5)
% xlabel('Conc.(mM)');
% ylabel('t2* (ms)');
% axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 1.5T')
% hold off
% print(T15,'T15','-dpng')
% 
% T3 = figure;
% hold on
% plot(mM(1:5,1),table(1:5,3),'-o',mM(6:10,1),table(6:10,3),'-x',mM(11:15,1),table(11:15,3),'-*','LineWidth',1.5)
% xlabel('Conc.(mM)');
% ylabel('t2* (ms)');
% axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 3T')
% hold off
% print(T3,'T3','-dpng')
%% T2* log
% CMR = figure;
% hold on
% plot(mM(1:5,1),table(1:5,1),'-o',mM(6:10,1),table(6:10,1),'-x',mM(11:15,1),table(11:15,1),'-*','LineWidth',1.5)
% xlabel('Conc.(mM)');
% ylabel('t2* (ms)');
% axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('CMRtools')
% hold off
% print(CMR,'CMR','-dpng')

% T15log = figure;
% hold on
% plot(log(mM(1:5,1)),log(table(1:5,2)),'-o',log(mM(6:10,1)),log(table(6:10,2)),'-x',log(mM(11:15,1)),log(table(11:15,2)),'-*','LineWidth',1.5)
% xlabel('log(Conc.)(mM)');
% ylabel('log(t2*) (ms)');
% % axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 1.5T')
% hold off
% print(T15log,'T15log','-dpng')
% 
% T3log = figure;
% hold on
% plot(log(mM(1:5,1)),log(table(1:5,3)),'-o',log(mM(6:10,1)),log(table(6:10,3)),'-x',log(mM(11:15,1)),log(table(11:15,3)),'-*','LineWidth',1.5)
% xlabel('log(Conc.)(mM)');
% ylabel('log(t2*) (ms)');
% % axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 3T')
% hold off
% print(T3log,'T3log','-dpng')

%% plot 15T polyfit log T2s
% T2s15T_fit = figure;
% hold on
% p1 = polyfit(log(mM(1:5,1)),log(1./table(1:5,2)),1);
% f1 = polyval(p1,log(mM(1:5,1)));
% p2 = polyfit(log(mM(6:10,1)),log(1./table(6:10,2)),1);
% f2 = polyval(p2,log(mM(6:10,1)));
% p3 = polyfit(log(mM(11:15,1)),log(1./table(11:15,2)),1);
% f3 = polyval(p3,log(mM(11:15,1)));
% 
% plot(log(mM(1:5,1)),log(1./table(1:5,2)),'o',log(mM(6:10,1)),log(1./table(6:10,2)),'x',log(mM(11:15,1)),log(1./table(11:15,2)),'*','LineWidth',1.5)
% plot(log(mM(1:5,1)),f1,log(mM(6:10,1)),f2,log(mM(11:15,1)),f3,'LineWidth',1.5)
% % dim = [.6 .6 .3 .3];
% % str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
% % annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
% 
% xlabel('log(Conc.)(mM)');
% ylabel('log(r2*) (ms)');
% % axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 1.5T')
% hold off
% print(T2s15T_fit,'T2s15T_fit','-dpng')

% %%%% plot 15T polyfit log T2s converst axis
% T2s15T_fit_conv = figure;
% hold on
% p1 = polyfit(log(1./table(1:5,2)),log(mM(1:5,1)),1);
% f1 = polyval(p1,log(1./table(1:5,2)));
% p2 = polyfit(log(1./table(6:10,2)),log(mM(6:10,1)),1);
% f2 = polyval(p2,log(1./table(6:10,2)));
% p3 = polyfit(log(1./table(11:15,2)),log(mM(11:15,1)),1);
% f3 = polyval(p3,log(1./table(11:15,2)));
% 
% plot(log(1./table(1:5,2)),log(mM(1:5,1)),'o',log(1./table(6:10,2)),log(mM(6:10,1)),'x',log(1./table(11:15,2)),log(mM(11:15,1)),'*','LineWidth',1.5)
% plot(log(1./table(1:5,2)),f1,log(1./table(6:10,2)),f2,log(1./table(11:15,2)),f3,'LineWidth',1.5)
% % dim = [.6 .6 .3 .3];
% % str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
% % annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
% 
% ylabel('log(Conc.)(mM)');
% xlabel('log(r2*) (ms)');
% % axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 1.5T')
% hold off
% print(T2s15T_fit_conv,'T2s15T_fit_conv','-dpng')
%% plot 3T polyfit log T2s
% T2s3T_fit = figure;
% hold on
% 
% p1 = polyfit(log(mM(1:5,1)),log(1./table(1:5,3)),1);
% f1 = polyval(p1,log(mM(1:5,1)));
% p2 = polyfit(log(mM(6:10,1)),log(1./table(6:10,3)),1);
% f2 = polyval(p2,log(mM(6:10,1)));
% p3 = polyfit(log(mM(11:15,1)),log(1./table(11:15,3)),1);
% f3 = polyval(p3,log(mM(11:15,1)));
% 
% plot(log(mM(1:5,1)),log(1./table(1:5,3)),'o',log(mM(6:10,1)),log(1./table(6:10,3)),'x',log(mM(11:15,1)),log(1./table(11:15,3)),'*','LineWidth',1.5)
% plot(log(mM(1:5,1)),f1,log(mM(6:10,1)),f2,log(mM(11:15,1)),f3,'LineWidth',1.5)
% % dim = [.6 .6 .3 .3];
% % str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
% % annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
% 
% xlabel('log(Conc.)(mM)');
% ylabel('log(r2*) (ms)');
% % axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 3T')
% hold off
% print(T2s3T_fit,'T2s3T_fit','-dpng')

% %%%%plot 3T polyfit log T2s
% T2s3T_fit_conv = figure;
% hold on
% 
% p1 = polyfit(log(1./table(1:5,3)),log(mM(1:5,1)),1);
% f1 = polyval(p1,log(1./table(1:5,3)));
% p2 = polyfit(log(1./table(6:10,3)),log(mM(6:10,1)),1);
% f2 = polyval(p2,log(1./table(6:10,3)));
% p3 = polyfit(log(1./table(11:15,3)),log(mM(11:15,1)),1);
% f3 = polyval(p3,log(1./table(11:15,3)));
% 
% plot(log(1./table(1:5,3)),log(mM(1:5,1)),'o',log(1./table(6:10,3)),log(mM(6:10,1)),'x',log(1./table(11:15,3)),log(mM(11:15,1)),'*','LineWidth',1.5)
% plot(log(1./table(1:5,3)),f1,log(1./table(6:10,3)),f2,log(1./table(11:15,3)),f3,'LineWidth',1.5)
% % dim = [.6 .6 .3 .3];
% % str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
% % annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
% 
% ylabel('log(Conc.)(mM)');
% xlabel('log(r2*) (ms)');
% % axis([0 mM(10)+1 0 16]);
% legend('loading 20%','loading 10%','loading 5%')
% title('MRIM 3T')
% hold off
% print(T2s3T_fit_conv,'T2s3T_fit_conv','-dpng')
%% T2* all
all = figure;
hold on
p = 1:15;
plot(p,table(:,1),'-o',p,table(:,2),'-x',p,table(:,3),'-*','LineWidth',1.5)
xlabel('Position');
ylabel('t2* (ms)');
axis([0 16 0 16]);
legend('CMRtools','MRIM 1.5T','MRIM 3T')
title('T2*')
hold off
print(all,'all','-dpng')
%% CMRtools vs MRIM 1.5T
Rx_CMRvs15T = table(:,1);
Ry_CMRvs15T = table(:,2);
R_CMRvs15T = correlation_new(Rx_CMRvs15T,Ry_CMRvs15T);

fig_CMRvs15T = figure;
hold on
plot(Rx_CMRvs15T,Ry_CMRvs15T,'*','color',[0,0.8,0])
xlabel('CMRtools 1.5T');
ylabel('MRIM 1.5T');
title('Correlation CMRtools & MRIM 1.5T')
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_CMRvs15T)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_CMRvs15T,'fig_CMRvs15T','-dpng')

% position 4, 5, 10 error
Rx_CMRvs15T_e = cat(1,table(1:3,1),table(6:9,1),table(11:15,1));
Ry_CMRvs15T_e = cat(1,table(1:3,2),table(6:9,2),table(11:15,1));
R_CMRvs15T_e = correlation_new(Rx_CMRvs15T_e,Ry_CMRvs15T_e);

fig_CMRvs15T_e = figure;
hold on
plot(Rx_CMRvs15T_e,Ry_CMRvs15T_e,'*','color',[0,0.7,0])
xlabel('CMRtools 1.5T');
ylabel('MRIM 1.5T');
title('Correlation CMRtools & MRIM 1.5T without error')

dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_CMRvs15T_e)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_CMRvs15T_e,'fig_CMRvs15T_e','-dpng')

%% CMRtools vs MRIM 3T
Rx_CMRvs3T = table(:,1);
Ry_CMRvs3T = table(:,3);
R_CMRvs3T = correlation_new(Rx_CMRvs3T,Ry_CMRvs3T);

fig_CMRvs3T = figure;
hold on
plot(Rx_CMRvs3T,Ry_CMRvs3T,'*','color',[0.8,0,0])
xlabel('CMRtools 1.5T');
ylabel('MRIM 3T');
title('Correlation CMRtools & MRIM 3T')
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_CMRvs3T)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_CMRvs3T,'fig_CMRvs3T','-dpng')

% position 4, 5, 10 error
Rx_CMRvs3T_e = cat(1,table(1:3,1),table(6:9,1),table(11:15,1));
Ry_CMRvs3T_e = cat(1,table(1:3,3),table(6:9,3),table(11:15,3));
R_CMRvs3T_e = correlation_new(Rx_CMRvs3T_e,Ry_CMRvs3T_e);

fig_CMRvs3T_e = figure;
hold on
plot(Rx_CMRvs3T_e,Ry_CMRvs3T_e,'*','color',[0.7,0,0])
xlabel('CMRtools 1.5T');
ylabel('MRIM 3T');
title('Correlation CMRtools & MRIM 3T without error')
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_CMRvs3T_e)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_CMRvs3T_e,'fig_CMRvs3T_e','-dpng')



%% MRIM 1.5T vs MRIM 3T
Rx_15Tvs3T = table(:,2);
Ry_15Tvs3T = table(:,3);
R_15Tvs3T = correlation_new(Rx_15Tvs3T,Ry_15Tvs3T);

fig_15Tvs3T = figure;
hold on
plot(Rx_15Tvs3T,Ry_15Tvs3T,'*','color',[0,0,0.8])
xlabel('MRIM 1.5T');
ylabel('MRIM 3T');
title('Correlation MRIM 1.5T & MRIM 3T')
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_15Tvs3T)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_15Tvs3T,'fig_15Tvs3T','-dpng')

%% Correlation between User
load T2s_CMR_user1.mat
table_user1 = T2s_table;
load T2s_CMR_user2.mat
table_user2 = T2s_table;
load T2s_CMR_user3.mat
table_user3 = T2s_table;

for i=1:15
    for j=1:15
        table_user((i-1)*15+j,1) = table_user1(i,j);
        table_user((i-1)*15+j,2) = table_user2(i,j);
        table_user((i-1)*15+j,3) = table_user3(i,j);
    end
end

% user1 vs user2
R_user1vsuser2 = correlation_new(table_user(:,1),table_user(:,2));

fig_user1vsuser2 = figure;
hold on
plot(table_user(:,1),table_user(:,2),'*')
xlabel('T2s user1');
ylabel('T2s user2');
title('Correlation user1 & user2')
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_user1vsuser2)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_user1vsuser2,'fig_user1vsuser2','-dpng')


% user1 vs user3
R_user1vsuser3 = correlation_new(table_user(:,1),table_user(:,3));
fig_user1vsuser3 = figure;
hold on
plot(table_user(:,1),table_user(:,3),'*')
xlabel('T2s user1');
ylabel('T2s user3');
title('Correlation user1 & user3')
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_user1vsuser3)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_user1vsuser3,'fig_user1vsuser3','-dpng')


% user2 vs user3
R_user2vsuser3 = correlation_new(table_user(:,2),table_user(:,3));
fig_user2vsuser3 = figure;
hold on
plot(table_user(:,2),table_user(:,3),'*')
xlabel('T2s user2');
ylabel('T2s user3');
title('Correlation user2 & user3')
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_user2vsuser3)],'FitBoxToText','on','FontSize',12,'Margin',6);
hold off
print(fig_user2vsuser3,'fig_user2vsuser3','-dpng')
