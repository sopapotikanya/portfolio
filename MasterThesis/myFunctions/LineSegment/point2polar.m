function [angleD, dis] = point2polar(point,vp,varargin)
% angle is plus from horizontal
%         |              %        +91|+90          
%   +180  |  +90         %     +180  |      1     
% --------vp--------     % img --------vp-------- 
%   -180  |  -90         %     +181  |      -1  
%         |              %       +270|-90        
% vp at left, up, buttom % vp at right   


% vect = point - vp;
% angleD = atand(-vect(2)/vect(1));

% if vect(1) > 0
%     if vect(2) > 0 % Q4
%         angleD = angleD;
%     else % Q1
%         angleD = angleD;
%     end
% else
%     if vect(2) > 0 % Q3
%         angleD = angleD - 180;
%     else % Q2
%         angleD = angleD + 180;
%     end
% end

vect = point - vp;
angleD = atand(vect(2)/vect(1));

if abs(vect(1)) > abs(vect(2)) % horizontal
    if vect(1) > 0 % vp at left side
        angleD = -angleD;
    else % vp at right side
        angleD = 180 - angleD;
    end
else % vertical
    if vect(2) > 0 % vp at top side
        if vect(1) > 0 % Q4
            angleD = - angleD;
        else % Q1
            angleD = -180-angleD;
        end
    else % vp at bottom side
        if vect(1) < 0 % Q2
            angleD = 180 - angleD;
        else % Q1
            angleD = - angleD;
        end
    end
end

dis = hypot(vect(1),vect(2));