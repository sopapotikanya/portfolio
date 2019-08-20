function fig = plotSepVP(polarH_LT,polarV_LT,polarZ_LT, ...
    polarH_LB,polarV_LB,polarZ_LB, ...
    polarH_RT,polarV_RT,polarZ_RT, ...
    polarH_RB,polarV_RB,polarZ_RB, ...
    inversAxis)

if ~inversAxis
    fig = figure; 
    hold on
    if ~isempty(polarH_LT), plot(polarH_LT(:,1:2)',polarH_LT(:,3:4)','-r'); end
    if ~isempty(polarV_LT), plot(polarV_LT(:,1:2)',polarV_LT(:,3:4)','-r'); end
    if ~isempty(polarZ_LT), plot(polarZ_LT(:,1:2)',polarZ_LT(:,3:4)','-r'); end

    if ~isempty(polarH_LB), plot(polarH_LB(:,1:2)',polarH_LB(:,3:4)','-g'); end
    if ~isempty(polarV_LB), plot(polarV_LB(:,1:2)',polarV_LB(:,3:4)','-g'); end
    if ~isempty(polarZ_LB), plot(polarZ_LB(:,1:2)',polarZ_LB(:,3:4)','-g'); end

    if ~isempty(polarH_RT), plot(polarH_RT(:,1:2)',polarH_RT(:,3:4)','-b'); end
    if ~isempty(polarV_RT), plot(polarV_RT(:,1:2)',polarV_RT(:,3:4)','-b'); end
    if ~isempty(polarZ_RT), plot(polarZ_RT(:,1:2)',polarZ_RT(:,3:4)','-b'); end

    if ~isempty(polarH_RB), plot(polarH_RB(:,1:2)',polarH_RB(:,3:4)','-y'); end
    if ~isempty(polarV_RB), plot(polarV_RB(:,1:2)',polarV_RB(:,3:4)','-y'); end
    if ~isempty(polarZ_RB), plot(polarZ_RB(:,1:2)',polarZ_RB(:,3:4)','-y'); end
    hold off
    axis([0 100 0 100]);
    grid on

else

    fig = figure; 
    hold on
    if ~isempty(polarH_LT), plot(polarH_LT(:,3:4)',polarH_LT(:,1:2)','-r'); end
    if ~isempty(polarV_LT), plot(polarV_LT(:,3:4)',polarV_LT(:,1:2)','-r'); end
    if ~isempty(polarZ_LT), plot(polarZ_LT(:,3:4)',polarZ_LT(:,1:2)','-r'); end

    if ~isempty(polarH_LB), plot(polarH_LB(:,3:4)',polarH_LB(:,1:2)','-g'); end
    if ~isempty(polarV_LB), plot(polarV_LB(:,3:4)',polarV_LB(:,1:2)','-g'); end
    if ~isempty(polarZ_LB), plot(polarZ_LB(:,3:4)',polarZ_LB(:,1:2)','-g'); end

    if ~isempty(polarH_RT), plot(polarH_RT(:,3:4)',polarH_RT(:,1:2)','-b'); end
    if ~isempty(polarV_RT), plot(polarV_RT(:,3:4)',polarV_RT(:,1:2)','-b'); end
    if ~isempty(polarZ_RT), plot(polarZ_RT(:,3:4)',polarZ_RT(:,1:2)','-b'); end

    if ~isempty(polarH_RB), plot(polarH_RB(:,3:4)',polarH_RB(:,1:2)','-y'); end
    if ~isempty(polarV_RB), plot(polarV_RB(:,3:4)',polarV_RB(:,1:2)','-y'); end
    if ~isempty(polarZ_RB), plot(polarZ_RB(:,3:4)',polarZ_RB(:,1:2)','-y'); end
    hold off
    axis([0 100 0 100]);
    grid on
    ax = gca;
    ax.XDir = 'reverse';
end