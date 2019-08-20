function lineLayoutShow(H1,H2,V1,V2, ...
    polarHRelative, polarVRelative, polarZRelative, ...
    widthH, widthV, minH, minV, ...
    vp_honz, vp_vert, vp_center, ...
    img, path_result,fileName)
% show
% figure;
% hold on
% for i=1:size(polarH,1)
%     plot(polarH(i,1:2)',polarH(i,3:4)','-g')
% end
% for i=1:size(polarV,1)
%     plot(polarV(i,1:2)',polarV(i,3:4)','-r')
% end
% for i=1:size(polarZ,1)
%     plot(polarZ(i,1:2)',polarZ(i,3:4)','-b')
% end
% hold off
% xlabel('honz')
% ylabel('vert')
% grid on


fig_polar = figure;
hold on
for i=1:size(polarHRelative,1)
    plot(polarHRelative(i,1:2)',polarHRelative(i,3:4)','-g')
end
for i=1:size(polarVRelative,1)
    plot(polarVRelative(i,1:2)',polarVRelative(i,3:4)','-r')
end
for i=1:size(polarZRelative,1)
    plot(polarZRelative(i,1:2)',polarZRelative(i,3:4)','-b')
end
if ~isempty(H1)
    % plot([H1;H1],edgeV(:,1)','-k')
    plot([H1;H1],[0; 100],'-k')
end
if ~isempty(H2)
    %     plot([H2;H2],edgeV(:,1)','-k')
    plot([H2;H2],[0; 100],'-k')
end
if ~isempty(V1)
    %     plot(edgeH(:,1)',[V1;V1],'-k')
    plot([0; 100],[V1;V1],'-k')
end
if ~isempty(V2)
    %     plot(edgeH(:,1)',[V2;V2],'-k')
    plot([0; 100],[V2;V2],'-k')
end
hold off
xlabel('honz')
ylabel('vert')
grid on
saveas(fig_polar,[path_result 'polar/' fileName '.png']);

%%
layout_T = []; layout_B = []; layout_R = []; layout_L = [];
if ~isempty(H1)
    layout_T = H1*widthH/100+minH;
    layout_T = convertLayoutT(layout_T,vp_honz,img);
end
if ~isempty(H2)
    layout_B = H2*widthH/100+minH;
    layout_B = convertLayoutB(layout_B,vp_honz,img);
end
if ~isempty(V1)
    layout_R = V1*widthV/100+minV;
    layout_R = convertLayoutL(layout_R,vp_vert,img);
end
if ~isempty(V2)
    layout_L = V2*widthV/100+minV;
    layout_L = convertLayoutR(layout_L,vp_vert,img);
end

fig_layout = figure;
imshow(img);
hold on
plotLayout(layout_L,layout_R,layout_T,layout_B,vp_center,img)
hold off
saveas(fig_layout,[path_result 'layout/' fileName '.png']);