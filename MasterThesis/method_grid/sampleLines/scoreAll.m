function scoreAll( polarH_LT,polarV_LT,polarZ_LT,polarH_LB,polarV_LB,polarZ_LB, ...
    polarH_RT,polarV_RT,polarZ_RT,polarH_RB,polarV_RB,polarZ_RB, ...
    error_g1, error_g2, error_g3, ...
    true_g1, true_g2, true_g3, ...
    error_All, true_All, through_All, ...
    true_error_All, true_error_All_relative, ...
    diff_true, diff_error, ...
    min_true, max_true, min_error, max_error, ...
    sum_diff, sum_diff2, sum_diff2_relative, ...
    test_All, dif_minT_m_maxF, true_m_error_All, ...
    dif_minT_m_maxF_relative, true_m_error_All_relative, ...
    path_result, inversAxis,gridBin,gridGab, sample)

% % gridBin = 10;
% % gridGab = 10;
% path_score = [path_result 'score/' sample];
% if ~exist(path_score, 'dir')
%     mkdir(path_score);
% end
% polarH = cat(1,polarH_LT,polarH_LB,polarH_RT,polarH_RB);
% polarV = cat(1,polarV_LT,polarV_LB,polarV_RT,polarV_RB);
% polarZ = cat(1,polarZ_LT,polarZ_LB,polarZ_RT,polarZ_RB);
% %% error_g1
% % plotScore(polarH,polarV,polarZ, ...
% %     error_g1,[path_score '/error_g1.png'],gridBin,gridGab, inversAxis);
% 
% % %% error_g2
% % plotScore(polarH,polarV,polarZ, ...
% %     error_g2,[path_score '/error_g2.png'],gridBin,gridGab, inversAxis);
% % 
% % %% error_g3
% % plotScore(polarH,polarV,polarZ, ...
% %     error_g3,[path_score '/error_g3.png'],gridBin,gridGab, inversAxis);
% % 
% % %% true_g1
% % plotScore(polarH,polarV,polarZ, ...
% %     true_g1,[path_score '/true_g1.png'],gridBin,gridGab, inversAxis);
% % 
% % %% true_g2
% % plotScore(polarH,polarV,polarZ, ...
% %     true_g2,[path_score '/true_g2.png'],gridBin,gridGab, inversAxis);
% % 
% % %% true_g3
% % plotScore(polarH,polarV,polarZ, ...
% %     true_g3,[path_score '/true_g3.png'],gridBin,gridGab, inversAxis);
% 
% %% error_All
% plotScore(polarH,polarV,polarZ, ...
%     error_All,[path_score '/error_All.png'],gridBin,gridGab, inversAxis);
% 
% %% true_All
% plotScore(polarH,polarV,polarZ, ...
%     true_All,[path_score '/true_All.png'],gridBin,gridGab, inversAxis);
% 
% % %% through_All
% % plotScore(polarH,polarV,polarZ, ...
% %     through_All,[path_score '/through_All.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % 
% % %% true_error_All
% % plotScore(polarH,polarV,polarZ, ...
% %     true_error_All,[path_score '/true_error_All.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% true_error_All_relative
% % plotScore(polarH,polarV,polarZ, ...
% %     true_error_All_relative,[path_score '/true_error_All_relative.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% diff_true
% % plotScore(polarH,polarV,polarZ, ...
% %     diff_true,[path_score '/diff_true.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% diff_error
% % plotScore(polarH,polarV,polarZ, ...
% %     diff_error,[path_score '/diff_error.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% min_true
% % plotScore(polarH,polarV,polarZ, ...
% %     min_true,[path_score '/min_true.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% max_true
% % plotScore(polarH,polarV,polarZ, ...
% %     max_true,[path_score '/max_true.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% min_error
% % plotScore(polarH,polarV,polarZ, ...
% %     min_error,[path_score '/min_error.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% max_error
% % plotScore(polarH,polarV,polarZ, ...
% %     max_error,[path_score '/max_error.png'],gridBin,gridGab, inversAxis);
% % 
% 
% %% sum_diff
% plotScore(polarH,polarV,polarZ, ...
%     sum_diff,[path_score '/sum_diff.png'],gridBin,gridGab, inversAxis);
% 
% 
% % %% sum_diff2
% % plotScore(polarH,polarV,polarZ, ...
% %     sum_diff2,[path_score '/sum_diff2.png'],gridBin,gridGab, inversAxis);
% % 
% % 
% % %% sum_diff2_relative
% % plotScore(polarH,polarV,polarZ, ...
% %     sum_diff2_relative,[path_score '/sum_diff2_relative.png'],gridBin,gridGab, inversAxis);
% 
% 
% %% test_All
% plotScore(polarH,polarV,polarZ, ...
%     test_All,[path_score '/test_All.png'],gridBin,gridGab, inversAxis);
% 
% % %% dif_minT_m_maxF
% % plotScore(polarH,polarV,polarZ, ...
% %     dif_minT_m_maxF,[path_score '/dif_minT_m_maxF.png'],gridBin,gridGab, inversAxis);
% % 
% % %% true_m_error_All
% % plotScore(polarH,polarV,polarZ, ...
% %     true_m_error_All,[path_score '/true_m_error_All.png'],gridBin,gridGab, inversAxis);
% 
% 
% %% dif_minT_m_maxF_relative
% plotScore(polarH,polarV,polarZ, ...
%     dif_minT_m_maxF_relative,[path_score '/dif_minT_m_maxF_relative.png'],gridBin,gridGab, inversAxis);
% 
% %% true_m_error_All_relative
% plotScore(polarH,polarV,polarZ, ...
%     true_m_error_All_relative,[path_score '/true_m_error_All_relative.png'],gridBin,gridGab, inversAxis);