function [feat_avg, feat_sum,num,theta_ind]= txfmImg(feat_img,vp,interp,quantsiz,avg_max)
% txfmImg Given a (feature)image, transform it frontal w.r.t directions of
% given pair of vanishing points. This is done by indexing each pixel of the original image by the 
%angle(theta 1, theta 2) it subtends at each vanishing point. 
% INPUT:
%   feat_img - feature image 
%    vp- vanishing points w.r.t which rectification has to be done
%    interp-use interpolation
%    quantsiz - quantization, size of rectified image
%    avg_max - use average or max.

%OUTPUT:
% feat_avg, feat_sum - transformed feature images (size theta 1 X theta 2)
% num- number of pixels in orginal image with the given value of theta 1, theta 2
% theta_ind - angles subtended at vanishing points. 

%For more details check [2] Varsha Hedau, Derek Hoiem, David Forsyth, Thinking Inside the Box:
%    Using Appearance Models and Context Based on Room Geometry, ECCV 2010.

if ~exist('quantsiz','var')
    quantsiz=500;
end

if ~exist('avg_max','var')
    avg_max=1;
end

[h w numk]=size(feat_img);
imcor=[0 h+1;0 0;w+1 0;w+1 h+1];
[xs,ys] = meshgrid(1:w,1:h);
inim = vp(:,1)>=1 & vp(:,1)<=w & vp(:,2)>=1 & vp(:,2)<=h;



for vno=1:2
    if ~inim(vno)
        ll1=[vp(vno,1) imcor(1,1) vp(vno,2) imcor(1,2)];
        ll2=[vp(vno,1) imcor(2,1) vp(vno,2) imcor(2,2)];
        ll3=[vp(vno,1) imcor(3,1) vp(vno,2) imcor(3,2)];
        ll4=[vp(vno,1) imcor(4,1) vp(vno,2) imcor(4,2)];
        lla=[ll1;ll1;ll1;ll2;ll2;ll3];
        llb=[ll2;ll3;ll4;ll3;ll4;ll4];
        
        veca = lla(:,[2,4])-lla(:,[1,3]);
        vecb = llb(:,[2,4])-llb(:,[1,3]);
        norma=(sum(veca.*veca,2)).^.5;
        normb=(sum(vecb.*vecb,2)).^.5;
        theta = acosd(dot(veca,vecb,2)./norma./normb);
        [vv ii]=max(theta);
        
        veca = veca(ii,:);
        vecb = vecb(ii,:);
        norma = norma(ii);
        normb = normb(ii);
        
        vecs = [xs(:)-vp(vno,1) ys(:)-vp(vno,2)];
        norms = (sum(vecs.*vecs,2)).^0.5;
        
        th_ref{vno} = atan2(veca(2),veca(1));
        thetas{vno} = reshape(acosd((vecs * veca')./norms./norma),h,w);
        theta_ind{vno} = thetas{vno}*quantsiz/theta(ii) + 1;
        pivotang{vno} = theta(ii);
        
        
    else
        vecs = [xs(:)-vp(vno,1) ys(:)-vp(vno,2)];
        norms = (sum(vecs.*vecs,2)).^0.5;
        if vno==1
            veca=[vp(2,1)-vp(vno,1) vp(2,2)-vp(vno,2)];
        else
            veca=[vp(1,1)-vp(vno,1) vp(1,2)-vp(vno,2)];
        end
        
        th_ref{vno} = atan2(veca(2),veca(1));
        mat_ref = [cos(th_ref{vno}) sin(th_ref{vno});-sin(th_ref{vno}) cos(th_ref{vno})];
        vecs = mat_ref * vecs';
        thetas{vno} = reshape(atan2(vecs(2,:),vecs(1,:)) * 180/pi,h,w);
        tempinds = find(thetas{vno}<0);
        thetas{vno}(tempinds) = thetas{vno}(tempinds)+360;
        theta_ind{vno} = thetas{vno}*quantsiz/360 + 1;
        pivotang{vno} = 360;
        
    end
    theta_ind{vno} = round(theta_ind{vno});
    pivot_vec{vno} = veca;
end

if ~interp

    feat_sum = zeros(quantsiz+2,quantsiz+2);
    inds = sub2ind(size(feat_sum),theta_ind{1},theta_ind{2});
    S_feat=sparse([1:h*w],inds(:),feat_img(:),h*w,prod(size(feat_sum)));
    S_num=sparse([1:h*w],inds(:),ones(size(inds(:))),h*w,prod(size(feat_sum)));
    
    if avg_max==1
        feat_sum = full(sum(S_feat,1));
        num = full(sum(S_num,1));
        feat_avg = feat_sum./(num+(num==0));
        feat_sum=reshape(feat_sum,quantsiz+2,quantsiz+2);
        feat_avg=reshape(feat_avg,quantsiz+2,quantsiz+2);
        num=reshape(num,quantsiz+2,quantsiz+2);
        
    else
        %use feat_sum in this case
        feat_sum = full(max(S_feat,[],1));
        feat_avg =[];
        % feat_sum=reshape(feat_sum,max(theta_ind{1}(:)),max(theta_ind{2}(:)));
        feat_sum=reshape(feat_sum,quantsiz+2,quantsiz+2);
        num=[];
    end
    
else
    clear vecs
    
    p = [50,50];
    for vno=1:2
        veca = pivot_vec{vno};
        vecb = p-vp(vno,:);
        th = acos(dot(veca,vecb)/norm(veca)/norm(vecb));
        mat_ref = [cos(th_ref{vno}) -sin(th_ref{vno});sin(th_ref{vno}) cos(th_ref{vno})];
        signs = [1 1;1 -1;-1 -1;-1 1];
        signvecs = (mat_ref*(signs.*repmat([cos(th) sin(th)],4,1))')';
        refvec = vecb/norm(vecb);
        [vv,ii] = min(sum((signvecs - repmat(refvec,4,1)).^2,2));
        corr_sign = signs(ii,:);
        th_inds{vno} = [1:max(theta_ind{vno}(:))]';
        ths{vno} = (th_inds{vno}-1)*pivotang{vno}/quantsiz;
        ths{vno} = ths{vno}*pi/180;
        temp_vecs = (mat_ref * (repmat(corr_sign',1,length(ths{vno})).*[cos(ths{vno}');sin(ths{vno}')]))';
        rays{vno}(:,2) = norm(vecb)*temp_vecs(:,1)+vp(vno,1);
        rays{vno}(:,4) = norm(vecb)*temp_vecs(:,2)+vp(vno,2);
        rays{vno}(:,1) = vp(vno,1);
        rays{vno}(:,3) = vp(vno,2);
        vecs{vno} = temp_vecs;
    end
    [uu,vv] = meshgrid(1:length(ths{2}),1:length(ths{1}));
    [xint,yint] = IntersectLines(rays{1}(vv(:),:),rays{2}(uu(:),:));
    validinds = (sign(xint-vp(1,1))==sign(vecs{1}(vv(:),1))) & ...
        (sign(xint-vp(2,1))==sign(vecs{2}(uu(:),1))) & ...
        (sign(yint-vp(1,2))==sign(vecs{1}(vv(:),2))) & ...
        (sign(yint-vp(2,2))==sign(vecs{2}(uu(:),2))) & ...
        xint>=1 & xint<=w & yint>=1 & yint<=h;
    
    [xx,yy] = meshgrid(1:w,1:h);
    vals = interp2(xx,yy,feat_img,xint(validinds),yint(validinds));
    txfm_img = zeros(size(uu));
    txfm_img(validinds) = vals;
    feat_avg=txfm_img;
    
    feat_sum=[];
    num=[];
    theta_ind=[];
end
