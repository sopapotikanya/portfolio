function [setH_left_all,setH_right_all] = separateLines(polar_all,center)


setH_left = polar_all(polar_all(:,1)<center & polar_all(:,2)<center,:);
setH_between = polar_all(polar_all(:,1)<center & polar_all(:,2)>center,:);
setH_right = polar_all(polar_all(:,1)>center & polar_all(:,2)>center,:);
setH_between_left = [setH_between(:,1),center*ones(size(setH_between,1),1)];
setH_between_right = [center*ones(size(setH_between,1),1),setH_between(:,2)];
setH_left_all = cat(1,setH_left,setH_between_left);
setH_right_all = cat(1,setH_right,setH_between_right);

