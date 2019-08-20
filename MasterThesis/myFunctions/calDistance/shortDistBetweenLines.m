function distLine = shortDistBetweenLines(L1P1,L1P2,L2P1,L2P2)
% shortDistBetweenLines(L1P1,L1P2,L2P1,L2P2)
%
% input :
%   L1P1 = start point (x,y,z) of Line1
%   L1P2 = end point (x,y,z) of Line1
%   L2P1 = start point (x,y,z) of Line2
%   L2P2 = end point (x,y,z) of Line2
%
% algorithm
% find distance between point to point
%     type1 = L1P1 & L2P1
%     type2 = L1P1 & L2P2
%     type3 = L1P2 & L2P1
%     type4 = L1P2 & L2P2
% find distance between point to line
%     type5 = L1P1 & L2
%     type6 = L1P2 & L2
%     type7 = L2P1 & L1
%     type8 = L2P2 & L1
% find distance between line to line    
%     type9 = L1 & L2
%
% output : 
%   distLine(type)

distLine(1) = DistP2P(L1P1,L2P1);
distLine(2) = DistP2P(L1P1,L2P2);
distLine(3) = DistP2P(L1P2,L2P1);
distLine(4) = DistP2P(L1P2,L2P2);
distLine(5) = shortDistP2L(L1P1,L2P1,L2P2);
distLine(6) = shortDistP2L(L1P2,L2P1,L2P2);
distLine(7) = shortDistP2L(L2P1,L1P1,L1P2);
distLine(8) = shortDistP2L(L2P2,L1P1,L1P2);
distLine(9) = shortDistL2L(L1P1,L1P2,L2P1,L2P2);


