close all
clear
cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/');

load T2s_CMR_2014-10-01.mat
table(:,1) = mean(T2s_table,2);
load T2s_15T_2014-10-01.mat
table(:,2) = mean(T2s_table,2);
load T2s_3T_2014-10-01.mat
table(:,3) = mean(T2s_table,2);

load conc_iron.mat   % [t2*,dryweight]
CMR_ref = [ 6.3, 2; 2.7, 5; 1.4, 10];

load pMapMethod

%% %%% plot 15T polyfit log T2s converst axis

x_log = (-3:0.1:1)';
p(1,:) = polyfit(log(1./table(1:5,2)),log(mM(1:5,1)),1);
f(:,1) = polyval(p(1,:),x_log);
p(2,:) = polyfit(log(1./table(6:10,2)),log(mM(6:10,1)),1);
f(:,2) = polyval(p(2,:),x_log);
p(3,:) = polyfit(log(1./table(11:15,2)),log(mM(11:15,1)),1);
f(:,3) = polyval(p(3,:),x_log);


T2s15T_fit_conv = figure;
hold on
plot(x_log,f(:,1),x_log,f(:,2),x_log,f(:,3),'LineWidth',1.5)
plot(log(1./table(1:5,2)),log(mM(1:5,1)),'o',log(1./table(6:10,2)),log(mM(6:10,1)),'x',log(1./table(11:15,2)),log(mM(11:15,1)),'*','LineWidth',1.5)

% dim = [.6 .6 .3 .3];
% str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
% annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);

ylabel('log(Conc.)(mM)');
xlabel('log(r2*) (ms)');
% axis([0 mM(10)+1 0 16]);
legend('loading 20%','loading 10%','loading 5%')
title('MRIM 1.5T')
hold off
print(T2s15T_fit_conv,'T2s15T_fit_conv','-dpng')


%% %%% plot 15T polyfit T2s

x = (0:0.1:16)';
conc(:,1) = exp(p(1,1)*log(1./x) + p(1,2));
conc(:,2) = exp(p(2,1)*log(1./x) + p(2,2));
conc(:,3) = exp(p(3,1)*log(1./x) + p(3,2));
conct(:,1) = exp(p(1,2) - p(1,1)*log(x));
conct(:,2) = exp(p(2,2) - p(2,1)*log(x));
conct(:,3) = exp(p(3,2) - p(3,1)*log(x));
T15 = figure;
hold on
plot(conc(:,1),x,conc(:,2),x,conc(:,3),x,'LineWidth',1.5)
plot(mM(1:5,1),table(1:5,2),'o',mM(6:10,1),table(6:10,2),'x',mM(11:15,1),table(11:15,2),'*','LineWidth',1.5)
xlabel('Conc.(mM)');
ylabel('t2* (ms)');
axis([0 mM(10)+1 0 16]);
legend('loading 20%','loading 10%','loading 5%')
title('MRIM 1.5T')
hold off
print(T15,'T15','-dpng')


%% %%% plot 15T ref
MRIM_ref(:,1) = pMapMethod(1,1)*CMR_ref(:,1) + pMapMethod(1,2);
MRIM_ref(:,2) = exp(p(1,1)*log(1./MRIM_ref(:,1)) + p(1,2));
MRIM_ref(:,3) = exp(p(2,1)*log(1./MRIM_ref(:,1)) + p(2,2));
MRIM_ref(:,4) = exp(p(3,1)*log(1./MRIM_ref(:,1)) + p(3,2));

T15_ref = figure;
hold on
plot(MRIM_ref(:,2),MRIM_ref(:,1),'-o',MRIM_ref(:,3),MRIM_ref(:,1),'-x',MRIM_ref(:,4),MRIM_ref(:,1),'-*','LineWidth',1.5)
plot(CMR_ref(:,2),CMR_ref(:,1),'-s','LineWidth',1.5)
xlabel('Conc.(mM)');
ylabel('t2* (ms)');
axis([0 14 0 7]);
legend('loading 20%','loading 10%','loading 5%','CMRtools')
title('MRIM 1.5T')
hold off
print(T15_ref,'T15_ref','-dpng')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
% 3T
%
%% %%% plot 3T polyfit log T2s converst axis

x_log = (-3:0.1:1)';
p(1,3:4) = polyfit(log(1./table(1:5,3)),log(mM(1:5,1)),1);
f(:,4) = polyval(p(1,3:4),x_log);
p(2,3:4) = polyfit(log(1./table(6:10,3)),log(mM(6:10,1)),1);
f(:,5) = polyval(p(2,3:4),x_log);
p(3,3:4) = polyfit(log(1./table(11:15,3)),log(mM(11:15,1)),1);
f(:,6) = polyval(p(3,3:4),x_log);


T2s3T_fit_conv = figure;
hold on
plot(x_log,f(:,4),x_log,f(:,5),x_log,f(:,6),'LineWidth',1.5)
plot(log(1./table(1:5,3)),log(mM(1:5,1)),'o',log(1./table(6:10,3)),log(mM(6:10,1)),'x',log(1./table(11:15,3)),log(mM(11:15,1)),'*','LineWidth',1.5)

% dim = [.6 .6 .3 .3];
% str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
% annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);

ylabel('log(Conc.)(mM)');
xlabel('log(r2*) (ms)');
% axis([0 mM(10)+1 0 16]);
legend('loading 20%','loading 10%','loading 5%')
title('MRIM 3T')
hold off
print(T2s3T_fit_conv,'T2s3T_fit_conv','-dpng')


%% %%% plot 3T polyfit T2s

x = (0:0.1:16)';
conc(:,4) = exp(p(1,3)*log(1./x) + p(1,4));
conc(:,5) = exp(p(2,3)*log(1./x) + p(2,4));
conc(:,6) = exp(p(3,3)*log(1./x) + p(3,4));

T3 = figure;
hold on
plot(conc(:,4),x,conc(:,5),x,conc(:,6),x,'LineWidth',1.5)
plot(mM(1:5,1),table(1:5,3),'o',mM(6:10,1),table(6:10,3),'x',mM(11:15,1),table(11:15,3),'*','LineWidth',1.5)
xlabel('Conc.(mM)');
ylabel('t2* (ms)');
axis([0 mM(10)+1 0 16]);
legend('loading 20%','loading 10%','loading 5%')
title('MRIM 3T')
hold off
print(T3,'T3','-dpng')


%% %%% plot 3T ref
MRIM_ref(:,5) = pMapMethod(2,1)*MRIM_ref(:,1) + pMapMethod(2,2);
MRIM_ref(:,6) = exp(p(1,3)*log(1./MRIM_ref(:,5)) + p(1,4));
MRIM_ref(:,7) = exp(p(2,3)*log(1./MRIM_ref(:,5)) + p(2,4));
MRIM_ref(:,8) = exp(p(3,3)*log(1./MRIM_ref(:,5)) + p(3,4));

T3_ref = figure;
hold on
plot(MRIM_ref(:,6),MRIM_ref(:,5),'-o',MRIM_ref(:,7),MRIM_ref(:,5),'-x',MRIM_ref(:,8),MRIM_ref(:,5),'-*','LineWidth',1.5)
plot(CMR_ref(:,2),CMR_ref(:,1),'-s','LineWidth',1.5)
xlabel('Conc.(mM)');
ylabel('t2* (ms)');
% axis([0 mM(10)+1 0 16]);
legend('loading 20%','loading 10%','loading 5%','CMRtools')
title('MRIM 3T')
hold off
print(T3_ref,'T3_ref','-dpng')