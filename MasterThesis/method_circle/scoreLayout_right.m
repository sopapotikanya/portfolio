function [H1,logTB,logTB_norm] = scoreLayout_right(setZ_right_all,setV_right_all)
minH = ceil(min([setZ_right_all(:,1);setV_right_all(:,1)]));
maxH = ceil(max([setZ_right_all(:,2);setV_right_all(:,2)]));
logTB = (minH:maxH)';
for i=1:size(logTB,1)
    center_right = logTB(i,1);
    
    [Z_left,Z_right] = separateLines(setZ_right_all,center_right);
    [V_left,V_right] = separateLines(setV_right_all,center_right);
    
    scoreZ_left = sum(Z_left(:,2) - Z_left(:,1));
    scoreZ_right = sum(Z_right(:,2) - Z_right(:,1));
    scoreV_left = sum(V_left(:,2) - V_left(:,1));
    scoreV_right = sum(V_right(:,2) - V_right(:,1));
    
    score = [scoreV_left, scoreZ_right];
    error = [scoreZ_left, scoreV_right];
    logTB(i,2:3) = score;
    logTB(i,4:5) = error;
end

logTB_norm = [logTB(:,1) , logTB(:,2:5)./max(logTB(:,2:5))];
% [~,idx] = max(sum(logTB_norm(:,2:3),2)-sum(logTB_norm(:,4:5),2));
[~,idx] = min(abs((logTB_norm(:,2) - logTB_norm(:,3)) + (logTB_norm(:,4) - logTB_norm(:,5))));
H1 = logTB_norm(idx,1);