function [polarH_LT,polarV_LT,polarZ_LT, ...
    polarH_LB,polarV_LB,polarZ_LB, ...
    polarH_RT,polarV_RT,polarZ_RT, ...
    polarH_RB,polarV_RB,polarZ_RB, fig_SepVP] = sample2





polarHRelative = [ ...
    40, 40, 50, 100, 0, 0; ...
    60, 60, 60, 100, 0, 0; ...
    ];

polarVRelative = [ ...
    60, 100, 60, 60, 0, 0; ...
    50, 100, 40, 40, 0, 0; ...
    ];

polarZRelative = [ ...
    0, 40, 100-50*100/60, 50, 0, 0; ...
   100-50*100/60, 50, 0, 40, 0, 0; ...
    ];
%% Line ABC
polarH = polarABC(polarHRelative);
polarV = polarABC(polarVRelative);
polarZ = polarABC(polarZRelative);

polarH_LB = polarH;
polarV_LB = polarV;
polarZ_LB = polarZ;

polarH_LT = [];
polarV_LT = [];
polarZ_LT = [];
polarH_RT = [];
polarV_RT = [];
polarZ_RT = [];
polarH_RB = [];
polarV_RB = [];
polarZ_RB = [];


fig_SepVP = plotSepVP(polarH_LT,polarV_LT,polarZ_LT, ...
    polarH_LB,polarV_LB,polarZ_LB, ...
    polarH_RT,polarV_RT,polarZ_RT, ...
    polarH_RB,polarV_RB,polarZ_RB, ...
    false);
