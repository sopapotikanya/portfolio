function fig = plotSep3PT(polarH_LT,polarV_LT,polarZ_LT, ...
    polarH_LB,polarV_LB,polarZ_LB, ...
    polarH_RT,polarV_RT,polarZ_RT, ...
    polarH_RB,polarV_RB,polarZ_RB, ...
    g1_H, g1_V, g1_Z, ...
    g2_H, g2_V, g2_Z, ...
    g3_H, g3_V, g3_Z, ...
    through_12, through_13, through_23, ...
    selPoint, inversAxis)
if ~inversAxis
    fig = figure;
    hold on

    if ~isempty(polarH_LT), plot(polarH_LT(:,1:2)',polarH_LT(:,3:4)','-k'); end
    if ~isempty(polarV_LT), plot(polarV_LT(:,1:2)',polarV_LT(:,3:4)','-k'); end
    if ~isempty(polarZ_LT), plot(polarZ_LT(:,1:2)',polarZ_LT(:,3:4)','-k'); end
    if ~isempty(polarH_LB), plot(polarH_LB(:,1:2)',polarH_LB(:,3:4)','-k'); end
    if ~isempty(polarV_LB), plot(polarV_LB(:,1:2)',polarV_LB(:,3:4)','-k'); end
    if ~isempty(polarZ_LB), plot(polarZ_LB(:,1:2)',polarZ_LB(:,3:4)','-k'); end
    if ~isempty(polarH_RT), plot(polarH_RT(:,1:2)',polarH_RT(:,3:4)','-k'); end
    if ~isempty(polarV_RT), plot(polarV_RT(:,1:2)',polarV_RT(:,3:4)','-k'); end
    if ~isempty(polarZ_RT), plot(polarZ_RT(:,1:2)',polarZ_RT(:,3:4)','-k'); end
    if ~isempty(polarH_RB), plot(polarH_RB(:,1:2)',polarH_RB(:,3:4)','-k'); end
    if ~isempty(polarV_RB), plot(polarV_RB(:,1:2)',polarV_RB(:,3:4)','-k'); end
    if ~isempty(polarZ_RB), plot(polarZ_RB(:,1:2)',polarZ_RB(:,3:4)','-k'); end

    if ~isempty(g1_H), plot(g1_H(:,1:2)',g1_H(:,3:4)','-r'); end
    if ~isempty(g1_V), plot(g1_V(:,1:2)',g1_V(:,3:4)','-r'); end
    if ~isempty(g1_Z), plot(g1_Z(:,1:2)',g1_Z(:,3:4)','-r'); end

    if ~isempty(g2_H), plot(g2_H(:,1:2)',g2_H(:,3:4)','-g'); end
    if ~isempty(g2_V), plot(g2_V(:,1:2)',g2_V(:,3:4)','-g'); end
    if ~isempty(g2_Z), plot(g2_Z(:,1:2)',g2_Z(:,3:4)','-g'); end

    if ~isempty(g3_H), plot(g3_H(:,1:2)',g3_H(:,3:4)','-b'); end
    if ~isempty(g3_V), plot(g3_V(:,1:2)',g3_V(:,3:4)','-b'); end
    if ~isempty(g3_Z), plot(g3_Z(:,1:2)',g3_Z(:,3:4)','-b'); end
    
    if ~isempty(through_12), plot(through_12(:,1:2)',through_12(:,3:4)','-m'); end
    if ~isempty(through_13), plot(through_13(:,1:2)',through_13(:,3:4)','-m'); end
    if ~isempty(through_23), plot(through_23(:,1:2)',through_23(:,3:4)','-m'); end
    
    plot(selPoint(1),selPoint(2),'*k');
    
    hold off
    axis([0 100 0 100]);
    grid on

else

    fig = figure;
    hold on

    if ~isempty(polarH_LT), plot(polarH_LT(:,3:4)',polarH_LT(:,1:2)','-k'); end
    if ~isempty(polarV_LT), plot(polarV_LT(:,3:4)',polarV_LT(:,1:2)','-k'); end
    if ~isempty(polarZ_LT), plot(polarZ_LT(:,3:4)',polarZ_LT(:,1:2)','-k'); end
    if ~isempty(polarH_LB), plot(polarH_LB(:,3:4)',polarH_LB(:,1:2)','-k'); end
    if ~isempty(polarV_LB), plot(polarV_LB(:,3:4)',polarV_LB(:,1:2)','-k'); end
    if ~isempty(polarZ_LB), plot(polarZ_LB(:,3:4)',polarZ_LB(:,1:2)','-k'); end
    if ~isempty(polarH_RT), plot(polarH_RT(:,3:4)',polarH_RT(:,1:2)','-k'); end
    if ~isempty(polarV_RT), plot(polarV_RT(:,3:4)',polarV_RT(:,1:2)','-k'); end
    if ~isempty(polarZ_RT), plot(polarZ_RT(:,3:4)',polarZ_RT(:,1:2)','-k'); end
    if ~isempty(polarH_RB), plot(polarH_RB(:,3:4)',polarH_RB(:,1:2)','-k'); end
    if ~isempty(polarV_RB), plot(polarV_RB(:,3:4)',polarV_RB(:,1:2)','-k'); end
    if ~isempty(polarZ_RB), plot(polarZ_RB(:,3:4)',polarZ_RB(:,1:2)','-k'); end

    if ~isempty(g1_H), plot(g1_H(:,3:4)',g1_H(:,1:2)','-r'); end
    if ~isempty(g1_V), plot(g1_V(:,3:4)',g1_V(:,1:2)','-r'); end
    if ~isempty(g1_Z), plot(g1_Z(:,3:4)',g1_Z(:,1:2)','-r'); end

    if ~isempty(g2_H), plot(g2_H(:,3:4)',g2_H(:,1:2)','-g'); end
    if ~isempty(g2_V), plot(g2_V(:,3:4)',g2_V(:,1:2)','-g'); end
    if ~isempty(g2_Z), plot(g2_Z(:,3:4)',g2_Z(:,1:2)','-g'); end

    if ~isempty(g3_H), plot(g3_H(:,3:4)',g3_H(:,1:2)','-b'); end
    if ~isempty(g3_V), plot(g3_V(:,3:4)',g3_V(:,1:2)','-b'); end
    if ~isempty(g3_Z), plot(g3_Z(:,3:4)',g3_Z(:,1:2)','-b'); end
    
    if ~isempty(through_12), plot(through_12(:,3:4)',through_12(:,1:2)','-c'); end
    if ~isempty(through_13), plot(through_13(:,3:4)',through_13(:,1:2)','-c'); end
    if ~isempty(through_23), plot(through_23(:,3:4)',through_23(:,1:2)','-c'); end
    plot(selPoint(2),selPoint(1),'*k');
    hold off
    axis([0 100 0 100]);
    grid on
    ax = gca;
    ax.XDir = 'reverse';
end