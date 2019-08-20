function width_All = linesWidth(polar_all)

width_All = [];
for i=1:size(polar_all,1)
   p1 =  [polar_all(i,1:2:4),1];
   p2 =  [polar_all(i,2:2:4),1];
   p = p1 - p2;
   width = sqrt(p(1)^2+p(2)^2);
   width_All = cat(1,width_All,width);
end