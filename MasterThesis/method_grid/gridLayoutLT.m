function gridLayoutLT(gridBin,gridGab,centerHRelative,centerVRelative, ...
            polarH_LT,polarV_LT,polarZ_LT, ...
            polarH_LB,polarV_LB,polarZ_LB, ...
            polarH_RT,polarV_RT,polarZ_RT, ...
            polarH_RB,polarV_RB,polarZ_RB, ...
            path_result)

startGridY = ceil(centerVRelative/10)*10;
endGridY = 100;
startGridX = gridGab;
endGridX = floor(centerHRelative/10)*10;
 %% separate selPoint
error_score_All = ones(gridBin,gridBin)*999;
width_g1_H_All = zeros(gridBin,gridBin);
width_g2_H_All = zeros(gridBin,gridBin);
width_g3_H_All = zeros(gridBin,gridBin);
width_g1_V_All = zeros(gridBin,gridBin);
width_g2_V_All = zeros(gridBin,gridBin);
width_g3_V_All = zeros(gridBin,gridBin);
width_g1_Z_All = zeros(gridBin,gridBin);
width_g2_Z_All = zeros(gridBin,gridBin);
width_g3_Z_All = zeros(gridBin,gridBin);


for gridY = startGridY:gridGab:endGridY
    for gridX = startGridX:gridGab:endGridX
        selPoint = [gridX,gridY,1];

        [polarH_grid_LT, polarH_grid_LB, polarH_grid_RT, polarH_grid_RB] = separateLinesLRBT(polarH_LT,selPoint);
        [polarV_grid_LT, polarV_grid_LB, polarV_grid_RT, polarV_grid_RB] = separateLinesLRBT(polarV_LT,selPoint);
        [polarZ_grid_LT, polarZ_grid_LB, polarZ_grid_RT, polarZ_grid_RB] = separateLinesLRBT(polarZ_LT,selPoint);

        fig_Sep4PT = plotSep4PT(polarH_LT,polarV_LT,polarZ_LT, ...
            polarH_LB,polarV_LB,polarZ_LB, ...
            polarH_RT,polarV_RT,polarZ_RT, ...
            polarH_RB,polarV_RB,polarZ_RB, ...
            polarH_grid_LT,polarV_grid_LT,polarZ_grid_LT, ...
            polarH_grid_LB,polarV_grid_LB,polarZ_grid_LB, ...
            polarH_grid_RT,polarV_grid_RT,polarZ_grid_RT, ...
            polarH_grid_RB,polarV_grid_RB,polarZ_grid_RB);

        %% Saparate Diagonal
        lineZ_ABC = LineABC([centerHRelative,centerVRelative,1]',selPoint');
        [polarH_grid_DiagL, polarH_grid_DiagR] = separateLinesDiag_H(polarH_grid_LT,lineZ_ABC);
        [polarV_grid_DiagL, polarV_grid_DiagR] = separateLinesDiag_V(polarV_grid_LT,lineZ_ABC);
        [polarZ_grid_DiagL, polarZ_grid_DiagB, polarZ_grid_DiagR] = separateLinesDiag_Z(polarZ_grid_LT,lineZ_ABC);

%         fig_SepDiag = plotSepDiag(polarH_grid_DiagL, polarH_grid_DiagR, ...
%             polarV_grid_DiagL, polarV_grid_DiagR, ...
%             polarZ_grid_DiagL, polarZ_grid_DiagB, polarZ_grid_DiagR);

        %% group lines to 3 part

        g1_H = cat(1,polarH_grid_DiagL,polarH_grid_LB);
        g2_H = cat(1,polarH_grid_DiagR,polarH_grid_RT);
        g3_H = polarH_grid_RB;

        g1_V = cat(1,polarV_grid_DiagL,polarV_grid_LB);
        g2_V = cat(1,polarV_grid_DiagR,polarV_grid_RT);
        g3_V = polarV_grid_RB;

        g1_Z = cat(1,polarZ_grid_DiagL,polarZ_grid_LB);
        g2_Z = cat(1,polarZ_grid_DiagR,polarZ_grid_RT);
        g3_Z = polarZ_grid_RB;

        fig_Sep3PT = plotSep3PT(polarH_LT,polarV_LT,polarZ_LT, ...
            polarH_LB,polarV_LB,polarZ_LB, ...
            polarH_RT,polarV_RT,polarZ_RT, ...
            polarH_RB,polarV_RB,polarZ_RB, ...
            g1_H, g1_V, g1_Z, ...
            g2_H, g2_V, g2_Z, ...
            g3_H, g3_V, g3_Z);

        %% score
        width_g1_H = linesWidth(g1_H);
        width_g2_H = linesWidth(g2_H);
        width_g3_H = linesWidth(g3_H);

        width_g1_V = linesWidth(g1_V);
        width_g2_V = linesWidth(g2_V);
        width_g3_V = linesWidth(g3_V);

        width_g1_Z = linesWidth(g1_Z);
        width_g2_Z = linesWidth(g2_Z);
        width_g3_Z = linesWidth(g3_Z);

        % error lise is g1_V g2_H g3_Z
        error_score = sum(width_g1_V) + sum(width_g2_H) + sum(width_g3_Z);
%         error_score = sum(width_g1_V) + sum(width_g2_H) + sum(width_g3_Z)*1.414;


        width_g1_H_All(gridY/gridGab,gridX/gridGab) = sum(width_g1_H);
        width_g2_H_All(gridY/gridGab,gridX/gridGab) = sum(width_g2_H);
        width_g3_H_All(gridY/gridGab,gridX/gridGab) = sum(width_g3_H);
        
        width_g1_V_All(gridY/gridGab,gridX/gridGab) = sum(width_g1_V);
        width_g2_V_All(gridY/gridGab,gridX/gridGab) = sum(width_g2_V);
        width_g3_V_All(gridY/gridGab,gridX/gridGab) = sum(width_g3_V);
        
        width_g1_Z_All(gridY/gridGab,gridX/gridGab) = sum(width_g1_Z);
        width_g2_Z_All(gridY/gridGab,gridX/gridGab) = sum(width_g2_Z);
        width_g3_Z_All(gridY/gridGab,gridX/gridGab) = sum(width_g3_Z);

        error_score_All(gridY/gridGab,gridX/gridGab) = error_score;
        %% save
        saveas(fig_Sep3PT,[path_result 'Sep3PT_LT/' num2str(gridX) 'x' num2str(gridY) '.png']);
        saveas(fig_Sep4PT,[path_result 'Sep4PT_LT/' num2str(gridX) 'x' num2str(gridY) '.png']);
        close all
    end
end
save([path_result 'SepVP/LT_score.mat'],'error_score_All', ...
    'width_g1_H_All','width_g2_H_All','width_g3_H_All', ...
    'width_g1_V_All','width_g2_V_All','width_g3_V_All', ...
    'width_g1_Z_All','width_g2_Z_All','width_g3_Z_All');