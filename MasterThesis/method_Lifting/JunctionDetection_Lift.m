function JunctionDetection_Lift(fileName,DB_type,VP, LINES,img)
% LINES = (x1,y1,x2,y2,group,A,B,C,Vx,Vy,origin vector,sort orig =>x1,y1,x2,y2,width)


thLine = 40;
thCol = 5;

edges = [];
for i=1:size(LINES,1)
    line1 = LINES(i,:);
    vp_ass1 = LINES(i,5);
    for j=i+1:size(LINES,1)
        line2 = LINES(j,:);
        vp_ass2 = LINES(j,5);
        distLine = shortDistBetweenLines([line1(12:13),1],[line1(14:15),1],[line2(12:13),1],[line2(14:15),1]);
        [MIN_dist, indMinLine] = min(distLine(1:8));
        if MIN_dist < thLine
            if vp_ass1 == vp_ass2
                % incidences
            else
                intersect = cross(line1(6:8),line2(6:8));
                intersect_point = [intersect(:,1)./intersect(:,3),intersect(:,2)./intersect(:,3)];
                edge = [i j 0 intersect_point(1) intersect_point(2)];
                edges = cat(1,edges,edge);
            end
        end
    end
end



figure, imshow(img); hold on
V = zeros(size(edges,1),6);
for i=1:size(edges,1)
    imshow(img)
    point_intersect = [edges(i,4:5),1];
    v = zeros(1,6);
    plot(point_intersect(1),point_intersect(2),'o','Color',[1 1 0], 'LineWidth',2);
    for k=1:size(LINES,1)
        label_target = LINES(k,5);
        line = LINES(k,6:8);
        width = LINES(k,16);
        point_target1 = [LINES(k,1:2),1];
        point_target2 = [LINES(k,3:4),1];
        collinear = abs(dot(line,point_intersect));
        

        
%         distP2P(1) = shortDistP2L(point_intersect,point_target1);
        distI2P = shortDistP2L(point_intersect,point_target1,point_target2);
        if isinf(distI2P)
            distI2P = min(DistP2P(point_target1,point_intersect),DistP2P(point_target2,point_intersect));
        end
        if collinear < thCol && min(distI2P) < thLine
            distP2VP = DistP2P(point_intersect,VP(label_target,:));
            distL2VP1 = DistP2P(point_target1,VP(label_target,:));
            distL2VP2 = DistP2P(point_target2,VP(label_target,:));
            if label_target == 2
               test=2; 
            end
            if distP2VP < distL2VP1 && distP2VP < distL2VP2
%                 V(i,label_target*2) = V(i,label_target*2) + width;
                v(1,label_target*2) = v(1,label_target*2) + width;
            elseif distP2VP > distL2VP1 && distP2VP > distL2VP2
%                 V(i,label_target*2-1) = V(i,label_target*2-1) + width;
                v(1,label_target*2-1) = v(1,label_target*2-1) + width;
            else
                distI2P(1) = DistP2P(point_intersect,point_target1);
                distI2P(2) = DistP2P(point_intersect,point_target2);
                if distL2VP1 < distL2VP2
                    widthP2VP = distI2P(1);
                    widthL2P = distI2P(2);
                else
                    widthP2VP = distI2P(2);
                    widthL2P = distI2P(1);
                end
%                 V(i,label_target*2-1) = V(i,label_target*2-1) + widthP2VP;
%                 V(i,label_target*2) = V(i,label_target*2) + widthL2P;
                v(1,label_target*2-1) = v(1,label_target*2-1) + widthP2VP;
                v(1,label_target*2) = v(1,label_target*2) + widthL2P;
                
            end
            
            plot([point_target1(1),point_target2(1)],[point_target1(2),point_target2(2)],'-','Color',[0 0 1], 'LineWidth',2);            
%             str = 'True';
%             V(i,:);
        else
%             plot([point_target1(1),point_target2(1)],[point_target1(2),point_target2(2)],'-','Color',[1 0 0], 'LineWidth',2);            
%             str = 'False';
%             V(i,:);
        end
    end
    V(i,:) = V(i,:) + v;
end

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
    if MAX ~= 0
        type(p,1) = indType;
    else
        type(p,1) = 0;
    end
end


% path_result = [ DB_type '/' fileName '/'];
folderName = '../../Results/roomlayout/JunctionDetection_Lift';
mkdir([ folderName '/data/' DB_type '/' fileName '/']);
mkdir([ folderName '/image/' DB_type '/' fileName '/']);
path_result1 = [ folderName '/image/' DB_type '/' fileName '/'];
drawJunctionOn('X', type, edges(:,4:5), VotingType, img, VP, V, path_result1)
drawJunctionOn('L', type, edges(:,4:5), VotingType, img, VP, V, path_result1)
drawJunctionOn('T', type, edges(:,4:5), VotingType, img, VP, V, path_result1)
drawJunctionOn('W', type, edges(:,4:5), VotingType, img, VP, V, path_result1)
drawJunctionOn('K', type, edges(:,4:5), VotingType, img, VP, V, path_result1)
drawJunctionOn('Y', type, edges(:,4:5), VotingType, img, VP, V, path_result1)
drawJunctionOn('All', type, edges(:,4:5), VotingType, img, VP, V, path_result1)
path_result2 = [ folderName '/data/' DB_type '/' fileName '/'];
save([path_result2 'junction.mat'],'edges','V','type','VP');