function point = polar2point(angleD,dis,vp)
    x = dis*cosd(angleD);
    y = dis*sind(angleD);
    
    point = [x,-y] + vp;
    
%     if angleD > 180
%         y = -y; 
%     elseif angleD > 90
%         y = -y;
%     elseif angleD > 0
%         y = -y; 
%     elseif angleD > -90
%         y = -y;
%     else
%         y = -y;
%     end
%     point = [x,y] + vp;
end