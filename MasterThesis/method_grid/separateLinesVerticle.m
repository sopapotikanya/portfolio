function [polar_left_all, polar_right_all] = separateLinesVerticle(polar_all,centerHRelative)
% Input : polarRelative = [x1,x2,y1,y2,z1,z2];

%% let right
left = (polar_all(:,1) < centerHRelative) & (polar_all(:,2) < centerHRelative);
between = (polar_all(:,1) < centerHRelative) & (polar_all(:,2) > centerHRelative);
right = (polar_all(:,1) > centerHRelative) & (polar_all(:,2) > centerHRelative);

polar_left = polar_all(left,:);
polar_right = polar_all(right,:);
polar_between = polar_all(between,:);
polar_between_left  = [polar_between(:,1),centerHRelative*ones(size(polar_between,1),1),polar_between(:,3:6)];
polar_between_right = [centerHRelative*ones(size(polar_between,1),1),polar_between(:,2),polar_between(:,3:6)];

polar_left_all = cat(1,polar_left,polar_between_left);
polar_right_all = cat(1,polar_right,polar_between_right);
