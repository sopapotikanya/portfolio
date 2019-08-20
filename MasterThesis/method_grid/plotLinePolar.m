function fig = plotLinePolar(polarH,polarV,polarZ, inversAxis)

if ~inversAxis
    fig = figure('units','normalized','outerposition',[0 0 1 1]); 
    hold on
    if ~isempty(polarH), plot(polarH(:,1:2)',polarH(:,3:4)','-r','LineWidth',2); end
    if ~isempty(polarV), plot(polarV(:,1:2)',polarV(:,3:4)','-g','LineWidth',2); end
    if ~isempty(polarZ), plot(polarZ(:,1:2)',polarZ(:,3:4)','-b','LineWidth',2); end
    hold off
    axis([0 100 0 100]);
    grid on

else

    fig = figure('units','normalized','outerposition',[0 0 1 1]); 
    hold on
    if ~isempty(polarH), plot(polarH(:,3:4)',polarH(:,1:2)','-r','LineWidth',2); end
    if ~isempty(polarV), plot(polarV(:,3:4)',polarV(:,1:2)','-g','LineWidth',2); end
    if ~isempty(polarZ), plot(polarZ(:,3:4)',polarZ(:,1:2)','-b','LineWidth',2); end
    hold off
    axis([0 100 0 100]);
    grid on
    ax = gca;
    ax.XDir = 'reverse';
end