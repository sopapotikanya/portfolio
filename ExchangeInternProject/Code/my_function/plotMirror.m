function plotMirror(point,normalVector,width,height)
v = normalVector';
x1 = point(1);
y1 = point(2);
z1 = point(3);
   w = null(v); % Find two orthonormal vectors which are orthogonal to v
   [P,Q] = meshgrid(width,height); % Provide a gridwork (you choose the size)
   X = x1+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
   Y = y1+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
   Z = z1+w(3,1)*P+w(3,2)*Q;
   surf(X,Y,Z,'FaceAlpha',0.5,'EdgeColor','none')
end