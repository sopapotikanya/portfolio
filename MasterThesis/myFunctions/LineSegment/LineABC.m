function [line] = LineABC(v1,v2)

line = cross(v1,v2)/DistP2P(v1,v2);