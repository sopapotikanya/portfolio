function [coor_test,coor_dif_minT_m_maxF,coor_true_error, ...
    error_g1, error_g2, error_g3, ...
        true_g1, true_g2, true_g3, ...
        error_All, true_All, through_All, ...
        true_error_All, true_error_All_relative, ...
        diff_true, diff_error, ...
        min_true, max_true, min_error, max_error, ...
        sum_diff, sum_diff2, sum_diff2_relative, ...
        dif_minT_m_maxF, true_m_error_All, ...
    test_All, dif_minT_m_maxF_relative, true_m_error_All_relative ...
    ] = score( part, gridBin, ...
    width_g1_H_All,width_g2_H_All,width_g3_H_All, ...
    width_g1_V_All,width_g2_V_All,width_g3_V_All, ...
    width_g1_Z_All,width_g2_Z_All,width_g3_Z_All, ...
    width_through_12_All,width_through_13_All,width_through_23_All)

error_g1 = width_g1_V_All;
error_g2 = width_g2_H_All;
error_g3 = width_g3_Z_All;

true_g1 = width_g1_H_All + width_g1_Z_All + width_through_12_All + width_through_13_All;
true_g2 = width_g2_V_All + width_g2_Z_All + width_through_12_All + width_through_23_All;
true_g3 = width_g3_H_All + width_g3_V_All + width_through_13_All + width_through_23_All;  
% if part(1) == 1 && part(2) == 1 % Left-Top
% 
% elseif part(1) == 1 && part(2) == 2 % right-Top
%         
% elseif part(1) == 2 && part(2) == 1 % Left-Bottom
% 
% else
%     
% end

error_All = error_g1 + error_g2 + error_g3;
true_All = true_g1 + true_g2 + true_g3;
through_All = width_through_12_All + width_through_13_All + width_through_23_All;
true_m_error_All = true_All - error_All;
true_m_error_All_relative = relativeMatrix(true_m_error_All);
true_error_All = true_All + error_All;
true_error_All_relative = relativeMatrix(true_error_All);
[A, idy] = max(true_m_error_All_relative);
[~, idx] = max(A);
coor_true_error = [idx*100/gridBin,  idy(idx)*100/gridBin];

for i=1:gridBin
    for j=1:gridBin
        T = [true_g1(i,j),true_g2(i,j),true_g3(i,j)];
        F = [error_g1(i,j),error_g2(i,j),error_g3(i,j)];
        min_true(i,j) = min(T);
        max_true(i,j) = max(T);
        min_error(i,j) = min(F);
        max_error(i,j) = max(F);
        
        diff_true(i,j) = abs(min(T) - max(T));
        diff_error(i,j) = abs(min(F) - max(F));
        dif_minT_m_maxF(i,j) = min(T) - max(F);
    end
end

sum_diff = diff_true + diff_error;
sum_diff2 = diff_true + diff_error.*2;
sum_diff2(10,10) = NaN;
sum_diff2_relative = 100-relativeMatrix(sum_diff2);

% dif_minT_m_maxF_relative = relativeMatrix(dif_minT_m_maxF);
dif_minT_m_maxF_relative = relativeMatrix(min_true);
[A, idy] = max(dif_minT_m_maxF_relative);
[~, idx] = max(A);
coor_dif_minT_m_maxF = [idx*100/gridBin,  idy(idx)*100/gridBin];

%     test_All = true_error_All_relative + sum_diff2_relative;
test_All = dif_minT_m_maxF_relative*2 + true_m_error_All_relative;
[A, idy] = max(test_All);
[~, idx] = max(A);
coor_test = [idx*100/gridBin,  idy(idx)*100/gridBin];

