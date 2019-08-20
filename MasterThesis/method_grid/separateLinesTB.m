function [polar_top_All, polar_bottom_All, polar_throughH_All] = separateLinesTB(polar_all,separate_point)

lineSep_ABC = LineABC([0; separate_point(2); 1],[1; separate_point(2); 1]);


intersect_All = [];
polar_top_All = [];
polar_bottom_All = [];
polar_throughH_All = [];
% figure; hold on
for i=1:size(polar_all,1)
    p1 = [polar_all(i,1:2:4),1];
    p2 = [polar_all(i,2:2:4),1];
%     line_ABC = LineABC(p1',p2');
    line_ABC = polar_all(i,7:9)';
    
    intersect = cross(line_ABC,lineSep_ABC);
    intersect = intersect./intersect(3);
    intersect_All = cat(1,intersect_All,intersect');
    
    eq1 = abs(separate_point(2) - p1(2)) < 1;
    eq2 = abs(separate_point(2) - p2(2)) < 1;
        % Through
    if eq1 && eq2
%     if p1(2) == separate_point(2) && p2(2) == separate_point(2)
        polar_through = polar_all(i,:);
        polar_throughH_All = cat(1,polar_throughH_All,polar_through);
    % Bottom
    elseif (p1(2) < separate_point(2) || eq1) && (p2(2) < separate_point(2) || eq2)
%         plot(p1(1),p1(2),'ob');
%         plot(p2(1),p2(2),'ob');
        polar_bottom = polar_all(i,:);
        polar_bottom_All = cat(1,polar_bottom_All,polar_bottom);
        
    % Top
    elseif (p1(2) > separate_point(2) || eq1) && (p2(2) > separate_point(2) || eq2)
%         plot(p1(1),p1(2),'og');
%         plot(p2(1),p2(2),'og');
        polar_top = polar_all(i,:);
        polar_top_All = cat(1,polar_top_All,polar_top);
    

        
    % Between
    else
%         plot(p1(1),p1(2),'or');
%         plot(p2(1),p2(2),'or');
        
        if p1(2) < separate_point(2)
            polar_bottom = [p1(1), intersect(1), p1(2), intersect(2), polar_all(i,5:9)];
            polar_top = [intersect(1), p2(1), intersect(2), p2(2), polar_all(i,5:9)];
        else
            polar_top = [p1(1), intersect(1), p1(2), intersect(2), polar_all(i,5:9)];
            polar_bottom = [intersect(1), p2(1), intersect(2), p2(2), polar_all(i,5:9)];
        end
        polar_bottom_All = cat(1,polar_bottom_All,polar_bottom);
        polar_top_All = cat(1,polar_top_All,polar_top);
    end
    
%     plot(polar_all(i,1:2)',polar_all(i,3:4)','-k')
%     plot(intersect(1,1),intersect(2,1),'xk');
end
% hold off