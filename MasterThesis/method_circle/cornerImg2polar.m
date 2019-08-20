function [corner_polar,edgeH,edgeV] = cornerImg2polar(img,vp_honz,vp_vert,vp_center,vp_honz_type)
% corner(1)         |                   corner(2)
% [1,1]             |             [1,size(img,2)]
% ------------------+----------------------------
% corner(3)         |                   corner(4)
% [size(img,1),1]   |   [size(img,1),size(img,2)]
%
% Output
% corner_polar = [corner index][polarH, disH, polarV, disV, polarZ, disZ ]
% edgeH = [min polar, max polar][polarH, disH]
% edgeV = [min polar, max polar][polarV, disV]
%



corner = zeros(4,2);
corner_polar = zeros(4,6);
corner(1,1:2) = [1,1];
% corner(2,1:2) = [1,size(img,2)];
% corner(3,1:2) = [size(img,1),1];
% corner(4,1:2) = [size(img,1),size(img,2)];
corner(2,1:2) = [size(img,1),1];
corner(3,1:2) = [1,size(img,2)];
corner(4,1:2) = [size(img,2),size(img,1)];

for i=1:4
    [angleD1, dis1] = point2polar(corner(i,:),vp_honz);
    corner_polar(i,1) = roundPolarDegree(angleD1,vp_honz_type,'honz');
    corner_polar(i,2) = dis1;
    [angleD2, dis2] = point2polar(corner(i,:),vp_vert);
    corner_polar(i,3) = roundPolarDegree(angleD2,vp_honz_type,'vert');
    corner_polar(i,4) = dis2;
    [angleD3, dis3] = point2polar(corner(i,:),vp_center);
    corner_polar(i,5) = roundPolarDegree(angleD3,vp_honz_type,'center');
    corner_polar(i,6) = dis3;
end


% minEdge = min(cat(1,min(polarH),min(polarV),min(polarZ)));
% maxEdge = max(cat(1,max(polarH),max(polarV),max(polarZ)));


if strcmp(vp_honz_type,'left')
    edgeH = [corner_polar(1,1:2); corner_polar(3,1:2)];
    edgeV = [corner_polar(3,3:4); corner_polar(4,3:4)];
else
    edgeH = [corner_polar(2,1:2); corner_polar(4,1:2)];
    edgeV = [corner_polar(3,3:4); corner_polar(4,3:4)];    
end