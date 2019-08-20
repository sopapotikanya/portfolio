function [VP, lines_out] = getMainVP(lines)
% find vanishing point from set of edge lines
%   input : lines(x1,y1,x2,y2,group)
%   output: VP(x,y)
%           lines_sort(x1,y1,x2,y2,group,A,B,C,Vx,Vy,origin vector,sort orig =>x1,y1,x2,y2,width)

lines_sort = sortrows(lines,5);
% lines_sort(:,5) = lines_sort(:,5)+1; %start group at 1 (before start is 0)

%% extract outlier line
g_theshold = prctile(lines_sort(:,5)+1,90);

%% find vanishing point of each group (VP)
g=1;
start_g(1)=1;
intersect_point_g = [];
intersect_points = [];
for l=1:size(lines,1)
    
    % stop when at outlier line
    if lines_sort(l,5)>g_theshold
        lines_sort(l:size(lines,1),:)=[];
        break
    end
    
    % equation of each line
    lines_sort(l,6:8) = cross([lines_sort(l,1:2),1],[lines_sort(l,3:4),1]);
    
    % when change group
    if g ~= lines_sort(l,5) 
        VP(g,:) = mean(intersect_point_g);
        
        % clear parameter
        g = lines_sort(l,5);
        start_g(g) = l;
        intersect_point_g = [];
    end
    
    % intersection line
    line1 = lines_sort(l,6:8);
    for i=start_g(g):l
        line2 = lines_sort(i,6:8);
        intersect = cross(line1,line2);
        intersect_point = [intersect(:,1)./intersect(:,3),intersect(:,2)./intersect(:,3)];
        if ~isnan(intersect_point(1)) && ~isnan(intersect_point(2))
            intersect_point_g = cat(1,intersect_point_g,intersect_point);
        end
    end
end
VP(g,:) = mean(intersect_point_g);

%% line vector
for l=1:size(lines_sort,1)
    g = lines_sort(l,5);
%     d(1) = pdist([VP(g,:);lines_sort(l,1:2)],'euclidean');
%     d(2) = pdist([VP(g,:);lines_sort(l,3:4)],'euclidean');
    d(1) = DistP2P(VP(g,:),lines_sort(l,1:2));
    d(2) = DistP2P(VP(g,:),lines_sort(l,3:4));
    w = DistP2P(lines_sort(l,1:2),lines_sort(l,3:4));
    if d(1) > d(2)
        lines_sort(l,9) = lines_sort(l,3)-lines_sort(l,1);
        lines_sort(l,10) = lines_sort(l,4)-lines_sort(l,2);
        lines_sort(l,11) = 1; % origin vector at lines_sort(l,1:2)
        lines_sort(l,12:15) = lines_sort(l,1:4);
        lines_sort(l,16) = w;
    else
        lines_sort(l,9) = lines_sort(l,1)-lines_sort(l,3);
        lines_sort(l,10) = lines_sort(l,2)-lines_sort(l,4);
        lines_sort(l,11) = 2; % origin vector at lines_sort(l,3:4)
        lines_sort(l,12:13) = lines_sort(l,3:4);
        lines_sort(l,14:15) = lines_sort(l,1:2);
        lines_sort(l,16) = w;
    end
end

%% VP vector & change group when not main VP
M = zeros(size(VP));
for i=1:size(start_g,2)
    if i ~= size(start_g,2)
        M(i,:) = mean(lines_sort(start_g(i):start_g(i+1)-1,9:10));
    else
        M(i,:) = mean(lines_sort(start_g(i):size(lines_sort,1)-1,9:10));
    end
    
    if i>3
        VP_dist(1) = pdist([M(i,:);M(1,:)],'euclidean');
        VP_dist(2) = pdist([M(i,:);M(2,:)],'euclidean');
        VP_dist(3) = pdist([M(i,:);M(3,:)],'euclidean');
        VP_dist(1) = DistP2P(M(i,:),M(1,:));
        VP_dist(2) = DistP2P(M(i,:),M(2,:));
        VP_dist(3) = DistP2P(M(i,:),M(3,:));
        [~, new_group] = min(VP_dist);
        
        
        if i ~= size(start_g,2)
%             size_main = start_g(new_group+1)-start_g(new_group);
%             size_local = start_g(i+1)-start_g(i);
            size_main = sum(lines_sort(lines_sort(:,5)==new_group,16));
            size_local = sum(lines_sort(lines_sort(:,5)==i,16));
            VP_new(new_group,:) = (VP_new(new_group,:)*size_main + VP(i,:)*size_local)/(size_main + size_local);
        else
%             size_main = start_g(new_group+1)-start_g(new_group);
%             size_local = size(lines_sort,1)-start_g(i);
            size_main = sum(lines_sort(lines_sort(:,5)==new_group,16));
            size_local = sum(lines_sort(lines_sort(:,5)==i,16));
            VP_new(new_group,:) = (VP_new(new_group,:)*size_main + VP(i,:)*size_local)/(size_main + size_local);
        end
        lines_sort(lines_sort(:,5)==i,5) = new_group;
    else
        VP_new(i,:) = VP(i,:);
    end
end



[MAX idx]=max(abs(VP(1:3,2)));
if idx ~= 2
    for i=1:size(lines_sort,1)
        if lines_sort(i,5)==2
            lines_sort(i,5) = idx;
        elseif lines_sort(i,5)==idx 
            lines_sort(i,5) = 2;
        end
    end
    VP_sort = VP_new;
    VP_sort(2,:) = VP_new(idx,:);
    VP_sort(idx,:) = VP_new(2,:);
    VP = VP_sort;
end
lines_out = sortrows(lines_sort,5);


end
