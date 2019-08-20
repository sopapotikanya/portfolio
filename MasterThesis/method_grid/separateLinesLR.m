function [polar_left_All, polar_right_All, polar_throughV_All] = separateLinesLR(polar_all,separate_point)

lineSep_ABC = LineABC([separate_point(1); 0; 1],[separate_point(1); 1; 1]);

intersect_All = [];
polar_left_All = [];
polar_right_All = [];
polar_throughV_All = [];
% figure; hold on
for i=1:size(polar_all,1)
    p1 = [polar_all(i,1:2:4),1];
    p2 = [polar_all(i,2:2:4),1];
%     line_ABC = LineABC(p1',p2');
    line_ABC = polar_all(i,7:9)';
    
    intersect = cross(line_ABC,lineSep_ABC);
    intersect = intersect./intersect(3);
    intersect_All = cat(1,intersect_All,intersect');
    
    
    eq1 = abs(separate_point(1) - p1(1)) < 1;
    eq2 = abs(separate_point(1) - p2(1)) < 1;
    % Through
    if eq1 && eq2
%     if p1(1) == separate_point(1) && p2(1) == separate_point(1)
        polar_through = polar_all(i,:);
        polar_throughV_All = cat(1,polar_throughV_All,polar_through);
    % Left
    elseif (p1(1) < separate_point(1) || eq1) && (p2(1) < separate_point(1) || eq2)
%         plot(p1(1),p1(2),'ob');
%         plot(p2(1),p2(2),'ob');
        polar_left = polar_all(i,:);
        polar_left_All = cat(1,polar_left_All,polar_left);
        
    % Right
    elseif (p1(1) > separate_point(1) || eq1) && (p2(1) > separate_point(1) || eq2)
%         plot(p1(1),p1(2),'og');
%         plot(p2(1),p2(2),'og');
        polar_right = polar_all(i,:);
        polar_right_All = cat(1,polar_right_All,polar_right);
        
    
    % Between separate
    else
%         plot(p1(1),p1(2),'or');
%         plot(p2(1),p2(2),'or');
        
        if p1(1) < separate_point(1)
            polar_left = [p1(1), intersect(1), p1(2), intersect(2), polar_all(i,5:9)];
            polar_right = [intersect(1), p2(1), intersect(2), p2(2), polar_all(i,5:9)];
        else
            polar_right = [p1(1), intersect(1), p1(2), intersect(2), polar_all(i,5:9)];
            polar_left = [intersect(1), p2(1), intersect(2), p2(2), polar_all(i,5:9)];
        end
        polar_left_All = cat(1,polar_left_All,polar_left);
        polar_right_All = cat(1,polar_right_All,polar_right);
    end
    
%     plot(polar_all(i,1:2)',polar_all(i,3:4)','-k')
%     plot(intersect(1,1),intersect(2,1),'xk');
end
% hold off