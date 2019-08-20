
cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/result/')
% mainpath = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Doc/';
%
% filename = 'phantom.xlsx';
%
% CMRtools = 'CMRtools';
% sol0_3T = 'MRIM3T-sol0';
% sol1_3T = 'MRIM3T-sol1';
% sol2_3T = 'MRIM3T-sol2';
% sol3_3T = 'MRIM3T-sol3';
% sol2_15T = 'MRIM1.5T-sol2';
% sol3_15T = 'MRIM1.5T-sol3';
%
% CMR = xlsread([mainpath filename],CMRtools);
% sol0_3T = xlsread([mainpath filename],sol0_3T);
% sol1_3T = xlsread([mainpath filename],sol1_3T);
% sol2_3T = xlsread([mainpath filename],sol2_3T);
% sol3_3T = xlsread([mainpath filename],sol3_3T);
% sol2_15T = xlsread([mainpath filename],sol2_15T);
% sol3_15T = xlsread([mainpath filename],sol3_15T);
%
% CMR_15T = CMR(1:15,:);
% MRIM2_15T = sol2_15T(1:15,:);
% MRIM3_15T = sol3_15T(1:15,:);
% MRIM0_3T = sol0_3T(1:15,:);
% MRIM1_3T = sol1_3T(1:15,:);
% MRIM2_3T = sol2_3T(1:15,:);
% MRIM3_3T = sol3_3T(1:15,:);
%
% save('CMR_15T.mat','CMR_15T');
% save('MRIM2_15T.mat','MRIM2_15T');
% save('MRIM3_15T.mat','MRIM3_15T');
% save('MRIM0_3T.mat','MRIM0_3T');
% save('MRIM1_3T.mat','MRIM1_3T');
% save('MRIM2_3T.mat','MRIM2_3T');
% save('MRIM3_3T.mat','MRIM3_3T');
%
% save('CMR_15T.txt','CMR_15T','-ascii');
% save('MRIM2_15T.txt','MRIM2_15T','-ascii');
% save('MRIM3_15T.txt','MRIM3_15T','-ascii');
% save('MRIM0_3T.txt','MRIM0_3T','-ascii');
% save('MRIM1_3T.txt','MRIM1_3T','-ascii');
% save('MRIM2_3T.txt','MRIM2_3T','-ascii');
% save('MRIM3_3T.txt','MRIM3_3T','-ascii');



load CMR_15T.mat
load MRIM2_15T.mat
load MRIM3_15T.mat
load MRIM0_3T.mat
load MRIM1_3T.mat
load MRIM2_3T.mat
load MRIM3_3T.mat

% %% sol2 norm
% 
% !mkdir sol2
% cd('sol2');
% for p=1:15
% 
% fig = figure;
% x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
% 
% hold on
% 
% init = (MRIM2_3T(1,p+1) + MRIM2_3T(2,p+1))/2;
% sd = std(MRIM2_3T(:,p+1));
% y = (MRIM2_3T(:,p+1)-init)./sd;
% scatter(x,y,'MarkerEdgeColor',[0,0.8,0.8],'MarkerFaceColor',[0,0.8,0.8])
% plot(x,y,'Color',[0,0.8,0.8])
% fitvars_MRIM2_3T = polyfit(x,y,1);
% f_MRIM2_3T = polyval(fitvars_MRIM2_3T,x);
% p1 = plot(x,f_MRIM2_3T,':','Color',[0,0.8,0.8]);
% 
% init = (MRIM2_15T(1,p+1) + MRIM2_15T(2,p+1))/2;
% sd = std(MRIM2_15T(:,p+1));
% y = (MRIM2_15T(:,p+1)-init)./sd;
% scatter(x,y,'MarkerEdgeColor',[0.8,0.8,0],'MarkerFaceColor',[0.8,0.8,0])
% plot(x,y,'Color',[0.8,0.8,0])
% fitvars_MRIM2_15T = polyfit(x,y,1);
% f_MRIM2_15T = polyval(fitvars_MRIM2_15T,x);
% p2 = plot(x,f_MRIM2_15T,':','Color',[0.8,0.8,0]);
% 
% init = (CMR_15T(1,p+1) + CMR_15T(2,p+1))/2;
% sd = std(CMR_15T(:,p+1));
% y = (CMR_15T(:,p+1)-init)./sd;
% scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
% plot(x,y,'Color',[0.8,0,0.8])
% fitvars_CMR_15T = polyfit(x,y,1);
% f_CMR_15T = polyval(fitvars_CMR_15T,x);
% p3 = plot(x,f_CMR_15T,':','Color',[0.8,0,0.8]);
% 
% 
% hold off
% 
% axis([0 16 -3 5])
% dim = [.6 .6 .3 .3];
% str = {sprintf('position\t %i',p);sprintf('cmrtool 1.5T:\t %f',fitvars_CMR_15T(1));sprintf('MRIM 1.5T:\t %f',fitvars_MRIM2_15T(1));sprintf('MRIM 3T:\t %f',fitvars_MRIM2_3T(1));};
% annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
% xlabel('Time (week)');
% ylabel('T2*(norm)');
% legend([p1,p2,p3],'MRIM3T','MRIM15T','CMRT15T','Location','northwest')
% chartname = ['norm_p' num2str(p)];
% saveas(fig,chartname);
% print(fig,chartname,'-dpng')
% close(fig)
% 
% end
% 
% %% sol3 norm
% 
% cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/result/')
% !mkdir sol3
% cd('sol3');
% for p=1:15
% 
% fig = figure;
% x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
% 
% hold on
% 
% init = (MRIM3_3T(1,p+1) + MRIM3_3T(2,p+1))/2;
% sd = std(MRIM3_3T(:,p+1));
% y = (MRIM3_3T(:,p+1)-init)./sd;
% scatter(x,y,'MarkerEdgeColor',[0,0.8,0.8],'MarkerFaceColor',[0,0.8,0.8])
% plot(x,y,'Color',[0,0.8,0.8])
% fitvars_MRIM3_3T = polyfit(x,y,1);
% f_MRIM3_3T = polyval(fitvars_MRIM3_3T,x);
% p1 = plot(x,f_MRIM3_3T,':','Color',[0,0.8,0.8]);
% 
% init = (MRIM3_15T(1,p+1) + MRIM3_15T(2,p+1))/2;
% sd = std(MRIM3_15T(:,p+1));
% y = (MRIM3_15T(:,p+1)-init)./sd;
% scatter(x,y,'MarkerEdgeColor',[0.8,0.8,0],'MarkerFaceColor',[0.8,0.8,0])
% plot(x,y,'Color',[0.8,0.8,0])
% fitvars_MRIM3_15T = polyfit(x,y,1);
% f_MRIM3_15T = polyval(fitvars_MRIM3_15T,x);
% p2 = plot(x,f_MRIM3_15T,':','Color',[0.8,0.8,0]);
% 
% init = (CMR_15T(1,p+1) + CMR_15T(2,p+1))/2;
% sd = std(CMR_15T(:,p+1));
% y = (CMR_15T(:,p+1)-init)./sd;
% scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
% plot(x,y,'Color',[0.8,0,0.8])
% fitvars_CMR_15T = polyfit(x,y,1);
% f_CMR_15T = polyval(fitvars_CMR_15T,x);
% p3 = plot(x,f_CMR_15T,':','Color',[0.8,0,0.8]);
% 
% 
% hold off
% 
% axis([0 16 -3 5])
% dim = [.6 .6 .3 .3];
% str = {sprintf('position\t %i',p);sprintf('cmrtool 1.5T:\t %f',fitvars_CMR_15T(1));sprintf('MRIM 1.5T:\t %f',fitvars_MRIM3_15T(1));sprintf('MRIM 3T:\t %f',fitvars_MRIM3_3T(1));};
% annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
% xlabel('Time (week)');
% ylabel('T2*(norm)');
% legend([p1,p2,p3],'MRIM3T','MRIM15T','CMRT15T','Location','northwest')
% chartname = ['norm_p' num2str(p)];
% saveas(fig,chartname);
% print(fig,chartname,'-dpng')
% close(fig)
% 
% end

%% mean
% 
% for p=1:5
%     mean_MRIM3_3T(p,1) = sum(MRIM3_3T(:,p+1))/size(MRIM3_3T(:,p+1),1);
%     mean_MRIM3_15T(p,1) = sum(MRIM3_15T(:,p+1))/size(MRIM3_15T(:,p+1),1);
%     mean_MRIM2_3T(p,1) = sum(MRIM2_3T(:,p+1))/size(MRIM2_3T(:,p+1),1);
%     mean_MRIM2_15T(p,1) = sum(MRIM2_15T(:,p+1))/size(MRIM2_15T(:,p+1),1);
%     mean_CMR_15T(p,1) = sum(CMR_15T(:,p+1))/size(CMR_15T(:,p+1),1);
% end
% 
% for p=6:10
%     mean_MRIM3_3T(p-5,2) = sum(MRIM3_3T(:,p+1))/size(MRIM3_3T(:,p+1),1);
%     mean_MRIM3_15T(p-5,2) = sum(MRIM3_15T(:,p+1))/size(MRIM3_15T(:,p+1),1);
%     mean_MRIM2_3T(p-5,2) = sum(MRIM2_3T(:,p+1))/size(MRIM2_3T(:,p+1),1);
%     mean_MRIM2_15T(p-5,2) = sum(MRIM2_15T(:,p+1))/size(MRIM2_15T(:,p+1),1);
%     mean_CMR_15T(p-5,2) = sum(CMR_15T(:,p+1))/size(CMR_15T(:,p+1),1);
% end
% 
% for p=11:15
%     mean_MRIM3_3T(p-10,3) = sum(MRIM3_3T(:,p+1))/size(MRIM3_3T(:,p+1),1);
%     mean_MRIM3_15T(p-10,3) = sum(MRIM3_15T(:,p+1))/size(MRIM3_15T(:,p+1),1);
%     mean_MRIM2_3T(p-10,3) = sum(MRIM2_3T(:,p+1))/size(MRIM2_3T(:,p+1),1);
%     mean_MRIM2_15T(p-10,3) = sum(MRIM2_15T(:,p+1))/size(MRIM2_15T(:,p+1),1);
%     mean_CMR_15T(p-10,3) = sum(CMR_15T(:,p+1))/size(CMR_15T(:,p+1),1);
% end
% 
% for p=1:15
%     sd_MRIM3_3T(p,1) = std(MRIM3_3T(:,p+1));
%     sd_MRIM3_15T(p,1) = std(MRIM3_15T(:,p+1));
%     sd_MRIM2_3T(p,1) = std(MRIM2_3T(:,p+1));
%     sd_MRIM2_15T(p,1) = std(MRIM2_15T(:,p+1));
%     sd_CMR_15T(p,1) = std(CMR_15T(:,p+1));
% end
% %% position 1-5
% fig = figure;
% axis([0 5 0 15])
% hold on
%     x = [1;2;3;4;5];
%     y = mean_MRIM3_3T(:,1);
%     p1 = plot(x,y,'Color',[0,0.8,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0,0.8,0.8],'MarkerFaceColor',[0,0.8,0.8])
%     y = mean_MRIM2_3T(:,1);
%     p2 = plot(x,y,'Color',[0,0.6,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0,0.6,0.6],'MarkerFaceColor',[0,0.6,0.6])
%     y = mean_MRIM3_15T(:,1);
%     p3 = plot(x,y,'Color',[0.8,0.8,0]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0.8,0],'MarkerFaceColor',[0.8,0.8,0])
%     y = mean_MRIM2_15T(:,1);
%     p4 = plot(x,y,'Color',[0.6,0.6,0]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0.6,0],'MarkerFaceColor',[0.6,0.6,0])
%     y = mean_CMR_15T(:,1);
%     p5 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
% hold off
% 
% xlabel('position');
% ylabel('T2*(mean)');
% legend([p1,p2,p3,p4,p5],'MRIM3T:4PointCondition','MRIM3T','MRIM15T:4PointCondition','MRIM15T','CMRT15T','Location','northwest')
% saveas(fig,'meanp1-5');
% print(fig,'meanp1-5','-dpng')
% close(fig)
% 
% %% position 6-10
% fig = figure;
% axis([0 5 0 15])
% hold on
%     x = [1;2;3;4;5];
%     y = mean_MRIM3_3T(:,2);
%     p1 = plot(x,y,'Color',[0,0.8,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0,0.8,0.8],'MarkerFaceColor',[0,0.8,0.8])
%     y = mean_MRIM2_3T(:,2);
%     p2 = plot(x,y,'Color',[0,0.6,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0,0.6,0.6],'MarkerFaceColor',[0,0.6,0.6])
%     y = mean_MRIM3_15T(:,2);
%     p3 = plot(x,y,'Color',[0.8,0.8,0]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0.8,0],'MarkerFaceColor',[0.8,0.8,0])
%     y = mean_MRIM2_15T(:,2);
%     p4 = plot(x,y,'Color',[0.6,0.6,0]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0.6,0],'MarkerFaceColor',[0.6,0.6,0])
%     y = mean_CMR_15T(:,2);
%     p5 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
% hold off
% 
% xlabel('position');
% ylabel('T2*(mean)');
% legend([p1,p2,p3,p4,p5],'MRIM3T:4PointCondition','MRIM3T','MRIM15T:4PointCondition','MRIM15T','CMRT15T','Location','northwest')
% saveas(fig,'meanp6-10');
% print(fig,'meanp6-10','-dpng')
% close(fig)
% 
% %% position 11-15
% fig = figure;
% axis([0 5 0 15])
% hold on
%     x = [1;2;3;4;5];
%     y = mean_MRIM3_3T(:,3);
%     p1 = plot(x,y,'Color',[0,0.8,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0,0.8,0.8],'MarkerFaceColor',[0,0.8,0.8])
%     y = mean_MRIM2_3T(:,3);
%     p2 = plot(x,y,'Color',[0,0.6,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0,0.6,0.6],'MarkerFaceColor',[0,0.6,0.6])
%     y = mean_MRIM3_15T(:,3);
%     p3 = plot(x,y,'Color',[0.8,0.8,0]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0.8,0],'MarkerFaceColor',[0.8,0.8,0])
%     y = mean_MRIM2_15T(:,3);
%     p4 = plot(x,y,'Color',[0.6,0.6,0]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0.6,0],'MarkerFaceColor',[0.6,0.6,0])
%     y = mean_CMR_15T(:,3);
%     p5 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
% hold off
% 
% xlabel('position');
% ylabel('T2*(mean)');
% legend([p1,p2,p3,p4,p5],'MRIM3T:4PointCondition','MRIM3T','MRIM15T:4PointCondition','MRIM15T','CMRT15T','Location','northwest')
% saveas(fig,'meanp11-15');
% print(fig,'meanp11-15','-dpng')
% close(fig)
% %% table mean sd
% table(1:5,1) = mean_CMR_15T(:,1);
% table(6:10,1) = mean_CMR_15T(:,2);
% table(11:15,1) = mean_CMR_15T(:,3);
% table(:,2) = sd_CMR_15T;
% 
% table(1:5,3) = mean_MRIM2_15T(:,1);
% table(6:10,3) = mean_MRIM2_15T(:,2);
% table(11:15,3) = mean_MRIM2_15T(:,3);
% table(:,4) = sd_MRIM2_15T;
% 
% table(1:5,5) = mean_MRIM3_15T(:,1);
% table(6:10,5) = mean_MRIM3_15T(:,2);
% table(11:15,5) = mean_MRIM3_15T(:,3);
% table(:,6) = sd_MRIM3_15T;
% 
% table(1:5,7) = mean_MRIM2_3T(:,1);
% table(6:10,7) = mean_MRIM2_3T(:,2);
% table(11:15,7) = mean_MRIM2_3T(:,3);
% table(:,8) = sd_MRIM2_3T;
% 
% table(1:5,9) = mean_MRIM3_3T(:,1);
% table(6:10,9) = mean_MRIM3_3T(:,2);
% table(11:15,9) = mean_MRIM3_3T(:,3);
% table(:,10) = sd_MRIM3_3T;

%% CMR plot
% !mkdir CMR
% cd CMR
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = CMR_15T(:,2);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = CMR_15T(:,3);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = CMR_15T(:,4);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = CMR_15T(:,5);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = CMR_15T(:,6);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'CMRtools position1','CMRtools position2','CMRtools position3','CMRtools position4','CMRtools position5','Location','northwest')
% saveas(fig,'CMRp1-5');
% print(fig,'CMRp1-5','-dpng')
% close(fig)
% 
% 
% 
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = CMR_15T(:,7);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = CMR_15T(:,8);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = CMR_15T(:,9);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = CMR_15T(:,10);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = CMR_15T(:,11);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'CMRtools position6','CMRtools position7','CMRtools position8','CMRtools position9','CMRtools position10','Location','northwest')
% saveas(fig,'CMRp6-10');
% print(fig,'CMRp6-10','-dpng')
% close(fig)
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = CMR_15T(:,12);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = CMR_15T(:,13);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = CMR_15T(:,14);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = CMR_15T(:,15);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = CMR_15T(:,16);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'CMRtools position11','CMRtools position12','CMRtools position13','CMRtools position14','CMRtools position15','Location','northwest')
% saveas(fig,'CMRp11-15');
% print(fig,'CMRp11-15','-dpng')
% close(fig)
% 
% cd ..

%% MIRM1.5 sol2 plot
cd sol2
fig = figure;
axis([0 16 0 100])
hold on
    x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
    y = MRIM2_15T(:,2);
    p1 = plot(x,y,'Color',[1,0,1]);
    scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
    y = MRIM2_15T(:,3);
    p2 = plot(x,y,'Color',[0.8,0,0.8]);
    scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
    y = MRIM2_15T(:,4);
    p3 = plot(x,y,'Color',[0.6,0,0.6]);
    scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
    y = MRIM2_15T(:,5);
    p4 = plot(x,y,'Color',[0.4,0,0.4]);
    scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
    y = MRIM2_15T(:,6);
    p5 = plot(x,y,'Color',[0.2,0,0.2]);
    scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
hold off
    
xlabel('week');
ylabel('T2*(cal)');
legend([p1,p2,p3,p4,p5],'MRIM1.5T position1','MRIM1.5T position2','MRIM1.5T position3','MRIM1.5T position4','MRIM1.5T position5','Location','northwest')
saveas(fig,'MRIM2_15Tp1-5');
print(fig,'MRIM2_15Tp1-5','-dpng')
close(fig)




fig = figure;
axis([0 16 0 100])
hold on
    x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
    y = MRIM2_15T(:,7);
    p1 = plot(x,y,'Color',[1,0,1]);
    scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
    y = MRIM2_15T(:,8);
    p2 = plot(x,y,'Color',[0.8,0,0.8]);
    scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
    y = MRIM2_15T(:,9);
    p3 = plot(x,y,'Color',[0.6,0,0.6]);
    scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
    y = MRIM2_15T(:,10);
    p4 = plot(x,y,'Color',[0.4,0,0.4]);
    scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
    y = MRIM2_15T(:,11);
    p5 = plot(x,y,'Color',[0.2,0,0.2]);
    scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
hold off
    
xlabel('week');
ylabel('T2*(cal)');
legend([p1,p2,p3,p4,p5],'MRIM1.5T position6','MRIM1.5T position7','MRIM1.5T position8','MRIM1.5T position9','MRIM1.5T position10','Location','northwest')
saveas(fig,'MRIM2_15Tp6-10');
print(fig,'MRIM2_15Tp6-10','-dpng')
close(fig)

fig = figure;
axis([0 16 0 100])
hold on
    x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
    y = MRIM2_15T(:,12);
    p1 = plot(x,y,'Color',[1,0,1]);
    scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
    y = MRIM2_15T(:,13);
    p2 = plot(x,y,'Color',[0.8,0,0.8]);
    scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
    y = MRIM2_15T(:,14);
    p3 = plot(x,y,'Color',[0.6,0,0.6]);
    scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
    y = MRIM2_15T(:,15);
    p4 = plot(x,y,'Color',[0.4,0,0.4]);
    scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
    y = MRIM2_15T(:,16);
    p5 = plot(x,y,'Color',[0.2,0,0.2]);
    scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
hold off
    
xlabel('week');
ylabel('T2*(cal)');
legend([p1,p2,p3,p4,p5],'MRIM1.5T position11','MRIM1.5T position12','MRIM1.5T position13','MRIM1.5T position14','MRIM1.5T position15','Location','northwest')
saveas(fig,'MRIM2_15Tp11-15');
print(fig,'MRIM2_15Tp11-15','-dpng')
close(fig)

cd ..

%% MIRM1.5 sol3 plot
% cd sol3
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM3_15T(:,2);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM3_15T(:,3);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM3_15T(:,4);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM3_15T(:,5);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM3_15T(:,6);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM1.5T position1','MRIM1.5T position2','MRIM1.5T position3','MRIM1.5T position4','MRIM1.5T position5','Location','northwest')
% saveas(fig,'MRIM3_15Tp1-5');
% print(fig,'MRIM3_15Tp1-5','-dpng')
% close(fig)
% 
% 
% 
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM3_15T(:,7);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM3_15T(:,8);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM3_15T(:,9);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM3_15T(:,10);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM3_15T(:,11);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM1.5T position6','MRIM1.5T position7','MRIM1.5T position8','MRIM1.5T position9','MRIM1.5T position10','Location','northwest')
% saveas(fig,'MRIM3_15Tp6-10');
% print(fig,'MRIM3_15Tp6-10','-dpng')
% close(fig)
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM3_15T(:,12);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM3_15T(:,13);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM3_15T(:,14);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM3_15T(:,15);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM3_15T(:,16);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM1.5T position11','MRIM1.5T position12','MRIM1.5T position13','MRIM1.5T position14','MRIM1.5T position15','Location','northwest')
% saveas(fig,'MRIM3_15Tp11-15');
% print(fig,'MRIM3_15Tp11-15','-dpng')
% close(fig)
% 
% cd ..
% %% MIRM3T sol2 plot
% cd sol2
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM2_3T(:,2);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM2_3T(:,3);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM2_3T(:,4);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM2_3T(:,5);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM2_3T(:,6);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM3T position1','MRIM3T position2','MRIM3T position3','MRIM3T position4','MRIM3T position5','Location','northwest')
% saveas(fig,'MRIM2_3Tp1-5');
% print(fig,'MRIM2_3Tp1-5','-dpng')
% close(fig)
% 
% 
% 
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM2_3T(:,7);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM2_3T(:,8);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM2_3T(:,9);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM2_3T(:,10);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM2_3T(:,11);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM3T position6','MRIM3T position7','MRIM3T position8','MRIM3T position9','MRIM3T position10','Location','northwest')
% saveas(fig,'MRIM2_3Tp6-10');
% print(fig,'MRIM2_3Tp6-10','-dpng')
% close(fig)
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM2_3T(:,12);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM2_3T(:,13);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM2_3T(:,14);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM2_3T(:,15);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM2_3T(:,16);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM3T position11','MRIM3T position12','MRIM3T position13','MRIM3T position14','MRIM3T position15','Location','northwest')
% saveas(fig,'MRIM2_3Tp11-15');
% print(fig,'MRIM2_3Tp11-15','-dpng')
% close(fig)
% 
% cd ..
% 
% %% MIRM3T sol3 plot
% cd sol3
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM3_3T(:,2);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM3_3T(:,3);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM3_3T(:,4);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM3_3T(:,5);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM3_3T(:,6);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM3T position1','MRIM3T position2','MRIM3T position3','MRIM3T position4','MRIM3T position5','Location','northwest')
% saveas(fig,'MRIM3_3Tp1-5');
% print(fig,'MRIM3_3Tp1-5','-dpng')
% close(fig)
% 
% 
% 
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM3_3T(:,7);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM3_3T(:,8);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM3_3T(:,9);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM3_3T(:,10);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM3_3T(:,11);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM3T position6','MRIM3T position7','MRIM3T position8','MRIM3T position9','MRIM3T position10','Location','northwest')
% saveas(fig,'MRIM3_3Tp6-10');
% print(fig,'MRIM3_3Tp6-10','-dpng')
% close(fig)
% 
% fig = figure;
% axis([0 16 0 100])
% hold on
%     x = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
%     y = MRIM3_3T(:,12);
%     p1 = plot(x,y,'Color',[1,0,1]);
%     scatter(x,y,'MarkerEdgeColor',[1.0,0,1.0],'MarkerFaceColor',[1.0,0,1.0])
%     y = MRIM3_3T(:,13);
%     p2 = plot(x,y,'Color',[0.8,0,0.8]);
%     scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
%     y = MRIM3_3T(:,14);
%     p3 = plot(x,y,'Color',[0.6,0,0.6]);
%     scatter(x,y,'MarkerEdgeColor',[0.6,0,0.6],'MarkerFaceColor',[0.6,0,0.6])
%     y = MRIM3_3T(:,15);
%     p4 = plot(x,y,'Color',[0.4,0,0.4]);
%     scatter(x,y,'MarkerEdgeColor',[0.4,0,0.4],'MarkerFaceColor',[0.4,0,0.4])
%     y = MRIM3_3T(:,16);
%     p5 = plot(x,y,'Color',[0.2,0,0.2]);
%     scatter(x,y,'MarkerEdgeColor',[0.2,0,0.2],'MarkerFaceColor',[0.2,0,0.2])
% hold off
%     
% xlabel('week');
% ylabel('T2*(cal)');
% legend([p1,p2,p3,p4,p5],'MRIM3T position11','MRIM3T position12','MRIM3T position13','MRIM3T position14','MRIM3T position15','Location','northwest')
% saveas(fig,'MRIM3_3Tp11-15');
% print(fig,'MRIM3_3Tp11-15','-dpng')
% close(fig)
% 
% cd ..