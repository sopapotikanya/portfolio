function output_deg = roundPolarDegree(deg,vp_honz_type,direction)
% if deg < 0, output_deg = deg + 360; else, output_deg = deg; end
if strcmp(vp_honz_type,'left')
    output_deg = deg;
%     if strcmp(direction,'honz')
%         a=1;
%     elseif strcmp(direction,'vert')
%         a=1;
%     else
%         a=1;
%     end
else
    if deg < 0, output_deg = deg + 360; else, output_deg = deg; end
%     if strcmp(direction,'honz')
%         if deg < 0, output_deg = deg + 360; else, output_deg = deg; end
%     elseif strcmp(direction,'vert')
%         if deg < 0, output_deg = deg + 360; else, output_deg = deg; end
%     else
%         if deg < 0, output_deg = deg + 360; else, output_deg = deg; end
%     end
end

