% example : create B-spline from 3 point by solve manualy
clear
close all

% point1 = [0; 4];
% point2 = [4; 4];
% point3 = [4; 0];
% point4 = [2; 2];

point1 = [0; 0];
point2 = [0; 1];
point3 = [1; 1];
point4 = [1; 0];

pointAll = cat(2, point1, point2, point3, point4);
n = size(pointAll,2);
k = 3;

% t_knot = [0, 0.2, 0.4, 0.5, 0.6, 0.8, 1];
t_knot = [0, 0.167, 0.333, 0.5, 0.667, 0.833, 1];

figure,
hold on
plot(point1(1,1),point1(2,1),'*');
plot(point2(1,1),point2(2,1),'*');
plot(point3(1,1),point3(2,1),'*');
plot(point4(1,1),point4(2,1),'*');

step = 0.001;
for t=t_knot(k):step:t_knot(n+1)
    y = basicFuncKn(1,k,t,t_knot).*point1 + ...
        basicFuncKn(2,k,t,t_knot).*point2 + ...
        basicFuncKn(3,k,t,t_knot).*point3 + ...
        basicFuncKn(4,k,t,t_knot).*point4;
    plot(y(1,1),y(2,1),'.');
end

function result = basicFuncKn(i,k,t,t_knot)
    if k == 1
        if t_knot(i) <= t && t < t_knot(i+1)
            result = 1;
        else
            result = 0;
        end
    else
        result = basicFuncKn(i,k-1,t,t_knot)*(t - t_knot(i))/(t_knot(i+k-1) - t_knot(i)) + ...
            basicFuncKn(i+1,k-1,t,t_knot)*(t_knot(i+k) - t)/(t_knot(i+k) - t_knot(i+1));
        
    end
end

