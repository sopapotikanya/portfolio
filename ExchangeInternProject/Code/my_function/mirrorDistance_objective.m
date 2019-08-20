function d = mirrorDistance_objective(S,Oc,p,OQ_vect)
Xm = OQ_vect*S;
d = norm(Xm - p) + norm(p - Oc);
end