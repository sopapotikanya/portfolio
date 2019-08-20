close all
clear
load conc_iron.mat   %mM


load T2s_CMRtools.mat
T2s_CMR = cell2mat(t2s(1:15,2:16));

load T2s_15T.mat
T2s_15T = cell2mat(t2s(1:15,2:16));

load T2s_3T.mat
T2s_3T = cell2mat(t2s(1:15,2:16));

%% plot all set 1
set1 = figure;
hold on
plot(mM(1:5,1),T2s_CMR(1,1:5)','-go',mM(1:5,1),T2s_15T(1,1:5)','-ro',mM(1:5,1),T2s_3T(1,1:5)','-bo')
xlabel('Conc.(mM)');
ylabel('t2*');
axis([0 mM(5,1)+1 0 16]);
legend('CMRtools','MRIM15T','MRIM3T')
hold off
% print(set1,'set1_w1','-dpng')

%% plot all set 1
set1 = figure;
hold on
plot(mM(6:10,1),T2s_CMR(1,6:10)','-go',mM(6:10,1),T2s_15T(1,6:10)','-ro',mM(6:10,1),T2s_3T(1,6:10)','-bo')
xlabel('Conc.(mM)');
ylabel('t2*');
axis([0 mM(10,1)+1 0 16]);
legend('CMRtools','MRIM15T','MRIM3T')
hold off
% print(set1,'set1','-dpng')





