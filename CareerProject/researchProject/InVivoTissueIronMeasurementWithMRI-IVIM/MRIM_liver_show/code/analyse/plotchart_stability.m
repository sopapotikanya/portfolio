function [norm_TB,stat_TB] = plotchart_stability(table,percent)
close all
% % clear
% cd('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PhantomNEW/Plotchart/');
% 
% percent = 5;
% 
% load T2s_MRIM15T_user1.mat
% table_user1 = T2s_table;
% load T2s_MRIM15T_user2.mat
% table_user2 = T2s_table;
% load T2s_MRIM15T_user3.mat
% table_user3 = T2s_table;
% table = ((table_user1+table_user2+table_user3)./3)';
%
% [norm_TB,stat_TB] = plotchart_stability(table,percent);



w = 1:15;
week = cat(2,(0:15)',(0:15)');
color_set = [0, .6, .9; ...
    .9, .7, 0; ...
    .6, .1, .8; ...
    .8, .2, .2; ...
    .1, .7, 0];


% stat_TB(initial, SD, max, min, range(5%), max(90%), min(90%), weekout)
stat_TB(:,1) =  (table(:,1)+table(:,2))./2;
stat_TB(:,2) = std(table,0,2);
norm_TB = zeros(size(table));
for i=1:size(table,1)
    for j=1:size(table,2)
        norm_TB(i,j) = (table(i,j) - stat_TB(i,1))/stat_TB(i,1);
        norm_TB_plot(i,j) = (table(i,j) - stat_TB(i,1))/stat_TB(i,1) + mod(i-1,5)+1;
    end
    stat_TB(i,3) = max(norm_TB(i,:));
    stat_TB(i,4) = min(norm_TB(i,:));
    stat_TB(i,5) = percent/100;
    stat_TB(i,6) = mod(i-1,5)+1 + stat_TB(i,5);
    stat_TB(i,7) = mod(i-1,5)+1 - stat_TB(i,5);
    weekout = find(abs(norm_TB(i,:)) > stat_TB(i,5),1);
    if isempty(weekout)
        stat_TB(i,8) = 16;
    else
        stat_TB(i,8) = find(abs(norm_TB(i,:)) > stat_TB(i,5),1);
    end
end




%% loadind 20%
load20 = figure;
hold on
for i=1:5
    a = ones(16,1).*((6-i) - stat_TB(i,5));
    a(:,2) = ones(16,1).*(stat_TB(i,5)*2);
    h = area(week,a);
    h(1).FaceColor = [1,1,1];
    h(2).FaceColor = [0.95,0.95,0.95];
end

for i=1:5
    p1 = plot(w,norm_TB_plot(i,:),'-');
    p2 = plot(w(1,1:stat_TB(i,8)-1),norm_TB_plot(i,1:stat_TB(i,8)-1),'o');
    if stat_TB(i,8) ~= 16
        p3 = plot(w(1,stat_TB(i,8):15),norm_TB_plot(i,stat_TB(i,8):15),'x');
        p3.MarkerSize = 8;
    p3.Color = color_set(i,:);
    p3.MarkerEdgeColor = color_set(i,:);
    p3.MarkerFaceColor = color_set(i,:);
    end
    p1.LineWidth = 1.5;
    p1.Color = color_set(i,:);
    p2.MarkerSize = 7;
    p2.Color = color_set(i,:);
    p2.MarkerEdgeColor = color_set(i,:);
    p2.MarkerFaceColor = color_set(i,:);

end
set(gca, ...
  'Box'         , 'on'     , ...    
  'YTick'       , 1:1:5      , ...
  'XTick'       , 0:1:15    );
xlabel('week');
ylabel('position');
title(['Loading 20% cutoff ' num2str(percent) '%'])
hold off
print(load20,['steability_' num2str(percent) 'percent_load20'],'-dpng')

%% loadind 10%
load10 = figure;
hold on
for i=1:5
    a = ones(16,1).*((6-i) - stat_TB(i,5));
    a(:,2) = ones(16,1).*(stat_TB(i,5)*2);
    h = area(week,a);
    h(1).FaceColor = [1,1,1];
    h(2).FaceColor = [0.95,0.95,0.95];
end
% plot(w,norm_TB_plot(6,:),'-o',w,norm_TB_plot(7,:),'-o',w,norm_TB_plot(8,:),'-o',w,norm_TB_plot(9,:),'-o',w,norm_TB_plot(10,:),'-o');
for i=1:5
    p1 = plot(w,norm_TB_plot(i+5,:),'-');
    if stat_TB(i+5,8) ~= 1
        p2 = plot(w(1,1:stat_TB(i+5,8)-1),norm_TB_plot(i+5,1:stat_TB(i+5,8)-1),'o');
        p2.MarkerSize = 7;
        p2.Color = color_set(i,:);
        p2.MarkerEdgeColor = color_set(i,:);
        p2.MarkerFaceColor = color_set(i,:);
    end
    if stat_TB(i,8) ~= 16
        p3 = plot(w(1,stat_TB(i+5,8):15),norm_TB_plot(i+5,stat_TB(i+5,8):15),'x');
        p3.MarkerSize = 8;
    p3.Color = color_set(i,:);
    p3.MarkerEdgeColor = color_set(i,:);
    p3.MarkerFaceColor = color_set(i,:);
    end
    p1.LineWidth = 1.5;
    p1.Color = color_set(i,:);

end
set(gca, ...
  'Box'         , 'on'     , ...    
  'YTickLabel'  , {'', '6', '7', '8', '9', '10'}      , ...
  'XTick'       , 0:1:15    );
xlabel('week');
ylabel('position');
title(['Loading 10% cutoff ' num2str(percent) '%'])
hold off
print(load10,['steability_' num2str(percent) 'percent_load10'],'-dpng')

%% loadind 5%
load5 = figure;
hold on
for i=1:5
    a = ones(16,1).*((6-i) - stat_TB(i,5));
    a(:,2) = ones(16,1).*(stat_TB(i,5)*2);
    h = area(week,a);
    h(1).FaceColor = [1,1,1];
    h(2).FaceColor = [0.95,0.95,0.95];
end
% plot(w,norm_TB_plot(11,:),'-o',w,norm_TB_plot(12,:),'-o',w,norm_TB_plot(13,:),'-o',w,norm_TB_plot(14,:),'-o',w,norm_TB_plot(15,:),'-o');
for i=1:5
    p1 = plot(w,norm_TB_plot(i+10,:),'-');
    if stat_TB(i+10,8) ~= 1
        p2 = plot(w(1,1:stat_TB(i+10,8)-1),norm_TB_plot(i+10,1:stat_TB(i+10,8)-1),'o');
        p2.MarkerSize = 7;
        p2.Color = color_set(i,:);
        p2.MarkerEdgeColor = color_set(i,:);
        p2.MarkerFaceColor = color_set(i,:);
    end
    if stat_TB(i+10,8) ~= 16
        p3 = plot(w(1,stat_TB(i+10,8):15),norm_TB_plot(i+10,stat_TB(i+10,8):15),'x');
        p3.MarkerSize = 8;
    p3.Color = color_set(i,:);
    p3.MarkerEdgeColor = color_set(i,:);
    p3.MarkerFaceColor = color_set(i,:);
    end
    p1.LineWidth = 1.5;
    p1.Color = color_set(i,:);
end
set(gca, ...
  'Box'         , 'on'     , ...    
  'YTickLabel'  , {'', '11', '12', '13', '14', '15'}      , ...
  'XTick'       , 0:1:15    );
xlabel('week');
ylabel('position');
title(['Loading 5% cutoff ' num2str(percent) '%'])
hold off
print(load5,['steability_' num2str(percent) 'percent_load5'],'-dpng')



