function [M_all,Nm_all] = reflexPoint(P_all,typeMirror,varargin)


f = waitbar(0,'Please wait...');
    m = sym('m%d',[3,1]);
    if strcmp(typeMirror,'flat')
        Nm = varargin{1};
        mp = varargin{2};

        eqnMirror = Nm'*m == Nm'*mp;
        border = [-Inf,Inf; 0,Inf;-100,0];

        M_all = [];
        Nm_all = [];
        for i=1:size(P_all,1)
            waitbar(i/size(P_all,1),f,'Processing ...');
            [mx,my,mz] = reflexEachPoint(P_all(i,:)',eqnMirror,m,Nm,border);
            M_all = cat(1,M_all,[double(mx),double(my),double(mz)]);
            Nm_all = cat(1,Nm_all,Nm');
        end

        
    elseif strcmp(typeMirror,'sphere')
        centerSphere = varargin{1};
        r = varargin{2};

        eqnMirror = (m-centerSphere)'*(m-centerSphere) == r^2;
        Nm = (m-centerSphere)/norm(m-centerSphere);
        border = [-40,40;0,centerSphere(2)-5;-40,40];

        M_all = [];
        Nm_all = [];
        for i=1:size(P_all,1)
            waitbar(i/size(P_all,1),f,'Processing ...');
            [mx,my,mz] = reflexEachPoint(P_all(i,:)',eqnMirror,m,Nm,border);
            M_all = cat(1,M_all,[double(mx),double(my),double(mz)]);
            Nm_each = (M_all(i,1)'-centerSphere)/norm(M_all(i,1)'-centerSphere);
            Nm_all = cat(1,Nm_all,Nm_each');
        end

    end

waitbar(1,f,'Finishing');
close(f);
end

function [mx,my,mz] = reflexEachPoint(p,eqnMirror,m,Nm,border)
    syms theta
    eqnTheta = Nm'*m / norm(m) == Nm'* (m-p) / norm(m-p);
    eqnNp = Nm'* cross(p,m) == 0;
    eqnIgnore = m'*(m-p)/ (norm(m)*norm(m-p)) == theta; % must not same incident & reflex vector

    eqns = [eqnMirror,eqnTheta,eqnNp,eqnIgnore];

    [mx,my,mz,th] = vpasolve(eqns,[m;theta],[border;-0.999999,0.999999]);
    if isempty(th)
        mx = NaN;
        my = NaN;
        mz = NaN;
    end
end
