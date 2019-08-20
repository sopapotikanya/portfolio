function [H1,H2,V1,V2] = lineLayout(centerHRelative,polarHRelative2,centerVRelative,polarVRelative2,polarZRelative,polarZRelative2)
% layout
H1 = []; H2 = []; V1 = []; V2 = [];
logTB1 = []; logTB2 = []; logTB3 = []; logTB4 = [];
logTB_norm1 = []; logTB_norm2 = []; logTB_norm3 = []; logTB_norm4 = [];

[setV_left_all,setV_right_all] = separateLines(polarVRelative2(:,1:2),centerHRelative);
[setZ_left_all,setZ_right_all] = separateLines(polarZRelative2(:,1:2),centerHRelative);

if ~(isempty(setZ_left_all) && isempty(setV_left_all))
    [H1,logTB1,logTB_norm1]  = scoreLayout(setZ_left_all,setV_left_all);
end
if ~(isempty(setZ_right_all) && isempty(setV_right_all))
    [H2,logTB2,logTB_norm2] = scoreLayout_right(setZ_right_all,setV_right_all);
end

[setH_left_all,setH_right_all] = separateLines(polarHRelative2(:,3:4),centerVRelative);
[setZ_left_all,setZ_right_all] = separateLines(polarZRelative2(:,3:4),centerVRelative);
if ~(isempty(setZ_left_all) && isempty(setH_left_all))
    [V1,logTB3,logTB_norm3]  = scoreLayout(setZ_left_all,setH_left_all);
end
if ~(isempty(setZ_right_all) && isempty(setH_right_all))
    [V2,logTB4,logTB_norm4] = scoreLayout_right(setZ_right_all,setH_right_all);
end

% disp(['H1 = ' num2str(H1)])
% disp(['H2 = ' num2str(H2)])
% disp(['V1 = ' num2str(V1)])
% disp(['V2 = ' num2str(V2)])

