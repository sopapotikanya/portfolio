function [H1,logTB,logTB_norm] = scoreLayout(setZ_left_all,setV_left_all)
minH = floor(min([setZ_left_all(:,1);setV_left_all(:,1)]));
maxH = floor(max([setZ_left_all(:,2);setV_left_all(:,2)]));
logTB = (minH:maxH)';
for i=1:size(logTB,1)
    center_left = logTB(i,1);
    
    [Z_left,Z_right] = separateLines(setZ_left_all,center_left);
    [V_left,V_right] = separateLines(setV_left_all,center_left);
    
%     scoreZ_left = sum(Z_left(:,2) - Z_left(:,1));
%     scoreZ_right = sum(Z_right(:,1) - center_left);
%     scoreV_left = sum(V_left(:,2) - V_left(:,1));
%     scoreV_right = sum(V_right(:,1) - center_left);
    scoreZ_left = sum(Z_left(:,2) - Z_left(:,1));
    scoreZ_right = sum(Z_right(:,2) - Z_right(:,1));
    scoreV_left = sum(V_left(:,2) - V_left(:,1));
    scoreV_right = sum(V_right(:,2) - V_right(:,1));
    
    error = [scoreV_left, scoreZ_right];
    score = [scoreZ_left, scoreV_right];
    logTB(i,2:3) = score;
    logTB(i,4:5) = error;
end

logTB_norm = [logTB(:,1) , logTB(:,2:5)./max(logTB(:,2:5))];
% [~,idx] = max(sum(logTB_norm(:,2:3),2)-sum(logTB_norm(:,4:5),2));
[~,idx] = min(abs((logTB_norm(:,2) - logTB_norm(:,3)) + (logTB_norm(:,4) - logTB_norm(:,5))));

H1 = logTB_norm(idx,1);

% test1(:,1) = logTB_norm1(:,1);
% test1(:,2) = sum(logTB_norm1(:,2:3),2);
% test1(:,3) = sum(logTB_norm1(:,4:5),2);
% test1(:,4) = test1(:,2) - test1(:,3);
% 
% test1(:,5) = logTB_norm1(:,2) - logTB_norm1(:,3);
% test1(:,6) = logTB_norm1(:,4) - logTB_norm1(:,5);
% test1(:,7) = test1(:,5) + test1(:,6);
% 
% test2(:,1) = logTB_norm2(:,1);
% test2(:,2) = sum(logTB_norm2(:,2:3),2);
% test2(:,3) = sum(logTB_norm2(:,4:5),2);
% test2(:,4) = test2(:,2) - test2(:,3);
% 
% test2(:,5) = logTB_norm2(:,2) - logTB_norm2(:,3);
% test2(:,6) = logTB_norm2(:,4) - logTB_norm2(:,5);
% test2(:,7) = test2(:,5) + test2(:,6);