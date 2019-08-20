function polar_convert = locateMinFirst(polar_all)
% set minimun on first field 
polar1 = polar_all(:,1:2);
polar1(polar1(:,1) > polar1(:,2),:) = [polar1(polar1(:,1) > polar1(:,2),2),polar1(polar1(:,1) > polar1(:,2),1)];
polar2 = polar_all(:,3:4);
polar2(polar2(:,1) > polar2(:,2),:) = [polar2(polar2(:,1) > polar2(:,2),2),polar2(polar2(:,1) > polar2(:,2),1)];
polar3 = polar_all(:,5:6);
polar3(polar3(:,1) > polar3(:,2),:) = [polar3(polar3(:,1) > polar3(:,2),2),polar3(polar3(:,1) > polar3(:,2),1)];


polar_convert = cat(2,polar1,polar2,polar3);