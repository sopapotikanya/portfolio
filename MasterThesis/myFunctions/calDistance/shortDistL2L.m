function d = shortDistL2L(v1, v2, v3, v4)
      
      a = v2 - v1;
      b = v4 - v3;
      c = v1 - v3;
      
      d = norm(dot(c,cross(a,b))) / norm(cross(a,b));
