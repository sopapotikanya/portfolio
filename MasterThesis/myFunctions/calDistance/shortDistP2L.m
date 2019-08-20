function d = shortDistP2L(pt, v1, v2)
%       a = v1 - v2;
%       b = pt - v2;
%       d = norm(cross(a,b)) / norm(a);
      
      a = v2 - v1;
      b = v1 - pt;
      
      
      t = dot(-b,a) / norm(a)^2;
      
      if (t>=-0.02) && (t<=1.02)
          d = norm(cross(a,b)) / norm(a);
      else
          d = Inf;
          
      end
      
      