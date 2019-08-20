function [polarH_sel, polarV_sel, polarZ_sel] = polarPartSel(part, ...
            polarH_LT,polarV_LT,polarZ_LT, ...
            polarH_LB,polarV_LB,polarZ_LB, ...
            polarH_RT,polarV_RT,polarZ_RT, ...
            polarH_RB,polarV_RB,polarZ_RB)
        
        
        
if part(1) == 1 && part(2) == 1 % Left-Top
    polarH_sel = polarH_LT;
    polarV_sel = polarV_LT;
    polarZ_sel = polarZ_LT;
elseif part(1) == 1 && part(2) == 2 % Right-Top
    polarH_sel = polarH_RT;
    polarV_sel = polarV_RT;
    polarZ_sel = polarZ_RT;
elseif part(1) == 2 && part(2) == 1 % Left-Bottom
    polarH_sel = polarH_LB;
    polarV_sel = polarV_LB;
    polarZ_sel = polarZ_LB;
else % Right-Bottom
    polarH_sel = polarH_RB;
    polarV_sel = polarV_RB;
    polarZ_sel = polarZ_RB;
end