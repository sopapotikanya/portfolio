function [polar_LT_All, polar_LB_All, polar_RT_All, polar_RB_All, ...
    polar_throughH_L_All, polar_throughH_R_All, polar_throughV_T_All, polar_throughV_B_All ...
    ] = separateLinesLRBT(polar_all,separate_point)


[polar_left_All, polar_right_All, polar_throughV_All] = separateLinesLR(polar_all,separate_point);

[polar_LT_All, polar_LB_All, polar_throughH_L_All] = separateLinesTB(polar_left_All,separate_point);
[polar_RT_All, polar_RB_All, polar_throughH_R_All] = separateLinesTB(polar_right_All,separate_point);
[polar_throughV_T_All, polar_throughV_B_All, polar_throughHV_All] = separateLinesTB(polar_throughV_All,separate_point);
% figure; hold on
% for i=1:size(polar_LT_All,1)
%     plot(polar_LT_All(i,1:2)',polar_LT_All(i,3:4)','-r')
% end
% for i=1:size(polar_LB_All,1)
%     plot(polar_LB_All(i,1:2)',polar_LB_All(i,3:4)','-g')
% end
% for i=1:size(polar_RT_All,1)
%     plot(polar_RT_All(i,1:2)',polar_RT_All(i,3:4)','-b')
% end
% for i=1:size(polar_RB_All,1)
%     plot(polar_RB_All(i,1:2)',polar_RB_All(i,3:4)','-y')
% end
% hold off