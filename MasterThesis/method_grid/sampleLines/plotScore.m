function plotScore(polarH,polarV,polarZ, ...
    score,path,gridBin,gridGab, ...
    inversAxis)
fig = plotLinePolar(polarH,polarV,polarZ, inversAxis);
% fig = plotSepVP(polarH_LT,polarV_LT,polarZ_LT, ...
%         polarH_LB,polarV_LB,polarZ_LB, ...
%         polarH_RT,polarV_RT,polarZ_RT, ...
%         polarH_RB,polarV_RB,polarZ_RB, ...
%         inversAxis);
hold on
if ~inversAxis
    for i=1:gridBin
        for j=1:gridBin
            text(j*gridGab,i*gridGab,num2str(score(i,j),3))
        end
    end
else
    for i=1:gridBin
        for j=1:gridBin
            text(i*gridGab,j*gridGab,num2str(score(i,j),3))
        end
    end
end
hold off
if path
    saveas(fig,path);
end
close all