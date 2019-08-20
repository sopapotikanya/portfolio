% close all
no_ray = 10;
SetY = [];
C = nchoosek(1:no_ray+2,2);
for i=1:size(C,1)
    for j=1:size(C,1)
        SetY = cat(1,SetY,[C(i,:),C(j,:)]);
    end
end


load('/Users/sopapotikanya/Documents/MATLAB/floorplan2/Database/sample/imgTypeAll.mat')
DB_type = 'HedauDB';
imdir=['../../Database/' DB_type '/Images/'];
labeldir=['../../Database/' DB_type '/label/'];
load(['../../Database/' DB_type '/Allvpdata.mat']);
patterns = {} ;
labels = {} ;

% 36, 58, 95, 101, 102, 107, 108, 109, 117, 153, 297
imgnums = [36, 58, 95, 101, 102, 107, 108, 109, 117, 153, 297];
for i=1:size(imgnums,2)
    imgnum = imgnums(i);
    imagename = imgTypeAll(imgnum).imname;
    fileName = imagename(1,1:end-4);
    lines = Allvpdata(imgnum).lines;
    linemem = Allvpdata(imgnum).linemem;
    VP = Allvpdata(imgnum).vp;
    sizeImg = Allvpdata(imgnum).dim;
    patterns{i} = {lines,linemem,VP};
    
    load([labeldir fileName '_labels.mat'],'gtPolyg','fields'); % fields, gtPolyg, labels
    [indices, setH, setV, disH, disV] = mapLayout(gtPolyg,VP,no_ray,sizeImg,fields);
    label = ones(size(SetY,1),1).*(-1);
    label(indices) = 1;
    labels{i} = label;
    
%     img = imread([imdir imagename]);
%     imshow(img,'DisplayRange',[])
%     hold on
%     disH = sort(disH);
%     disV = sort(disV);
%     for j=1:size(setH,1)
%         pointH(j,1:2) = polar2point(setH(j),disH(1),vp_honz);
%         pointH(j,3:4) = polar2point(setH(j),disH(end),vp_honz);
%         plot(pointH(j,1:2:4),pointH(j,2:2:4),'-')
%     end
%     
%     for j=1:size(setV,1)
%         pointV(j,1:2) = polar2point(setV(j),disV(1),vp_vert);
%         pointV(j,3:4) = polar2point(setV(j),disV(end),vp_vert);
%         plot(pointV(j,1:2:4),pointV(j,2:2:4),'-')
%     end
    
    
    
end

% ------------------------------------------------------------------
%                                                    Run SVM struct
% ------------------------------------------------------------------

parm.patterns = patterns ;
parm.labels = labels ;
parm.lossFn = @lossCB ;
parm.constraintFn  = @constraintCB ;
parm.featureFn = @featureCB ;
parm.dimension = 2 ;
parm.verbose = 1 ;
model = svm_struct_learn(' -c 1.0 -o 1 -v 1 ', parm) ;
w = model.w ;


% ------------------------------------------------------------------
%                                               SVM struct callbacks
% ------------------------------------------------------------------

function delta = lossCB(param, y, ybar)
    testbug = 1;
    delta =1;
%   delta = double(y ~= ybar) ;
%   if param.verbose
%     fprintf('delta = loss(%3d, %3d) = %f\n', y, ybar, delta) ;
%   end
end

function psi = featureCB(param, x, y)
    testbug = 1;
    psi = 1;
%   imgnum = x;
%   lines = Allvpdata(imgnum).lines;
%   linemem = Allvpdata(imgnum).linemem;
%   VP = Allvpdata(imgnum).vp;
% 
% 
%   psi = sparse(y*x/2) ;
%   if param.verbose
%     fprintf('w = psi([%8.3f,%8.3f], %3d) = [%8.3f, %8.3f]\n', ...
%             x, y, full(psi(1)), full(psi(2))) ;
%   end
end

function yhat = constraintCB(param, model, x, y)
% slack resaling: argmax_y delta(yi, y) (1 + <psi(x,y), w> - <psi(x,yi), w>)
% margin rescaling: argmax_y delta(yi, y) + <psi(x,y), w>
    testbug = 1;
    yhat = 1;
%   if dot(y*x, model.w) > 1, yhat = y ; else yhat = - y ; end
%   if param.verbose
%     fprintf('yhat = violslack([%8.3f,%8.3f], [%8.3f,%8.3f], %3d) = %3d\n', ...
%             model.w, x, y, yhat) ;
%   end
end