function fig = plotSepDiag(polarH_grid_DiagL, polarH_grid_DiagR, ...
    polarV_grid_DiagL, polarV_grid_DiagR, ...
    polarZ_grid_DiagL, polarZ_grid_DiagB, polarZ_grid_DiagR, ...
    inversAxis)
if ~inversAxis
    fig = figure;
    hold on
    if ~isempty(polarH_grid_DiagL), plot(polarH_grid_DiagL(:,1:2)',polarH_grid_DiagL(:,3:4)','-r'); end
    if ~isempty(polarV_grid_DiagL), plot(polarV_grid_DiagL(:,1:2)',polarV_grid_DiagL(:,3:4)','-r'); end
    if ~isempty(polarZ_grid_DiagL), plot(polarZ_grid_DiagL(:,1:2)',polarZ_grid_DiagL(:,3:4)','-r'); end

    if ~isempty(polarH_grid_DiagR), plot(polarH_grid_DiagR(:,1:2)',polarH_grid_DiagR(:,3:4)','-m'); end
    if ~isempty(polarV_grid_DiagR), plot(polarV_grid_DiagR(:,1:2)',polarV_grid_DiagR(:,3:4)','-m'); end
    if ~isempty(polarZ_grid_DiagR), plot(polarZ_grid_DiagR(:,1:2)',polarZ_grid_DiagR(:,3:4)','-m'); end

    if ~isempty(polarZ_grid_DiagB), plot(polarZ_grid_DiagB(:,1:2)',polarZ_grid_DiagB(:,3:4)','-c'); end
    axis([0 100 0 100]);
    grid on
else

    fig = figure;
    hold on
    if ~isempty(polarH_grid_DiagL), plot(polarH_grid_DiagL(:,3:4)',polarH_grid_DiagL(:,1:2)','-r'); end
    if ~isempty(polarV_grid_DiagL), plot(polarV_grid_DiagL(:,3:4)',polarV_grid_DiagL(:,1:2)','-r'); end
    if ~isempty(polarZ_grid_DiagL), plot(polarZ_grid_DiagL(:,3:4)',polarZ_grid_DiagL(:,1:2)','-r'); end

    if ~isempty(polarH_grid_DiagR), plot(polarH_grid_DiagR(:,3:4)',polarH_grid_DiagR(:,1:2)','-m'); end
    if ~isempty(polarV_grid_DiagR), plot(polarV_grid_DiagR(:,3:4)',polarV_grid_DiagR(:,1:2)','-m'); end
    if ~isempty(polarZ_grid_DiagR), plot(polarZ_grid_DiagR(:,3:4)',polarZ_grid_DiagR(:,1:2)','-m'); end

    if ~isempty(polarZ_grid_DiagB), plot(polarZ_grid_DiagB(:,3:4)',polarZ_grid_DiagB(:,1:2)','-c'); end
    axis([0 100 0 100]);
    grid on
    ax = gca;
    ax.XDir = 'reverse';
end