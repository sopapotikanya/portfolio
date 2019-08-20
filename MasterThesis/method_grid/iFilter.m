function [width_g1_H, width_g1_V, width_g1_Z, ...
    width_g2_H, width_g2_V, width_g2_Z, ...
    width_g3_H, width_g3_V, width_g3_Z, ...
    width_g4_H, width_g4_V, width_g4_Z, ...
    width_cross_12, width_cross_13, width_cross_14, width_cross_23, width_cross_34 ...
    ] = iFilter(selPointT,selPointB,separate_point,polarH_L,polarV_L,polarZ_L,fileName,isShow)

% I = after split which I filter
% L = Left
% R = Right
% M = Middle
% C = Cross
% CLR = Cross between Left and Right
% \
%  \ 4
%   +--
% 1 | 3
%   +--
%  / 2
% /

[polarH_I_L, polarH_I_R, polarH_I_CLR] = separateLinesLR(polarH_L,selPointB);
[polarV_I_L, polarV_I_R, polarV_I_CLR] = separateLinesLR(polarV_L,selPointB);
[polarZ_I_L, polarZ_I_R, polarZ_I_CLR] = separateLinesLR(polarZ_L,selPointB);

[polarH_I_L_T, polarH_I_L_MB, polarH_I_L_CTM] = separateLinesTB(polarH_I_L,selPointT);
[polarV_I_L_T, polarV_I_L_MB, polarV_I_L_CTM] = separateLinesTB(polarV_I_L,selPointT);
[polarZ_I_L_T, polarZ_I_L_MB, polarZ_I_L_CTM] = separateLinesTB(polarZ_I_L,selPointT);

[polarH_I_L_M, polarH_I_L_B, polarH_I_L_CMB] = separateLinesTB(polarH_I_L_MB,selPointB);
[polarV_I_L_M, polarV_I_L_B, polarV_I_L_CMB] = separateLinesTB(polarV_I_L_MB,selPointB);
[polarZ_I_L_M, polarZ_I_L_B, polarZ_I_L_CMB] = separateLinesTB(polarZ_I_L_MB,selPointB);

[polarH_I_R_T, polarH_I_R_MB, polarH_I_R_CTM] = separateLinesTB(polarH_I_R,selPointT);
[polarV_I_R_T, polarV_I_R_MB, polarV_I_R_CTM] = separateLinesTB(polarV_I_R,selPointT);
[polarZ_I_R_T, polarZ_I_R_MB, polarZ_I_R_CTM] = separateLinesTB(polarZ_I_R,selPointT);

[polarH_I_R_M, polarH_I_R_B, polarH_I_R_CMB] = separateLinesTB(polarH_I_R_MB,selPointB);
[polarV_I_R_M, polarV_I_R_B, polarV_I_R_CMB] = separateLinesTB(polarV_I_R_MB,selPointB);
[polarZ_I_R_M, polarZ_I_R_B, polarZ_I_R_CMB] = separateLinesTB(polarZ_I_R_MB,selPointB);

%%
centerHRelative = separate_point(1,1);
centerVRelative = separate_point(1,2);
lineZ_ABC = LineABC([centerHRelative,centerVRelative,1]',selPointB');
[polarH_I_L_B_Diag1, polarH_I_L_B_Diag2] = separateLinesDiag_H(polarH_I_L_B,lineZ_ABC);
[polarV_I_L_B_Diag1, polarV_I_L_B_Diag2] = separateLinesDiag_V(polarV_I_L_B,lineZ_ABC);
[polarZ_I_L_B_Diag1, polarZ_I_L_B_Diag3, polarZ_I_L_B_Diag2] = separateLinesDiag_Z(polarZ_I_L_B,lineZ_ABC);


lineZ_ABC = LineABC([centerHRelative,centerVRelative,1]',selPointT');
[polarH_I_L_T_Diag1, polarH_I_L_T_Diag2] = separateLinesDiag_H(polarH_I_L_T,lineZ_ABC);
[polarV_I_L_T_Diag1, polarV_I_L_T_Diag2] = separateLinesDiag_V(polarV_I_L_T,lineZ_ABC);
[polarZ_I_L_T_Diag1, polarZ_I_L_T_Diag3, polarZ_I_L_T_Diag2] = separateLinesDiag_Z(polarZ_I_L_T,lineZ_ABC);

%%
g1_H = cat(1,polarH_I_L_T_Diag1,polarH_I_L_CTM,polarH_I_L_M,polarH_I_L_CMB,polarH_I_L_B_Diag2);
g2_H = cat(1,polarH_I_R_B,polarH_I_L_B_Diag1);
g3_H = polarH_I_R_M;
g4_H = cat(1,polarH_I_R_T,polarH_I_L_T_Diag2);

g1_V = cat(1,polarV_I_L_T_Diag1,polarV_I_L_CTM,polarV_I_L_M,polarV_I_L_CMB,polarV_I_L_B_Diag1);
g2_V = cat(1,polarV_I_R_B,polarV_I_L_B_Diag2);
g3_V = polarV_I_R_M;
g4_V = cat(1,polarV_I_R_T,polarV_I_L_T_Diag2);

g1_Z = cat(1,polarZ_I_L_T_Diag1,polarZ_I_L_CTM,polarZ_I_L_M,polarZ_I_L_CMB,polarZ_I_L_B_Diag2);
g2_Z = cat(1,polarZ_I_R_B,polarZ_I_L_B_Diag1);
g3_Z = polarZ_I_R_M;
g4_Z = cat(1,polarZ_I_R_T,polarZ_I_L_T_Diag2);

cross_12 = polarZ_I_L_B_Diag3;
cross_13 = polarH_I_CLR;
cross_14 = polarZ_I_L_T_Diag3;
cross_23 = polarV_I_R_CMB;
cross_34 = polarV_I_R_CTM;

width_g1_H = linesWidth(g1_H);
width_g1_V = linesWidth(g1_V);
width_g1_Z = linesWidth(g1_Z);

width_g2_H = linesWidth(g2_H);
width_g2_V = linesWidth(g2_V);
width_g2_Z = linesWidth(g2_Z);

width_g3_H = linesWidth(g3_H);
width_g3_V = linesWidth(g3_V);
width_g3_Z = linesWidth(g3_Z);

width_g4_H = linesWidth(g4_H);
width_g4_V = linesWidth(g4_V);
width_g4_Z = linesWidth(g4_Z);

width_cross_12 = linesWidth(cross_12);
width_cross_13 = linesWidth(cross_13);
width_cross_14 = linesWidth(cross_14);
width_cross_23 = linesWidth(cross_23);
width_cross_34 = linesWidth(cross_34);

%%
error_score = sum(width_g1_V) + sum(width_g2_H) + sum(width_g3_Z) + sum(width_g4_H);
true_score = sum(width_g1_H) + sum(width_g1_Z) + ...
    sum(width_g2_V) + sum(width_g2_Z) + ...
    sum(width_g3_H) + sum(width_g3_V) + ...
    sum(width_g4_V) + sum(width_g4_Z);
through_score = sum(width_cross_12) + sum(width_cross_13) + sum(width_cross_14) + sum(width_cross_23) + sum(width_cross_34);

%%
if isShow
    fig = figure; 
    hold on
    plot(selPointT(1),selPointT(2),'*b');
    plot(selPointB(1),selPointB(2),'*b');

    % if ~isempty(polarH_I_L_T), plot(polarH_I_L_T(:,1:2)',polarH_I_L_T(:,3:4)','-r'); end
    % if ~isempty(polarV_I_L_T), plot(polarV_I_L_T(:,1:2)',polarV_I_L_T(:,3:4)','-r'); end
    % if ~isempty(polarZ_I_L_T), plot(polarZ_I_L_T(:,1:2)',polarZ_I_L_T(:,3:4)','-r'); end

    if ~isempty(polarH_I_L_CTM), plot(polarH_I_L_CTM(:,1:2)',polarH_I_L_CTM(:,3:4)','-g'); end
    if ~isempty(polarV_I_L_CTM), plot(polarV_I_L_CTM(:,1:2)',polarV_I_L_CTM(:,3:4)','-g'); end
    if ~isempty(polarZ_I_L_CTM), plot(polarZ_I_L_CTM(:,1:2)',polarZ_I_L_CTM(:,3:4)','-g'); end

    if ~isempty(polarH_I_L_M), plot(polarH_I_L_M(:,1:2)',polarH_I_L_M(:,3:4)','-g'); end
    if ~isempty(polarV_I_L_M), plot(polarV_I_L_M(:,1:2)',polarV_I_L_M(:,3:4)','-g'); end
    if ~isempty(polarZ_I_L_M), plot(polarZ_I_L_M(:,1:2)',polarZ_I_L_M(:,3:4)','-g'); end

    if ~isempty(polarH_I_L_CMB), plot(polarH_I_L_CMB(:,1:2)',polarH_I_L_CMB(:,3:4)','-g'); end
    if ~isempty(polarV_I_L_CMB), plot(polarV_I_L_CMB(:,1:2)',polarV_I_L_CMB(:,3:4)','-g'); end
    if ~isempty(polarZ_I_L_CMB), plot(polarZ_I_L_CMB(:,1:2)',polarZ_I_L_CMB(:,3:4)','-g'); end

    % if ~isempty(polarH_I_L_B), plot(polarH_I_L_B(:,1:2)',polarH_I_L_B(:,3:4)','-b'); end
    % if ~isempty(polarV_I_L_B), plot(polarV_I_L_B(:,1:2)',polarV_I_L_B(:,3:4)','-b'); end
    % if ~isempty(polarZ_I_L_B), plot(polarZ_I_L_B(:,1:2)',polarZ_I_L_B(:,3:4)','-b'); end

    if ~isempty(polarH_I_CLR), plot(polarH_I_CLR(:,1:2)',polarH_I_CLR(:,3:4)','-k'); end
    if ~isempty(polarV_I_CLR), plot(polarV_I_CLR(:,1:2)',polarV_I_CLR(:,3:4)','-k'); end
    if ~isempty(polarZ_I_CLR), plot(polarZ_I_CLR(:,1:2)',polarZ_I_CLR(:,3:4)','-k'); end



    if ~isempty(polarH_I_R_T), plot(polarH_I_R_T(:,1:2)',polarH_I_R_T(:,3:4)','-r'); end
    if ~isempty(polarV_I_R_T), plot(polarV_I_R_T(:,1:2)',polarV_I_R_T(:,3:4)','-r'); end
    if ~isempty(polarZ_I_R_T), plot(polarZ_I_R_T(:,1:2)',polarZ_I_R_T(:,3:4)','-r'); end

    if ~isempty(polarH_I_R_CTM), plot(polarH_I_R_CTM(:,1:2)',polarH_I_R_CTM(:,3:4)','-k'); end
    if ~isempty(polarV_I_R_CTM), plot(polarV_I_R_CTM(:,1:2)',polarV_I_R_CTM(:,3:4)','-k'); end
    if ~isempty(polarZ_I_R_CTM), plot(polarZ_I_R_CTM(:,1:2)',polarZ_I_R_CTM(:,3:4)','-k'); end

    if ~isempty(polarH_I_R_M), plot(polarH_I_R_M(:,1:2)',polarH_I_R_M(:,3:4)','-y'); end
    if ~isempty(polarV_I_R_M), plot(polarV_I_R_M(:,1:2)',polarV_I_R_M(:,3:4)','-y'); end
    if ~isempty(polarZ_I_R_M), plot(polarZ_I_R_M(:,1:2)',polarZ_I_R_M(:,3:4)','-y'); end

    if ~isempty(polarH_I_R_CMB), plot(polarH_I_R_CMB(:,1:2)',polarH_I_R_CMB(:,3:4)','-k'); end
    if ~isempty(polarV_I_R_CMB), plot(polarV_I_R_CMB(:,1:2)',polarV_I_R_CMB(:,3:4)','-k'); end
    if ~isempty(polarZ_I_R_CMB), plot(polarZ_I_R_CMB(:,1:2)',polarZ_I_R_CMB(:,3:4)','-k'); end

    if ~isempty(polarH_I_R_B), plot(polarH_I_R_B(:,1:2)',polarH_I_R_B(:,3:4)','-b'); end
    if ~isempty(polarV_I_R_B), plot(polarV_I_R_B(:,1:2)',polarV_I_R_B(:,3:4)','-b'); end
    if ~isempty(polarZ_I_R_B), plot(polarZ_I_R_B(:,1:2)',polarZ_I_R_B(:,3:4)','-b'); end


    if ~isempty(polarH_I_L_B_Diag2), plot(polarH_I_L_B_Diag2(:,1:2)',polarH_I_L_B_Diag2(:,3:4)','-g'); end
    if ~isempty(polarV_I_L_B_Diag1), plot(polarV_I_L_B_Diag1(:,1:2)',polarV_I_L_B_Diag1(:,3:4)','-g'); end
    if ~isempty(polarZ_I_L_B_Diag2), plot(polarZ_I_L_B_Diag2(:,1:2)',polarZ_I_L_B_Diag2(:,3:4)','-g'); end

    if ~isempty(polarH_I_L_B_Diag1), plot(polarH_I_L_B_Diag1(:,1:2)',polarH_I_L_B_Diag1(:,3:4)','-b'); end
    if ~isempty(polarV_I_L_B_Diag2), plot(polarV_I_L_B_Diag2(:,1:2)',polarV_I_L_B_Diag2(:,3:4)','-b'); end
    if ~isempty(polarZ_I_L_B_Diag1), plot(polarZ_I_L_B_Diag1(:,1:2)',polarZ_I_L_B_Diag1(:,3:4)','-b'); end

    if ~isempty(polarZ_I_L_B_Diag3), plot(polarZ_I_L_B_Diag3(:,1:2)',polarZ_I_L_B_Diag3(:,3:4)','-k'); end

    if ~isempty(polarH_I_L_T_Diag1), plot(polarH_I_L_T_Diag1(:,1:2)',polarH_I_L_T_Diag1(:,3:4)','-g'); end
    if ~isempty(polarV_I_L_T_Diag1), plot(polarV_I_L_T_Diag1(:,1:2)',polarV_I_L_T_Diag1(:,3:4)','-g'); end
    if ~isempty(polarZ_I_L_T_Diag1), plot(polarZ_I_L_T_Diag1(:,1:2)',polarZ_I_L_T_Diag1(:,3:4)','-g'); end

    if ~isempty(polarH_I_L_T_Diag2), plot(polarH_I_L_T_Diag2(:,1:2)',polarH_I_L_T_Diag2(:,3:4)','-r'); end
    if ~isempty(polarV_I_L_T_Diag2), plot(polarV_I_L_T_Diag2(:,1:2)',polarV_I_L_T_Diag2(:,3:4)','-r'); end
    if ~isempty(polarZ_I_L_T_Diag2), plot(polarZ_I_L_T_Diag2(:,1:2)',polarZ_I_L_T_Diag2(:,3:4)','-r'); end

    if ~isempty(polarZ_I_L_T_Diag3), plot(polarZ_I_L_T_Diag3(:,1:2)',polarZ_I_L_T_Diag3(:,3:4)','-k'); end


    title(['error=' num2str(error_score) 'true=' num2str(true_score) 'through=' num2str(through_score)  ]);
    hold off

    name = [num2str(selPointT(1,1)) 'x' num2str(selPointT(1,2)) '-' num2str(selPointB(1,1)) 'x' num2str(selPointB(1,2)) ...
        '-error' num2str(error_score) '-true' num2str(true_score) '-through' num2str(through_score)] ;
    mkdir(['../../Results/gridmethod/test2/grid/' fileName ]);
    saveas(fig,['../../Results/gridmethod/test2/grid/' fileName '/' name '.png' ])
    close(fig);
end



