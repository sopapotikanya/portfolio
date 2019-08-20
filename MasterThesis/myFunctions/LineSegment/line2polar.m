function [centerHRelative, centerVRelative, ...
                    polarHRelative, polarHRelative2, ...
                    polarVRelative, polarVRelative2, ...
                    polarZRelative,polarZRelative2, ...
                    widthH, widthV, minH, minV] = ...
                    line2polar(img,linesH,linesV,linesZ,vp_honz,vp_vert,vp_center,path_result,fileName)

if vp_honz(1,1) < vp_center(1,1)
    vp_honz_type = 'left';
else
    vp_honz_type = 'right';
end

% convert to polar coordinate
polarH = point2polarAllVanishing(linesH,vp_honz,vp_vert,vp_center,vp_honz_type);
polarV = point2polarAllVanishing(linesV,vp_honz,vp_vert,vp_center,vp_honz_type);
polarZ = point2polarAllVanishing(linesZ,vp_honz,vp_vert,vp_center,vp_honz_type);

[corner_polar,edgeH,edgeV] = cornerImg2polar(img,vp_honz,vp_vert,vp_center,vp_honz_type);

widthH = abs(edgeH(2,1) - edgeH(1,1));
widthV = abs(edgeV(2,1) - edgeV(1,1));
minH = min(edgeH(:,1));
minV = min(edgeV(:,1));

[centerHRelative, centerVRelative] = centerVP2Polar(vp_honz,vp_vert,vp_center,vp_honz_type,minH,minV,widthH,widthV);

polarHRelative = relativePolar(polarH,minH,minV,widthH,widthV);
polarVRelative = relativePolar(polarV,minH,minV,widthH,widthV);
polarZRelative = relativePolar(polarZ,minH,minV,widthH,widthV);

% set minimun on first field 
polarHRelative2 = locateMinFirst(polarHRelative);
polarVRelative2 = locateMinFirst(polarVRelative);
polarZRelative2 = locateMinFirst(polarZRelative);

% [H1,H2,V1,V2] = lineLayout(centerHRelative,polarHRelative2,centerVRelative,polarVRelative2,polarZRelative,polarZRelative2);
% 
% lineLayoutShow(H1,H2,V1,V2, ...
%     polarHRelative, polarVRelative, polarZRelative, ...
%     widthH, widthV, minH, minV, ...
%     vp_honz, vp_vert, vp_center, ...
%     img, path_result,fileName);

testbug=1;