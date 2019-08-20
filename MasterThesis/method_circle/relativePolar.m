function polarRelative = relativePolar(polarAll,minH,minV,widthH,widthV)
%
% polarAll = [polarH1,polarH2,polarV1,polarV1,polarZ1,polarZ2] (line)
% edgeH = [min polar; max polar][polarH, disH]
% edgeV = [min polar; max polar][polarV, disV]
%
%
% widthH = abs(edgeH(2,1) - edgeH(1,1));
% widthV = abs(edgeV(2,1) - edgeV(1,1));
% minH = min(edgeH(:,1));
% minV = min(edgeV(:,1));


polarRelative = polarAll;

for i=1:size(polarAll,1)
    polarRelative(i,1) = (polarAll(i,1) - minH)*100 /widthH;
    polarRelative(i,2) = (polarAll(i,2) - minH)*100 /widthH;
    polarRelative(i,3) = (polarAll(i,3) - minV)*100 /widthV;
    polarRelative(i,4) = (polarAll(i,4) - minV)*100 /widthV;
end




