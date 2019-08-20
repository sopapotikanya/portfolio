function plotSphere(centerSphere,r)
    [sphereX,sphereY,sphereZ] = sphere;
    surf(sphereX*r+centerSphere(1), sphereY*r+centerSphere(2), sphereZ*r+centerSphere(3),'FaceAlpha',0.5,'EdgeColor','none');
end