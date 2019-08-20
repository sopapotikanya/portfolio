function [pca]=PCA(DAll,numEmo)
%[DAll] = ReadTxtForPCA;
% DAll : normalization vector of each window, size = 14*14*numEmo
% numEmo : total expression number
Size = size(DAll);
Mean = mean(mean(DAll),3);
SigmaCo = zeros(Size(1,2),Size(1,2));
pca = zeros(196,1);
for j=1:numEmo
    for i=1:Size(1,1)
        S=(DAll(i,:,j)'-Mean')*(DAll(i,:,j)'-Mean')';
        SigmaCo = SigmaCo + S;
    end
end
Covariance = SigmaCo/(Size(1,1)*Size(1,3));
C_Diag = diag(Covariance);
C_Diag2 = diag(Covariance);
 
for i = 1:196
    [C,I] = max(C_Diag2);
    C_Diag2(I,1) = 0;
    pca(i)=I;
end
end
