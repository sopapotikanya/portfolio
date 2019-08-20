function [polarH_LT,polarV_LT,polarZ_LT, ...
    polarH_LB,polarV_LB,polarZ_LB, ...
    polarH_RT,polarV_RT,polarZ_RT, ...
    polarH_RB,polarV_RB,polarZ_RB, fig_SepVP] = sample1





polarHRelative = [ ...
    50, 50, 50, 100, 0, 0; ...
    ];

polarVRelative = [ ...
    50, 100, 50, 50, 0, 0; ...
    ];

polarZRelative = [ ...
    0, 50, 0, 50, 0, 0; ...
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
