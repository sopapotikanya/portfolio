clear
close all
typeMirror = 'sphere';
% typeMirror = 'flat';
oc = [0;0;0];
P_all=[];
pz = -80;
for px=-200:20:200
    for py=40:20:140
        P_all = cat(1,P_all,[px,py,pz]);
    end
end

if strcmp(typeMirror,'flat')            % flat mirror
    Nm  = [0; -1; 0];
    mp = [0; 150; 0];
    [M_all,Nm_all] = reflexPoint(P_all,typeMirror,Nm,mp);
elseif strcmp(typeMirror,'sphere')      % sphere mirror
    r = 50;
    centerSphere = [0;150;0];
    [M_all,Nm_all] = reflexPoint(P_all,typeMirror,centerSphere,r);
end



%%
figure, hold on
% -------- camera --------
plot3(oc(1),oc(2),oc(3),'*');
text(oc(1),oc(2),oc(3),' Oc');

% -------- mirror --------
if strcmp(typeMirror,'flat')
    plotMirror(mp,Nm,-100:100,min(P_all(:,3)):0);
elseif strcmp(typeMirror,'sphere')
    plotSphere(centerSphere,r);
end
    
% -------- point p --------
plot3(P_all(:,1),P_all(:,2),P_all(:,3),'*');

% -------- reflex point q --------
plot3(M_all(:,1),M_all(:,2),M_all(:,3),'*')

xlabel('x');
ylabel('y');
zlabel('z');
grid on
axis equal 
view(3)

%% image
focus = 10;
M_all_img = zeros(size(M_all));
for i=1:size(M_all,1)
    M_all_img(i,:) = focus*M_all(i,:)/M_all(i,2);
end
figure,scatter(M_all_img(:,1),M_all_img(:,3))
hold on

for i=1:6
    % spline
    x = M_all_img(i:6:end,1);
    y = M_all_img(i:6:end,3);
    sp(i) = spline(x,y);
    xx = linspace(min(x),max(x),100);
    yy_sp = csapi(x,y,xx);
    plot(xx,yy_sp,'k-')

    % B-spline
    Bsp(i)=fn2fm(sp(i),'B-');
    yy_Bsp=fnval(Bsp(i),x);

    % diff B-spline
    Bsp_diff(i) = fnder(Bsp(i));
    yy_Bsp_diff=fnval(Bsp_diff(i),x);

    % 2n diff B-spline
    Bsp_diff2(i) = fnder(Bsp_diff(i));
    yy_Bsp_diff2=fnval(Bsp_diff2(i),x);

%     for j=1:size(x,1)
%         text(x(j),y(j),['\leftarrow' num2str(yy_Bsp_diff(j),'%.2f') '/' num2str(yy_Bsp_diff2(j),'%.2f')]);
%     end
end
hold off

figure, hold on
for i=1:6
    fnplt(Bsp_diff(i));
end
figure, hold on
for i=1:6
    fnplt(Bsp_diff2(i));
end
