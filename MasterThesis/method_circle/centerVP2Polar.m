function [centerHRelative, centerVRelative] = centerVP2Polar(vp_honz,vp_vert,vp_center,vp_honz_type,minH,minV,widthH,widthV)

[angleD1, dis1] = point2polar(vp_center,vp_honz);
centerH = roundPolarDegree(angleD1,vp_honz_type,'honz');
[angleD2, dis1] = point2polar(vp_center,vp_vert);
centerV = roundPolarDegree(angleD2,vp_honz_type,'vert');

centerHRelative = (centerH - minH)*100 /widthH;
centerVRelative = (centerV - minV)*100 /widthV;