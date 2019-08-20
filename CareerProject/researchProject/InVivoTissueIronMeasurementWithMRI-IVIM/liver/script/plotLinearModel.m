
cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Doc/chart/')
mainpath = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Doc/';

filename = 'phantom.xlsx';


for p=1:15
% sheet = 'set1';
sheet = ['set' num2str(floor((p-1)/5+1))];
xls = xlsread([mainpath filename],sheet);

chartname = ['norm_position ' num2str(p)];
x = xls(5:19,1);

y = xls(5:19,5+12*(mod(p-1,5)));
fig = figure;
scatter(x,y,'MarkerEdgeColor',[0,0.8,0.8],'MarkerFaceColor',[0,0.8,0.8])
hold on
plot(x,y,':','Color',[0,0.8,0.8])
fitvars_MRIM3T = polyfit(x,y,1);
f_MRIM3T = polyval(fitvars_MRIM3T,x);
p1 = plot(x,f_MRIM3T,'Color',[0,0.8,0.8])
% hold off


y = xls(5:19,9+12*(mod(p-1,5)));

scatter(x,y,'MarkerEdgeColor',[0.8,0.8,0],'MarkerFaceColor',[0.8,0.8,0])
% hold on
plot(x,y,':','Color',[0.8,0.8,0])
fitvars_MRIM15T = polyfit(x,y,1);
f_MRIM15T = polyval(fitvars_MRIM15T,x);
p2 = plot(x,f_MRIM15T,'Color',[0.8,0.8,0])
% hold off


y = xls(5:19,13+12*(mod(p-1,5)));

scatter(x,y,'MarkerEdgeColor',[0.8,0,0.8],'MarkerFaceColor',[0.8,0,0.8])
% hold on
plot(x,y,':','Color',[0.8,0,0.8])
fitvars_CMRT15T = polyfit(x,y,1);
f_CMRT15T = polyval(fitvars_CMRT15T,x);
p3 = plot(x,f_CMRT15T,'Color',[0.8,0,0.8])
hold off

axis([0 16 -3 5])
dim = [.6 .6 .3 .3];
str = {sprintf('position\t %i',p);sprintf('cmrtool 1.5T:\t %f',fitvars_CMRT15T(1));sprintf('MRIM 1.5T:\t %f',fitvars_MRIM15T(1));sprintf('MRIM 3T:\t %f',fitvars_MRIM3T(1));};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12,'Margin',6);
       

%     title(sprintf('position\t %i',p));
    xlabel('Time (week)');
    ylabel('T2*(norm)');
    legend([p1,p2,p3],'MRIM3T','MRIM15T','CMRT15T','Location','northwest')
    saveas(fig,chartname);
    print(fig,chartname,'-dpng')
    close(fig)


end



