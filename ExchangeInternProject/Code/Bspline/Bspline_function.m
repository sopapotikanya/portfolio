% example : create B-spline from 3 point by use function in matlab
clear 
close all

% x = [2 3 5];
% y = [4 3 7];
x = [0 0.5 1];
y = [0.5 1 0.5];
% x = [0 1 2];
% y = [0 1 2];
minX = min(x);
maxX = max(x);
minY = min(y);
maxY = max(y);
axisBound = [minX maxX minY maxY];
xx = linspace(minX,maxX,100);

%% spline
sp = csapi(x,y);
yy_sp = csapi(x,y,xx);
figure, plot(xx,yy_sp,'k-',x,y,'ro')
title('Interpolant to Three Points')
axis(axisBound)


%% B-spline

Bsp=fn2fm(sp,'B-');
yy_Bsp=fnval(Bsp,xx);
figure, fnplt(Bsp); 
% figure, plot(xx,yy_Bsp,'r*')
hold on


%% diff B-spline
Bsp_diff = fnder(Bsp);
yy_Bsp_diff=fnval(Bsp_diff,xx);
% fnplt(Bsp_diff);
% plot(xx,yy_Bsp_diff,'r.')
% figure, plot(yy_Bsp_diff(1,:),yy_Bsp_diff(2,:))
% axis(axisBound)

diff_x = linspace(minX,maxX,5);
diff_y = fnval(Bsp_diff,diff_x);

for i=1:5
    x = diff_x(i);
    y = fnval(Bsp,diff_x(i));
%     plot(x,y,'ko')
    text(x,y,['\leftarrow slope = ' num2str(diff_y(i))]);
end
title('Convert to B-spline, Diff B-spline');
hold off
%%
point1 = [0; 0];
point2 = [0; 1];
point3 = [1; 1];
point4 = [1; 0];
points = cat(2, point1, point2, point3, point4);
t_knot = [0, 0.167, 0.333, 0.5, 0.667, 0.833, 1];
% t_knot = [0, 0.2, 0.4, 0.5, 0.6, 0.8, 1];
bsp_orig1 = spmak(t_knot,points);

knots = Bsp.knots;
coefs = Bsp.coefs;
bsp_orig2 = spmak(knots,coefs); 

figure
plot(points(1,:),points(2,:),'ro'), hold on
fnplt(bsp_orig1)
fnplt(bsp_orig2)
axis equal square
title('B-spline')
hold off