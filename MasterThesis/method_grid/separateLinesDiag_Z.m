function [polar_DiagL_All, polar_DiagB_All, polar_DiagR_All] = separateLinesDiag_Z(polar_all,lineZ_ABC)
% for polarZ 

% intersect_All = [];
polar_DiagL_All = [];
polar_DiagR_All = [];
polar_DiagB_All = [];

% figure; hold on
for i=1:size(polar_all,1)
    p1 = [polar_all(i,1:2:4),1];
%     p2 = [polar_all(i,2:2:4),1];
%     line_ABC = LineABC(p1',p2');
%     line_ABC = polar_all(i,7:9)';
    
    r = sum(lineZ_ABC.*p1');
    if r > 1
        polar_DiagL = polar_all(i,:);
        polar_DiagL_All = cat(1,polar_DiagL_All,polar_DiagL);
    elseif r < -1
        polar_DiagR = polar_all(i,:);
        polar_DiagR_All = cat(1,polar_DiagR_All,polar_DiagR);
    else
        polar_DiagB = polar_all(i,:);
        polar_DiagB_All = cat(1,polar_DiagB_All,polar_DiagB);
    end
    
%     intersect = cross(line_ABC,lineZ_ABC);
%     intersect = intersect./intersect(3);
%     intersect_All = cat(1,intersect_All,intersect');
    
%     if p1(1) < intersect(1) && p2(1) < intersect(1)
% %         plot(p1(1),p1(2),'ob');
% %         plot(p2(1),p2(2),'ob');
%         polar_DiagL = polar_all(i,:);
%         polar_DiagL_All = cat(1,polar_DiagL_All,polar_DiagL);
%     elseif p1(1) > intersect(1) && p2(1) > intersect(1)
% %         plot(p1(1),p1(2),'og');
% %         plot(p2(1),p2(2),'og');
%         polar_DiagR = polar_all(i,:);
%         polar_DiagR_All = cat(1,polar_DiagR_All,polar_DiagR);
%     else
% %         plot(p1(1),p1(2),'or');
% %         plot(p2(1),p2(2),'or');
%         
%         if p1(1) < intersect(1)
%             polar_DiagL = [p1(1), intersect(1), p1(2), intersect(2), polar_all(i,5:9)];
%             polar_DiagR = [intersect(1), p2(1), intersect(2), p2(2), polar_all(i,5:9)];
%         else
%             polar_DiagR = [p1(1), intersect(1), p1(2), intersect(2), polar_all(i,5:9)];
%             polar_DiagL = [intersect(1), p2(1), intersect(2), p2(2), polar_all(i,5:9)];
%         end
%         polar_DiagL_All = cat(1,polar_DiagL_All,polar_DiagL);
%         polar_DiagR_All = cat(1,polar_DiagR_All,polar_DiagR);
%     end
    
%     plot(polar_all(i,1:2)',polar_all(i,3:4)','-k')
%     plot(intersect(1,1),intersect(2,1),'xk');
end

% hold off
