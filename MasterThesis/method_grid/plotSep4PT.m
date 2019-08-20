function fig = plotSep4PT(polarH_LT,polarV_LT,polarZ_LT, ...
    polarH_LB,polarV_LB,polarZ_LB, ...
    polarH_RT,polarV_RT,polarZ_RT, ...
    polarH_RB,polarV_RB,polarZ_RB, ...
    polarH_grid_LT,polarV_grid_LT,polarZ_grid_LT, ...
    polarH_grid_LB,polarV_grid_LB,polarZ_grid_LB, ...
    polarH_grid_RT,polarV_grid_RT,polarZ_grid_RT, ...
    polarH_grid_RB,polarV_grid_RB,polarZ_grid_RB, ...
    inversAxis)
if ~inversAxis
    fig = figure; 
    hold on
    % etc
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

    % select area
    if ~isempty(polarH_grid_LT), plot(polarH_grid_LT(:,1:2)',polarH_grid_LT(:,3:4)','-r'); end
    if ~isempty(polarV_grid_LT), plot(polarV_grid_LT(:,1:2)',polarV_grid_LT(:,3:4)','-r'); end
    if ~isempty(polarZ_grid_LT), plot(polarZ_grid_LT(:,1:2)',polarZ_grid_LT(:,3:4)','-r'); end

    if ~isempty(polarH_grid_LB), plot(polarH_grid_LB(:,1:2)',polarH_grid_LB(:,3:4)','-g'); end
    if ~isempty(polarV_grid_LB), plot(polarV_grid_LB(:,1:2)',polarV_grid_LB(:,3:4)','-g'); end
    if ~isempty(polarZ_grid_LB), plot(polarZ_grid_LB(:,1:2)',polarZ_grid_LB(:,3:4)','-g'); end

    if ~isempty(polarH_grid_RT), plot(polarH_grid_RT(:,1:2)',polarH_grid_RT(:,3:4)','-b'); end
    if ~isempty(polarV_grid_RT), plot(polarV_grid_RT(:,1:2)',polarV_grid_RT(:,3:4)','-b'); end
    if ~isempty(polarZ_grid_RT), plot(polarZ_grid_RT(:,1:2)',polarZ_grid_RT(:,3:4)','-b'); end

    if ~isempty(polarH_grid_RB), plot(polarH_grid_RB(:,1:2)',polarH_grid_RB(:,3:4)','-y'); end
    if ~isempty(polarV_grid_RB), plot(polarV_grid_RB(:,1:2)',polarV_grid_RB(:,3:4)','-y'); end
    if ~isempty(polarZ_grid_RB), plot(polarZ_grid_RB(:,1:2)',polarZ_grid_RB(:,3:4)','-y'); end

    hold off
    axis([0 100 0 100]);
    grid on
else


    fig = figure; 
    hold on
    % etc
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

    % select area
    if ~isempty(polarH_grid_LT), plot(polarH_grid_LT(:,3:4)',polarH_grid_LT(:,1:2)','-r'); end
    if ~isempty(polarV_grid_LT), plot(polarV_grid_LT(:,3:4)',polarV_grid_LT(:,1:2)','-r'); end
    if ~isempty(polarZ_grid_LT), plot(polarZ_grid_LT(:,3:4)',polarZ_grid_LT(:,1:2)','-r'); end

    if ~isempty(polarH_grid_LB), plot(polarH_grid_LB(:,3:4)',polarH_grid_LB(:,1:2)','-g'); end
    if ~isempty(polarV_grid_LB), plot(polarV_grid_LB(:,3:4)',polarV_grid_LB(:,1:2)','-g'); end
    if ~isempty(polarZ_grid_LB), plot(polarZ_grid_LB(:,3:4)',polarZ_grid_LB(:,1:2)','-g'); end

    if ~isempty(polarH_grid_RT), plot(polarH_grid_RT(:,3:4)',polarH_grid_RT(:,1:2)','-b'); end
    if ~isempty(polarV_grid_RT), plot(polarV_grid_RT(:,3:4)',polarV_grid_RT(:,1:2)','-b'); end
    if ~isempty(polarZ_grid_RT), plot(polarZ_grid_RT(:,3:4)',polarZ_grid_RT(:,1:2)','-b'); end

    if ~isempty(polarH_grid_RB), plot(polarH_grid_RB(:,3:4)',polarH_grid_RB(:,1:2)','-y'); end
    if ~isempty(polarV_grid_RB), plot(polarV_grid_RB(:,3:4)',polarV_grid_RB(:,1:2)','-y'); end
    if ~isempty(polarZ_grid_RB), plot(polarZ_grid_RB(:,3:4)',polarZ_grid_RB(:,1:2)','-y'); end

    hold off
    axis([0 100 0 100]);
    grid on
    ax = gca;
    ax.XDir = 'reverse';
end