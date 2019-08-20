function polarABC = polarABC(polar)

polarABC = [];
for i=1:size(polar,1)
    p1 = [polar(i,1:2:4),1];
    p2 = [polar(i,2:2:4),1];
    line_ABC = LineABC(p1',p2');
    polarABC = cat(1,polarABC,[polar(i,:), line_ABC']);
end

