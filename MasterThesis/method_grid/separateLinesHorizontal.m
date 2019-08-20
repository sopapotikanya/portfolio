function [polar_bottom_all, polar_top_all] = separateLinesHorizontal(polar_all,centerVRelative)
% Input : polarRelative = [x1,x2,y1,y2,z1,z2];

%% Top bottom
bottom = (polar_all(:,3) < centerVRelative) & (polar_all(:,4) < centerVRelative);
between = (polar_all(:,3) < centerVRelative) & (polar_all(:,4) > centerVRelative);
top = (polar_all(:,3) > centerVRelative) & (polar_all(:,4) > centerVRelative);

polar_bottom = polar_all(bottom,:);
polar_top = polar_all(top,:);
polar_between = polar_all(between,:);
polar_between_bottom  = [polar_between(:,1:2),polar_between(:,3),centerVRelative*ones(size(polar_between,1),1),polar_between(:,5:6)];
polar_between_top = [polar_between(:,1:2),centerVRelative*ones(size(polar_between,1),1),polar_between(:,4),polar_between(:,5:6)];

polar_bottom_all = cat(1,polar_bottom,polar_between_bottom);
polar_top_all = cat(1,polar_top,polar_between_top);