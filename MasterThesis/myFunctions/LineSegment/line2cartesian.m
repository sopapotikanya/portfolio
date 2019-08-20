function lines_cartesian = line2cartesian(Lines,vp)

lines_cartesian = [];
for i=1:size(Lines,1)
    point1 = Lines(i,1:2);
    [angleD1, dis1] = point2polar(point1,vp);
    
    point2 = Lines(i,3:4);
    [angleD2, dis2] = point2polar(point2,vp);
    
    mean_angleD = (angleD1 + angleD2)/2;
    
    if dis1 < dis2
        lines_cartesian = cat(1,lines_cartesian,[point1,point2,angleD1, dis1,angleD2, dis2,mean_angleD]);
%         lines_polar = cat(1,lines_polar,[angleD1, dis1,angleD2, dis2,mean_angleD]);
    else
        lines_cartesian = cat(1,lines_cartesian,[point2,point1,angleD2, dis2,angleD1, dis1,mean_angleD]);
%         lines_polar = cat(1,lines_polar,[angleD2, dis2,angleD1, dis1,mean_angleD]);
    end
    
end