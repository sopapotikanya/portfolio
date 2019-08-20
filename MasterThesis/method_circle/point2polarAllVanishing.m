function polar = point2polarAllVanishing(lines,vp_honz,vp_vert,vp_center,vp_honz_type)

% if vp_honz(1,1) < vp_center(1,1)
%     vp_honz_type = 'left';
% else
%     vp_honz_type = 'right';
% end

polar = [];
for i=1:size(lines,1)
    point1 = lines(i,1:2);
    [angleDx1, ~] = point2polar(point1,vp_honz);
    x1 = roundPolarDegree(angleDx1,vp_honz_type,'honz');
%     x1 = angleDx1;
    [angleDy1, ~] = point2polar(point1,vp_vert);
    y1 = roundPolarDegree(angleDy1,vp_honz_type,'vert');
%     y1 = angleDy1;
    [angleDz1, ~] = point2polar(point1,vp_center);
    z1 = roundPolarDegree(angleDz1,vp_honz_type,'center');
%     z1 = angleDz1;
    
    point2 = lines(i,3:4);
    [angleDx2, ~] = point2polar(point2,vp_honz);
    x2 = roundPolarDegree(angleDx2,vp_honz_type,'honz');
%     x2 = angleDx2;
    [angleDy2, ~] = point2polar(point2,vp_vert);
    y2 = roundPolarDegree(angleDy2,vp_honz_type,'vert');
%     y2 = angleDy2;
    [angleDz2, ~] = point2polar(point2,vp_center);
    z2 = roundPolarDegree(angleDz2,vp_honz_type,'center');
%     z2 = angleDz2;
    
    polar = cat(1,polar,[x1,x2,y1,y2,z1,z2]);
end