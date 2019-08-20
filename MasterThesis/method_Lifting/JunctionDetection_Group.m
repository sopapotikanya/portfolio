function JunctionDetection_Group(fileName,DB_type,vp, LINES,img)

thLine = 5;
thCol = 5;
size_l = size(LINES,1);

%% line vector
% for l=1:size_l
%     g = vp_association(l,1);
% %     d(1) = pdist([VP(g,:);lines_sort(l,1:2)],'euclidean');
% %     d(2) = pdist([VP(g,:);lines_sort(l,3:4)],'euclidean');
%     d(1) = DistP2P(vp(g,:),LINES(l,1:2));
%     d(2) = DistP2P(vp(g,:),LINES(l,4:5));
% %     w = DistP2P(LINES(l,1:2),LINES(l,4:5));
%     if d(1) > d(2)
% %         LINES(l,9) = LINES(l,3)-LINES(l,1);
% %         LINES(l,10) = LINES(l,4)-LINES(l,2);
% %         LINES(l,11) = 1; % origin vector at lines_sort(l,1:2)
%         LINES(l,1:6) = LINES(l,1:6);
% %         LINES(l,16) = w;
%     else
% %         LINES(l,9) = LINES(l,1)-LINES(l,3);
% %         LINES(l,10) = LINES(l,2)-LINES(l,4);
% %         LINES(l,11) = 2; % origin vector at lines_sort(l,3:4)
%         l1 = LINES(l,4:6);
%         l2 = LINES(l,1:3);
%         LINES(l,1:3) = l1;
%         LINES(l,4:6) = l2;
% %         LINES(l,16) = w;
%     end
% end




%% find distance between point line && first group
% POINTS = cat(1,LINES(:,1:3),LINES(:,4:6));
n_line = size(LINES,1);
POINTS = cat(1,[LINES(:,12:13),ones(n_line,1)],[LINES(:,14:15),ones(n_line,1)]);
figure, imshow(img);
hold on
GT = zeros(size(LINES,1)*2,size(LINES,1)*3);
for i=1:size(POINTS,1)
    point = POINTS(i,:);
%     color = [rand, rand, rand];
    plot(point(1),point(2),'o','Color',[1 1 0], 'LineWidth',2);
    for j=1:size_l
        color = [rand, rand, rand];
        distLine(1) = DistP2P(point,[LINES(j,1:2),1]);
        distLine(2) = DistP2P(point,[LINES(j,3:4),1]);
        distLine(3) = shortDistP2L(point(1:3),[LINES(j,1:2),1],[LINES(j,3:4),1]);
        [MIN_dist, idx_dist] = min(distLine);
        if MIN_dist < 40%thLine
            GT(i,(idx_dist-1)*size_l+j) = 1;
            plot([LINES(j,1),LINES(j,3)],[LINES(j,2),LINES(j,4)],'-','Color',color, 'LineWidth',2);
        end
    end
end
hold off



%% find group from table GT
set_g = groupPoint(GT,size_l);

%% mean intersect point
fig_group = figure;
imshow(img);
hold on

for i=1:size(set_g,1)
%     imshow(img);
    color = [rand, rand, rand];
    g = set_g{i,1};
    intersect_g = [];
    incidence_g = [];
    group = [];
    for j=1:size(g,2)
        ind(1) = mod(g(j)+size_l-1,size_l)+1;
        type(1) = ceil(g(j)/size_l);
        line1 = LINES(ind(1),6:8);
        w(1) = LINES(ind(1),16);
        label(1) = LINES(ind(1),5);
        
        for k=1:j-1
            ind(2) = mod(g(k)+size_l-1,size_l)+1;
            type(2) = ceil(g(k)/size_l);
            line2 = LINES(ind(2),6:8);
            w(2) = LINES(ind(2),16);
            label(2) = LINES(ind(2),5);
            w(3) = w(1)+w(2);
            if label(1) ~= label(2)
                intersect_p = intersection(line1,line2);
                intersect_g = cat(1,intersect_g,[intersect_p,1,w,ind,type,label]);
                plot(intersect_p(1),intersect_p(2),'o','Color',color, 'LineWidth',2);
            elseif type(1) ~= 3 && type(2) ~= 3
                point1 =  LINES(ind(1),[(type(1)-1)*2+1:(type(1)-1)*2+2,1]);
                point2 =  LINES(ind(2),[(type(2)-1)*2+1:(type(2)-1)*2+2,1]);
                
                incidence_p = mean([point1;point2]);
                incidence_g = cat(1,incidence_g,[incidence_p,w,ind,type,label]);
                plot(incidence_p(1),incidence_p(2),'o','Color',color, 'LineWidth',2);
            elseif type(1) == 3 && type(2) == 3
                
            else
                [~, idx] = max(type);
                if idx == 1
                    pointl(1,:) = [LINES(ind(1),1:2),1];
                    pointl(2,:) = [LINES(ind(1),3:4),1];
                    point = LINES(ind(2),[(type(2)-1)*2+1:(type(2)-1)*2+2,1]);
                else
                    pointl(1,:) = [LINES(ind(1),1:2),1];
                    pointl(2,:) = [LINES(ind(1),3:4),1];
                    point = LINES(ind(1),[(type(1)-1)*2+1:(type(1)-1)*2+2,1]);
                end
                dist(1) = DistP2P(point,pointl(1,:));
                dist(2) = DistP2P(point,pointl(2,:));
                [MIN_dist, idx_dist ] = min(dist);
                if MIN_dist < thLine*2
                    incidence_p = mean([point;pointl(idx_dist,:)]);
                    incidence_g = cat(1,incidence_g,[incidence_p,w,ind,type,label]);
                    plot(incidence_p(1),incidence_p(2),'o','Color',color, 'LineWidth',2);
                else
                    incidence_p = point;
                    incidence_g = cat(1,incidence_g,[incidence_p,w,ind,type,label]);
                    plot(incidence_p(1),incidence_p(2),'o','Color',color, 'LineWidth',2);
                end
                
                test = 1;
                
            end
        end
%         plot([LINES(ind(1),1),LINES(ind(1),4)],[LINES(ind(1),2),LINES(ind(1),5)],'-','Color',[0.4,0.4,1], 'LineWidth',2);
        group = cat(1,group, [ind(1) type(1) label(1)]);
    end
    % find mean intersect point from group intersect point
    if size(intersect_g,1) + size(incidence_g,1) > 1
        if size(unique(group(:,3))) == 1
            intersect_point = mean(incidence_g(:,1:2),1);
        else
            [C, ia, ic] = unique(group(:,2:3),'rows');
            for u = 1:size(C,1)
                group(ic == u,4) = sum(ic == u);
            end
            sum_w = 0;
            sum_inter = [0,0];
            for j=1:size(intersect_g,1)
                w1 = group(group(:,1)==intersect_g(j,7),4);
                w2 = group(group(:,1)==intersect_g(j,8),4);
                weight = intersect_g(6)/(w1+w2);
                sum_w = sum_w + weight;
                sum_inter = sum_inter + intersect_g(j,1:2).*weight;
            end
            intersect_point = sum_inter./sum_w;
            % intersect_g(9:12) no use
        end
    else
        intersect = [intersect_g,incidence_g];
        intersect_point = intersect(1:2);
        plot(intersect_point(1),intersect_point(2),'o','Color',[0.5,0.5,0.5], 'LineWidth',2);
    end
    set_g{i,2} = intersect_point;
    intersect_point_all(i,:) = intersect_point;
    plot(intersect_point(1),intersect_point(2),'x','Color',[1,0,0], 'LineWidth',1);
    
end

hold off
mkdir(['../Results/JunctionDetection_Group/data/' DB_type '/' fileName '/']);
mkdir(['../Results/JunctionDetection_Group/image/' DB_type '/' fileName '/']);
saveas(fig_group,['../Results/JunctionDetection_Group/image/' DB_type '/' fileName '/Group.png']);




%% Vote
figure;
imshow(img);
hold on
V = zeros(size(set_g,1),6);
for i=1:size(set_g,1)
    color = [rand, rand, rand];
    g = set_g{i,1};
    intersect_point = set_g{i,2};
    plot(intersect_point(1),intersect_point(2),'o','Color',color, 'LineWidth',2);
    test=1;
    for j=1:size(g,2)
        ind = mod(g(j)+size_l-1,size_l)+1;
        type = ceil(g(j)/size_l);
        label = LINES(ind,5);
        width = LINES(ind,16);
        if type == 1
            V(i,label*2-1) = V(i,label*2-1) + width; 
        elseif type == 2
            V(i,label*2) = V(i,label*2) + width; 
        else
            distP2VP = DistP2P(intersect_point,vp(label,:));
            distL2VP1 = DistP2P([LINES(ind,1:2),1],vp(label,:));
            distL2VP2 = DistP2P([LINES(ind,3:4),1],vp(label,:));
            if distP2VP < distL2VP1 && distP2VP < distL2VP2
                V(i,label*2) = V(i,label*2) + width;
            elseif distP2VP > distL2VP1 && distP2VP > distL2VP2
                V(i,label*2-1) = V(i,label*2-1) + width;
            else
                distI2P(1) = DistP2P(intersect_point,[LINES(ind,1:2),1]);
                distI2P(2) = DistP2P(intersect_point,[LINES(ind,3:4),1]);
                if distL2VP1 < distL2VP2
                    widthP2VP = distI2P(1);
                    widthL2P = distI2P(2);
                else
                    widthP2VP = distI2P(2);
                    widthL2P = distI2P(1);
                end
                V(i,label*2-1) = V(i,label*2-1) + widthP2VP;
                V(i,label*2) = V(i,label*2) + widthL2P;
            end
            
            
            
            
        end
%         plot([LINES(ind,1),LINES(ind,4)],[LINES(ind,2),LINES(ind,5)],'-','Color',color, 'LineWidth',2);
    end
    
%     thVx = (V(i,1) + V(i,2))*0.2;
%     thVy = (V(i,3) + V(i,4))*0.2;
%     thVz = (V(i,5) + V(i,6))*0.2;
%     V(i,logical([V(i,1:2) < thVx,0,0,0,0])) = 0;
%     V(i,logical([0,0,V(i,3:4) < thVy,0,0])) = 0;
%     V(i,logical([0,0,0,0,V(i,5:6) < thVz])) = 0;
end

% hold off



load VotingType.mat
X_type = [16; 52; 61]; 
L_type = [6; 7;  10; 11; 18; 19; 21; 25; 34; 35; 37; 41];
T_type = [8;  12; 14; 15; 20; 29; 36; 45; 49; 50; 51; 53; 57];
W_type = [23; 26; 27; 38; 39; 42; 46;];
K_type = [28; 31; 39; 40; 55; 58];
Y_type = [22; 43];

dirac = (V ~= 0);
for  p=1:size(V,1)
    for a=1:size(VotingType,1)
        prod1 = prod(V(p,(VotingType(a,:)==1)));
        prod2 = prod(dirac(p,(VotingType(a,:)==1)));
        fincPA(p,a) = prod1*prod2;
    end
    [MAX, indType] = max(fincPA(p,:));
    if MAX ~= 0 && ~isinf(MAX)
        type(p,1) = indType;
    else
        type(p,1) = 0;
    end
end



% path_result = [ DB_type '/' fileName '/'];
path_result = ['../Results/JunctionDetection_Group/image/' DB_type '/' fileName '/'];
drawJunctionOn('X', type, intersect_point_all, VotingType, img, vp, V, path_result)
drawJunctionOn('L', type, intersect_point_all, VotingType, img, vp, V, path_result)
drawJunctionOn('T', type, intersect_point_all, VotingType, img, vp, V, path_result)
drawJunctionOn('W', type, intersect_point_all, VotingType, img, vp, V, path_result)
drawJunctionOn('K', type, intersect_point_all, VotingType, img, vp, V, path_result)
drawJunctionOn('Y', type, intersect_point_all, VotingType, img, vp, V, path_result)
drawJunctionOn('All', type, intersect_point_all, VotingType, img, vp, V, path_result)

path_result = ['../Results/JunctionDetection_Group/data/' DB_type '/' fileName '/'];
save([path_result 'junction.mat'],'set_g','intersect_point_all','V','type','vp');
