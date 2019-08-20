%% load data
close all
load conc_iron.mat
x1 = mM(1:5,1);
x2 = mM(6:10,1);
x3 = mM(11:15,1);


load T2s_CMRtools_mean
y_CMRtools = t2s(1:15,1);
y_CMRtools1 = t2s(1:5,1);
y_CMRtools2 = t2s(6:10,1);
y_CMRtools3 = t2s(11:15,1);

load T2s_15T_mean
y_15T = t2s(1:15,1);
y_15T1 = t2s(1:5,1);
y_15T2 = t2s(6:10,1);
y_15T3 = t2s(11:15,1);

load T2s_3T_mean
y_3T = t2s(1:15,1);
y_3T1 = t2s(1:5,1);
y_3T2 = t2s(6:10,1);
y_3T3 = t2s(11:15,1);
%% -------------------------------------------------------------- %%
%% plot all set 1
set1 = figure;
hold on
plot(x1,y_CMRtools1,'-go',x1,y_15T1,'-ro',x1,y_3T1,'-bo')
xlabel('Conc.(mM)');
ylabel('t2*');
axis([0 x1(5)+1 0 16]);
legend('CMRtools','MRIM15T','MRIM3T')
hold off
print(set1,'set1','-dpng')
%% plot all set 2
set2 = figure;
hold on
plot(x2,y_CMRtools2,'-go',x2,y_15T2,'-ro',x2,y_3T2,'-bo')
xlabel('Conc.(mM)');
ylabel('t2*');
axis([0 x2(5)+1 0 16]);
legend('CMRtools','MRIM15T','MRIM3T')
hold off
print(set2,'set2','-dpng')
%% plot all set 3
set3 = figure;
hold on
plot(x3,y_CMRtools3,'-go',x3,y_15T3,'-ro',x3,y_3T3,'-bo')
xlabel('Conc.(mM)');
ylabel('t2*');
axis([0 x3(5)+1 0 16]);
legend('CMRtools','MRIM15T','MRIM3T')
hold off
print(set3,'set3','-dpng')
%% correlation CMRtool vs MRIM 1.5T
correlate1 = figure,
hold on
scatter(y_CMRtools1(1:3,1),y_15T1(1:3,1),'*');
scatter(y_CMRtools2(1:4,1),y_15T2(1:4,1),'*');
scatter(y_CMRtools3,y_15T3,'*');
title('Correlation Scatter')
legend('set1 loading20%','set2 loading10%','set3 loading5%')
xlabel('CMRtools 1.5T T2* value')
ylabel('MRIM 1.5T T2* value')
% position 4, 5, 10 error
Rx_CMRvs15T = cat(1,y_CMRtools1(1:3,1),y_CMRtools2(1:4,1),y_CMRtools3);
Ry_CMRvs15T = cat(1,y_15T1(1:3,1),y_15T2(1:4,1),y_15T3);
N_CMRvs15T = size(Rx_CMRvs15T,1);
R_CMRvs15T = (N_CMRvs15T*sum(Rx_CMRvs15T.*Ry_CMRvs15T) - sum(Rx_CMRvs15T)*sum(Ry_CMRvs15T))/sqrt((N_CMRvs15T*sum(Rx_CMRvs15T.*Rx_CMRvs15T)-(sum(Rx_CMRvs15T)*sum(Rx_CMRvs15T)))*(N_CMRvs15T*sum(Ry_CMRvs15T.*Ry_CMRvs15T)-(sum(Ry_CMRvs15T)*sum(Ry_CMRvs15T))));
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_CMRvs15T)],'FitBoxToText','on','FontSize',12,'Margin',6);
 
hold off
print(correlate1,'correlate1','-dpng')




correlate2 = figure,
hold on
scatter(y_CMRtools1(1:3,1),y_3T1(1:3,1),'*');
scatter(y_CMRtools2(1:4,1),y_3T2(1:4,1),'*');
scatter(y_CMRtools3,y_3T3,'*');
title('Correlation Scatter')
legend('set1 loading20%','set2 loading10%','set3 loading5%')
xlabel('CMRtools 1.5T T2* value')
ylabel('MRIM 3T T2* value')
Rx_CMRvs3T = cat(1,y_CMRtools1(1:3,1),y_CMRtools2(1:4,1),y_CMRtools3);
Ry_CMRvs3T = cat(1,y_3T1(1:3,1),y_3T2(1:4,1),y_3T3);
N_CMRvs3T = size(Rx_CMRvs3T,1);
R_CMRvs3T = (N_CMRvs3T*sum(Rx_CMRvs3T.*Ry_CMRvs3T) - sum(Rx_CMRvs3T)*sum(Ry_CMRvs3T))/sqrt((N_CMRvs3T*sum(Rx_CMRvs3T.*Rx_CMRvs3T)-(sum(Rx_CMRvs3T)*sum(Rx_CMRvs3T)))*(N_CMRvs3T*sum(Ry_CMRvs3T.*Ry_CMRvs3T)-(sum(Ry_CMRvs3T)*sum(Ry_CMRvs3T))));
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_CMRvs3T)],'FitBoxToText','on','FontSize',12,'Margin',6);
 
hold off
print(correlate2,'correlate2','-dpng')





correlate3 = figure,
hold on
scatter(y_15T1,y_3T1,'*');
scatter(y_15T2,y_3T2,'*');
scatter(y_15T3,y_3T3,'*');
title('Correlation Scatter')
legend('set1 loading20%','set2 loading10%','set3 loading5%')
xlabel('MRIM 1.5T T2* value')
ylabel('MRIM 3T T2* value')
Rx_15Tvs3T = cat(1,y_15T1,y_15T2,y_15T3);
Ry_15Tvs3T = cat(1,y_3T1,y_3T2,y_3T3);
N_15Tvs3T = size(Rx_15Tvs3T,1);
R_15Tvs3T = (N_15Tvs3T*sum(Rx_15Tvs3T.*Ry_15Tvs3T) - sum(Rx_15Tvs3T)*sum(Ry_15Tvs3T))/sqrt((N_15Tvs3T*sum(Rx_15Tvs3T.*Rx_15Tvs3T)-(sum(Rx_15Tvs3T)*sum(Rx_15Tvs3T)))*(N_15Tvs3T*sum(Ry_15Tvs3T.*Ry_15Tvs3T)-(sum(Ry_15Tvs3T)*sum(Ry_15Tvs3T))));
dim = [.15 .6 .3 .3];
annotation('textbox',dim,'String',['correlation : ' num2str(R_15Tvs3T)],'FitBoxToText','on','FontSize',12,'Margin',6);
 
hold off
print(correlate3,'correlate3','-dpng')



%% -------------------------------------------------------------- %%
%% plot 15T T2s
T2s15T = figure;
hold on
plot(x1,y_15T1,'-ro',x2,y_15T2,'-rx',x3,y_15T3,'-rs')
% plot(x1,y_15T1,'r--')
% plot(x2,y_15T2,'-rx')
% plot(x2,y_15T2,'r--')
% plot(x3,y_15T3,'-rs')
% plot(x3,y_15T3,'r--')
xlabel('Conc.(mM)');
ylabel('t2*');
legend('set1','set2','set3')
hold off
print(T2s15T,'T2s15T','-dpng')
%% plot 15T polyfit log T2s
T2s15T_fit = figure;
hold on
p1 = polyfit(log(x1),log(y_15T1),1);
f1 = polyval(p1,log(x1));
p2 = polyfit(log(x2),log(y_15T2),1);
f2 = polyval(p2,log(x2));
p3 = polyfit(log(x3),log(y_15T3),1);
f3 = polyval(p3,log(x3));
plot(log(x1),f1,'r--',log(x2),f2,'r--',log(x3),f3,'r--')
legend('set1','set2','set3','location','northoutside','Orientation','horizontal')
plot(log(x1),log(y_15T1),'ro')
% plot(log(x1),f1,'r--')
plot(log(x2),log(y_15T2),'rx')
% plot(log(x2),f2,'r--')
plot(log(x3),log(y_15T3),'rs')
% plot(log(x3),f3,'r--')
dim = [.6 .6 .3 .3];
str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
    
% title(sprintf('%s T2*',name));
ylabel('t2*(log)');
xlabel('Conc.(mM)(log)');
hold off
print(T2s15T_fit,'T2s15T_fit','-dpng')
%% plot 15T R2s
R2s15T = figure;
hold on
for i=1:5
    y_15T1r(i,1) = 1/y_15T1(i,1);
    y_15T2r(i,1) = 1/y_15T2(i,1);
    y_15T3r(i,1) = 1/y_15T3(i,1);
end
plot(x1,y_15T1r,'-ro',x2,y_15T2r,'-rx',x3,y_15T3r,'-rs')
% plot(x1,y_15T1r,'ro')
% plot(x1,y_15T1r,'r--')
% plot(x2,y_15T2r,'rx')
% plot(x2,y_15T2r,'r--')
% plot(x3,y_15T3r,'rs')
% plot(x3,y_15T3r,'r--')
xlabel('Conc.(mM)');
ylabel('r2*');
legend('set1','set2','set3')
hold off
print(R2s15T,'R2s15T','-dpng')
%% plot 15T polyfit log R2s
R2s15T_fit = figure;
hold on
p1 = polyfit(log(x1),log(y_15T1r),1);
f1 = polyval(p1,log(x1));
p2 = polyfit(log(x2),log(y_15T2r),1);
f2 = polyval(p2,log(x2));
p3 = polyfit(log(x3),log(y_15T3r),1);
f3 = polyval(p3,log(x3));
plot(log(x1),f1,'r--',log(x2),f2,'r--',log(x3),f3,'r--')
legend('set1','set2','set3','location','northoutside','Orientation','horizontal')
plot(log(x1),log(y_15T1r),'ro')
% plot(log(x1),f1,'r--')
plot(log(x2),log(y_15T2r),'rx')
% plot(log(x2),f2,'r--')
plot(log(x3),log(y_15T3r),'rs')
% plot(log(x3),f3,'r--')
dim = [.6 .6 .3 .3];
str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
    
% title(sprintf('%s T2*',name));
ylabel('r2*(log)');
xlabel('Conc.(mM)(log)');
hold off

print(R2s15T_fit,'R2s15T_fit','-dpng')
%% plot 3T
T2s3T = figure;
hold on
plot(x1,y_3T1,'bo')
plot(x1,y_3T1,'b--')
plot(x2,y_3T2,'bx')
plot(x2,y_3T2,'b--')
plot(x3,y_3T3,'bs')
plot(x3,y_3T3,'b--')
xlabel('Conc.(mM)');
ylabel('t2*');
hold off
print(T2s3T,'T2s3T','-dpng')
%% plot 3T polyfit log T2s
T2s3T_fit = figure;
hold on
p1 = polyfit(log(x1),log(y_3T1),1);
f1 = polyval(p1,log(x1));
p2 = polyfit(log(x2),log(y_3T2),1);
f2 = polyval(p2,log(x2));
p3 = polyfit(log(x3),log(y_3T3),1);
f3 = polyval(p3,log(x3));

plot(log(x1),log(y_3T1),'bo')
plot(log(x1),f1,'b--')
plot(log(x2),log(y_3T2),'bx')
plot(log(x2),f2,'b--')
plot(log(x3),log(y_3T3),'bs')
plot(log(x3),f3,'b--')
dim = [.6 .6 .3 .3];
str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
    
% title(sprintf('%s T2*',name));
ylabel('t2*(log)');
xlabel('Conc.(mM)(log)');
hold off
print(T2s3T_fit,'T2s3T_fit','-dpng')
%% plot 3T R2s
R2s3T = figure;
hold on
for i=1:5
    y_3T1r(i,1) = 1/y_3T1(i,1);
    y_3T2r(i,1) = 1/y_3T2(i,1);
    y_3T3r(i,1) = 1/y_3T3(i,1);
end
plot(x1,y_3T1r,'bo')
plot(x1,y_3T1r,'b--')
plot(x2,y_3T2r,'bx')
plot(x2,y_3T2r,'b--')
plot(x3,y_3T3r,'bs')
plot(x3,y_3T3r,'b--')
xlabel('Conc.(mM)');
ylabel('r2*');
hold off
print(R2s3T,'R2s3T','-dpng')
%% plot 3T polyfit log T2s
R2s3T_fit = figure;
hold on
p1 = polyfit(log(x1),log(y_3T1r),1);
f1 = polyval(p1,log(x1));
p2 = polyfit(log(x2),log(y_3T2r),1);
f2 = polyval(p2,log(x2));
p3 = polyfit(log(x3),log(y_3T3r),1);
f3 = polyval(p3,log(x3));

plot(log(x1),log(y_3T1r),'bo')
plot(log(x1),f1,'b--')
plot(log(x2),log(y_3T2r),'bx')
plot(log(x2),f2,'b--')
plot(log(x3),log(y_3T3r),'bs')
plot(log(x3),f3,'b--')
dim = [.6 .6 .3 .3];
str = {sprintf('polyfit1:\t %f\t%f',p1(1),p1(2));sprintf('polyfit2:\t %f\t%f',p2(1),p2(2));sprintf('polyfit3:\t %f\t%f',p3(1),p3(2));};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
    
% title(sprintf('%s T2*',name));
ylabel('r2*(log)');
xlabel('Conc.(mM)(log)');
hold off
print(R2s3T_fit,'R2s3T_fit','-dpng')
%%
% for i=1:15
% r2s(i,1) = 1/t2s(i,1);
% end
% % x = t2s(1:5,1);
% x1 = r2s(1:5,1);
% y = mM(1:5,1);
% 
% % x = mM(1:5,1);
% % y = t2s(1:5,1);
% % % y = r2s(1:5,1)
% figure
% plot(x1,y,'o')
% hold on
% plot(x1,y,'r--')
% xlabel('r2*');
% ylabel('Conc.(mM)');
% hold off
% 
% x_log = log(x1);
% y_log = log(y);
% p = polyfit(x_log,y_log,1);
% f1 = polyval(p,x_log);
% 
% % figure
% % plot(x,y,'r--')
% % hold on
% % plot(x,y_log,'g--')
% % plot(x_log,y,'b--')
% % plot(x_log,y_log,'y--')
% % hold off
% 
% figure
% plot(x_log,y_log,'o')
% 
% hold on
% plot(x_log,f1,'r--')
% dim = [.6 .6 .3 .3];
% str = {sprintf('polyfit:\t %f\t%f',p(1),p(2))};
% annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
%     
% % title(sprintf('%s T2*',name));
% xlabel('r2*(log)');
% ylabel('Conc.(mM)(log)');
% hold off
% 
% 
% % y = ax+b
% % log_y = p(1)*log_x + p(2)









