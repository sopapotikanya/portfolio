function [polar_left_bottom, polar_left_top, polar_right_bottom, polar_right_top] = separateLinesVPcenter(polar_all,centerHRelative,centerVRelative)
% Input : polarRelative = [x1,x2,y1,y2,z1,z2];



[polar_left, polar_right] = separateLinesVerticle(polar_all,centerHRelative);

[polar_left_bottom, polar_left_top] = separateLinesHorizontal(polar_left,centerVRelative);
[polar_right_bottom, polar_right_top] = separateLinesHorizontal(polar_right,centerVRelative);

testbug = 1;