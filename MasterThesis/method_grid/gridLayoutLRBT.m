function [width_g1_H_All,width_g2_H_All,width_g3_H_All, ...
        width_g1_V_All,width_g2_V_All,width_g3_V_All, ...
        width_g1_Z_All,width_g2_Z_All,width_g3_Z_All, ...
        width_through_12_All,width_through_13_All,width_through_23_All] = ...
        gridLayoutLRBT(part, gridBin,gridGab, ...
            centerHRelative,centerVRelative, ...
            polarH_LT,polarV_LT,polarZ_LT, ...
            polarH_LB,polarV_LB,polarZ_LB, ...
            polarH_RT,polarV_RT,polarZ_RT, ...
            polarH_RB,polarV_RB,polarZ_RB, ...
            path_result, fileName, inversAxis, isShow, isSave)
        
        if centerVRelative < 0
            centerV = 10; 
        else
            if centerVRelative > 90
                centerV = 90;
            else
                centerV = centerVRelative;
            end
        end
        
        if centerHRelative < 0
            centerH = 10;
        else
            if centerHRelative > 90
                centerH = 90;
            else
                centerH = centerHRelative;
            end
        end
         
if part(1) == 1 % top    
    startGridY = ceil(centerV/10)*10;
	endGridY = 100 - gridGab;
    partName2 = 'T';
else % bottom
    startGridY = gridGab;
	endGridY = floor(centerV/10)*10;   
    partName2 = 'B';
end

if part(2) == 1 % left    
    startGridX = gridGab;
	endGridX = floor(centerH/10)*10;
    partName1 = 'L';
else % right
    startGridX = ceil(centerH/10)*10;
    endGridX = 100 - gridGab;
    partName1 = 'R';
end

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

width_through_12_All = zeros(gridBin,gridBin);
width_through_13_All = zeros(gridBin,gridBin);
width_through_23_All = zeros(gridBin,gridBin);

[polarH_sel, polarV_sel, polarZ_sel] = polarPartSel(part, ...
            polarH_LT,polarV_LT,polarZ_LT, ...
            polarH_LB,polarV_LB,polarZ_LB, ...
            polarH_RT,polarV_RT,polarZ_RT, ...
            polarH_RB,polarV_RB,polarZ_RB);
% if part(1) == 1 && part(2) == 1 % Left-Top
%     polarH_sel = polarH_LT;
%     polarV_sel = polarV_LT;
%     polarZ_sel = polarZ_LT;
% elseif part(1) == 1 && part(2) == 2 % Right-Top
%     polarH_sel = polarH_RT;
%     polarV_sel = polarV_RT;
%     polarZ_sel = polarZ_RT;
% elseif part(1) == 2 && part(2) == 1 % Left-Bottom
%     polarH_sel = polarH_LB;
%     polarV_sel = polarV_LB;
%     polarZ_sel = polarZ_LB;
% else % Right-Bottom
%     polarH_sel = polarH_RB;
%     polarV_sel = polarV_RB;
%     polarZ_sel = polarZ_RB;
% end


for gridY = startGridY:gridGab:endGridY
    for gridX = startGridX:gridGab:endGridX
        selPoint = [gridX,gridY,1];

        [polarH_grid_LT, polarH_grid_LB, polarH_grid_RT, polarH_grid_RB, ...
            polarH_throughH_L_All, polarH_throughH_R_All, polarH_throughV_T_All, polarH_throughV_B_All ...
            ] = separateLinesLRBT(polarH_sel,selPoint);
        [polarV_grid_LT, polarV_grid_LB, polarV_grid_RT, polarV_grid_RB, ...
            polarV_throughH_L_All, polarV_throughH_R_All, polarV_throughV_T_All, polarV_throughV_B_All ...
            ] = separateLinesLRBT(polarV_sel,selPoint);
        [polarZ_grid_LT, polarZ_grid_LB, polarZ_grid_RT, polarZ_grid_RB, ...
            polarZ_throughH_L_All, polarZ_throughH_R_All, polarZ_throughV_T_All, polarZ_throughV_B_All ...
            ] = separateLinesLRBT(polarZ_sel,selPoint);

        if isShow
            fig_Sep4PT = plotSep4PT(polarH_LT,polarV_LT,polarZ_LT, ...
                polarH_LB,polarV_LB,polarZ_LB, ...
                polarH_RT,polarV_RT,polarZ_RT, ...
                polarH_RB,polarV_RB,polarZ_RB, ...
                polarH_grid_LT,polarV_grid_LT,polarZ_grid_LT, ...
                polarH_grid_LB,polarV_grid_LB,polarZ_grid_LB, ...
                polarH_grid_RT,polarV_grid_RT,polarZ_grid_RT, ...
                polarH_grid_RB,polarV_grid_RB,polarZ_grid_RB, ...
                inversAxis);
        end
         %% Saparate Diagonal
        lineZ_ABC = LineABC([centerHRelative,centerVRelative,1]',selPoint');
        [polarH_grid_sel, polarV_grid_sel, polarZ_grid_sel] = polarPartSel(part, ...
            polarH_grid_LT,polarV_grid_LT,polarZ_grid_LT, ...
            polarH_grid_LB,polarV_grid_LB,polarZ_grid_LB, ...
            polarH_grid_RT,polarV_grid_RT,polarZ_grid_RT, ...
            polarH_grid_RB,polarV_grid_RB,polarZ_grid_RB);
        if (part(1) == 1 && part(2) == 1) || (part(1) == 2 && part(2) == 2)
            [polarH_grid_DiagL, polarH_grid_DiagR] = separateLinesDiag_H(polarH_grid_sel,lineZ_ABC);
        else
            [polarH_grid_DiagR, polarH_grid_DiagL] = separateLinesDiag_H(polarH_grid_sel,lineZ_ABC);
        end
        
%         if part(1) == 1
            [polarV_grid_DiagL, polarV_grid_DiagR] = separateLinesDiag_V(polarV_grid_sel,lineZ_ABC);
%         else
%             [polarV_grid_DiagR, polarV_grid_DiagL] = separateLinesDiag_V(polarV_grid_sel,lineZ_ABC);
%         end
         
        if part(1) == 2%(part(1) == 2 && part(2) == 1) || (part(1) == 2 && part(2) == 2)
            [polarZ_grid_DiagR, polarZ_grid_DiagB, polarZ_grid_DiagL] = separateLinesDiag_Z(polarZ_grid_sel,lineZ_ABC);
        else
            [polarZ_grid_DiagL, polarZ_grid_DiagB, polarZ_grid_DiagR] = separateLinesDiag_Z(polarZ_grid_sel,lineZ_ABC);
        end

        if isShow
            fig_SepDiag = plotSepDiag(polarH_grid_DiagL, polarH_grid_DiagR, ...
                polarV_grid_DiagL, polarV_grid_DiagR, ...
                polarZ_grid_DiagL, polarZ_grid_DiagB, polarZ_grid_DiagR, ...
                inversAxis);
        end
         %% group lines to 3 part
        if part(1) == 1 && part(2) == 1 % Left-Top
            g1_H = cat(1,polarH_grid_DiagL,polarH_grid_LB);
            g2_H = cat(1,polarH_grid_DiagR,polarH_grid_RT);
            g3_H = polarH_grid_RB;

            g1_V = cat(1,polarV_grid_DiagL,polarV_grid_LB);
            g2_V = cat(1,polarV_grid_DiagR,polarV_grid_RT);
            g3_V = polarV_grid_RB;

            g1_Z = cat(1,polarZ_grid_DiagL,polarZ_grid_LB);
            g2_Z = cat(1,polarZ_grid_DiagR,polarZ_grid_RT);
            g3_Z = polarZ_grid_RB;
            
            % lineH through in verticle axis
            through_13 = polarH_throughV_B_All;
            through_23 = polarV_throughH_R_All;
            through_12 = polarZ_grid_DiagB;
        elseif part(1) == 1 && part(2) == 2 % right-Top
            g1_H = cat(1,polarH_grid_DiagR,polarH_grid_RB);
            g2_H = cat(1,polarH_grid_DiagL,polarH_grid_LT);
            g3_H = polarH_grid_LB;
            
            g1_V = cat(1,polarV_grid_DiagR,polarV_grid_RB);
            g2_V = cat(1,polarV_grid_DiagL,polarV_grid_LT);
            g3_V = polarV_grid_LB;
            
            g1_Z = cat(1,polarZ_grid_DiagR,polarZ_grid_RB);
            g2_Z = cat(1,polarZ_grid_DiagL,polarZ_grid_LT);
            g3_Z = polarZ_grid_LB;
            
            % lineH through in verticle axis
            through_13 = polarH_throughV_B_All;
            through_23 = polarV_throughH_L_All;
            through_12 = polarZ_grid_DiagB;
        elseif part(1) == 2 && part(2) == 1 % Left-Bottom
            g1_H = cat(1,polarH_grid_DiagL,polarH_grid_LT);
            g2_H = cat(1,polarH_grid_DiagR,polarH_grid_RB,polarH_throughV_B_All);
            g3_H = polarH_grid_RT;
            
            g1_V = cat(1,polarV_grid_DiagL,polarV_grid_LT,polarV_throughH_L_All);
            g2_V = cat(1,polarV_grid_DiagR,polarV_grid_RB);
            g3_V = polarV_grid_RT;
            
            g1_Z = cat(1,polarZ_grid_DiagL,polarZ_grid_LT); 
            g2_Z = cat(1,polarZ_grid_DiagR,polarZ_grid_RB);
            g3_Z = polarZ_grid_RT;
            
            % lineH through in verticle axis
            through_13 = polarH_throughV_T_All;
            through_23 = polarV_throughH_R_All;
            through_12 = polarZ_grid_DiagB;

        else
            g1_H = cat(1,polarH_grid_DiagR,polarH_grid_RT);
            g2_H = cat(1,polarH_grid_DiagL,polarH_grid_LB);
            g3_H = polarH_grid_LT;
            
            g1_V = cat(1,polarV_grid_DiagR,polarV_grid_RT);
            g2_V = cat(1,polarV_grid_DiagL,polarV_grid_LB);
            g3_V = polarV_grid_LT;
            
            g1_Z = cat(1,polarZ_grid_DiagR,polarZ_grid_RT);
            g2_Z = cat(1,polarZ_grid_DiagL,polarZ_grid_LB);
            g3_Z = polarZ_grid_LT;
            
            % lineH through in verticle axis
            through_13 = polarH_throughV_T_All;
            through_23 = polarV_throughH_R_All;
            through_12 = polarZ_grid_DiagB;
        end

        if isShow
            fig_Sep3PT = plotSep3PT(polarH_LT,polarV_LT,polarZ_LT, ...
                polarH_LB,polarV_LB,polarZ_LB, ...
                polarH_RT,polarV_RT,polarZ_RT, ...
                polarH_RB,polarV_RB,polarZ_RB, ...
                g1_H, g1_V, g1_Z, ...
                g2_H, g2_V, g2_Z, ...
                g3_H, g3_V, g3_Z, ...
                through_12, through_13, through_23, ...
                selPoint, inversAxis);
        end

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

        width_through_13 = linesWidth(through_13);
        width_through_23 = linesWidth(through_23);
        width_through_12 = linesWidth(through_12);
        % error lise is g1_V g2_H g3_Z
%         error_score = sum(width_g1_V) + sum(width_g2_H) + sum(width_g3_Z);
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

        width_through_13_All(gridY/gridGab,gridX/gridGab) = sum(width_through_13);
        width_through_23_All(gridY/gridGab,gridX/gridGab) = sum(width_through_23);
        width_through_12_All(gridY/gridGab,gridX/gridGab) = sum(width_through_12);
%         error_score_All(gridY/gridGab,gridX/gridGab) = error_score;
        %% save
        if isSave
            path_sep3PT = [path_result 'grid/' fileName '/Sep3PT_' partName1 partName2];
            path_sep4PT = [path_result 'grid/' fileName '/Sep4PT_' partName1 partName2];
            path_grouplines = [path_result 'grid/' fileName '/GroupLines_' partName1 partName2];
            if ~exist(path_sep3PT, 'dir')
               mkdir(path_sep3PT)
            end
            if ~exist(path_sep4PT, 'dir')
               mkdir(path_sep4PT)
            end
            if ~exist(path_grouplines, 'dir')
               mkdir(path_grouplines)
            end
            saveas(fig_Sep3PT,[path_sep3PT '/' num2str(gridX) 'x' num2str(gridY) '.png']);
            saveas(fig_Sep4PT,[path_sep4PT '/' num2str(gridX) 'x' num2str(gridY) '.png']);
            save([path_grouplines '/' num2str(gridX) 'x' num2str(gridY) '.mat'], ...
                'g1_H', 'g1_V', 'g1_Z', ...
                'g2_H', 'g2_V', 'g2_Z', ...
                'g3_H', 'g3_V', 'g3_Z');
        end
        if isShow
            close all
        end
    end
end
if isSave
    save([path_result 'grid/' fileName '/' partName1 partName2 '_score.mat'], ...
        'width_g1_H_All','width_g2_H_All','width_g3_H_All', ...
        'width_g1_V_All','width_g2_V_All','width_g3_V_All', ...
        'width_g1_Z_All','width_g2_Z_All','width_g3_Z_All', ...
        'width_through_12_All','width_through_13_All','width_through_23_All');
end

% load([path_result 'grid/' fileName '/' partName1 partName2 '_score.mat'], ...
%     'width_g1_H_All','width_g2_H_All','width_g3_H_All', ...
%     'width_g1_V_All','width_g2_V_All','width_g3_V_All', ...
%     'width_g1_Z_All','width_g2_Z_All','width_g3_Z_All')
% 
% error_g1 = width_g1_V_All;
% error_g2 = width_g2_H_All;
% error_g3 = width_g3_Z_All;
% 
% error_score = error_g1 + error_g2 + error_g3;
% error_score = sum(width_g1_V) + sum(width_g2_H) + sum(width_g3_Z);


