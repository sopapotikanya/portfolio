close all
clear
load('/Users/sopapotikanya/Downloads/predictions_normals_vgg.mat')
addpaths;
% normal = normals(:,:,:,500);
% figure,imshow(normal);
% 
% [m, n, c] = size(normal);
% listNormal = [];
% listIDX = [];
% for i=1:m
%     for j=1:n
%         if i==240&&j==255
%             testbug = 1;
%         end
%         listIDX = cat(1,listIDX,[i,j]);
%         listNormal = cat(1,listNormal,[normal(i,j,1),normal(i,j,2),normal(i,j,3)]);
%     end
% end
% 
% 
% [idx,C,sumd,D] = kmeans(double(listNormal),3);
% 
% normalDiff = zeros(m,n);
% for i=1:size(listNormal,1)
%     normalDiff(listIDX(i,1),listIDX(i,2)) = idx(i,1);
% end
% figure,imagesc(normalDiff);
% 
% D1 = D(idx==1,1);
% D2 = D(idx==2,2);
% D3 = D(idx==3,3);
% normalDiff1 = normalDiff(:,:,1)==1;
% normalDiff2 = normalDiff(:,:,1)==2;
% normalDiff3 = normalDiff(:,:,1)==3;
% 
% figure, imshow(normalDiff1);
% 
% stats = regionprops(normalDiff1,'all');
% 
% 
% 
% 
% vp1 = [700,-200];
% hold on
% plot(vp1(1),vp1(2),'*r');
% corner = [148,118;166,192;244,228;247,141];
% for i=1:4
% plot([vp1(1);corner(i,1)],[vp1(2);corner(i,2)],'*-r');
% end
% 
% listPolar = [];
% for i=1:size(listNormal,1)
%     [angleD, dis] = point2polar(listIDX(i,:),vp1);
%     listPolar = cat(1,listPolar,[angleD, dis]);
% end
% 
% listPolar1 = listPolar(idx == 1,:);
% 
% cornerPolar = [];
% for i=1:size(corner,1)
%     [angleD, dis] = point2polar(corner(i,:),vp1);
%     cornerPolar = cat(1,cornerPolar,[angleD, dis]);
% end
% 
% % for i=1:length(stats)
% %     if stats(i).Area > 100
% %         convx = stats(i).ConvexHull;
% %         disMin = 99999;
% %         for j=1:length(convx)
% %             [angleD, dis] = point2polar(convx(j,:),vp1);
% %             disMin = dis
% %         end
% % 
% %     end
% % end


addpath('/Users/sopapotikanya/Documents/MATLAB/floorplan2/Code/svm-struct-matlab-master')
VPs_manual = [470,128,160,5000,109,119; ...
    213,105,160,5000,-100,110; ...
	320,120,160,5000,-5000,120; ...
	5000,120,160,5000,216,127; ...
	5000,120,160,5000,149,132; ...
	206,121,160,5000,70,135; ...
    ];
labels_manual = {[],[227,46],[220,202],[]; ...
    [],[63,52],[64,207],[]; ...
    [],[250,52],[250,167],[]; ...
    [88,41],[],[],[88,204]; ...
    [133,100],[165,102],[165,164],[133,164]; ...
    [],[89,94],[89,175],[]; ...
    };

load polyG2.mat
for i=1:6
    normal = normals(:,:,:,i);
    vp(1,:) = VPs_manual(i,1:2);
    vp(2,:) = VPs_manual(i,3:4);
    vp(3,:) = VPs_manual(i,5:6);
    [h,w, ~] = size(normal);
    imshow(normal);
    hold on
    nsamp = 10;
    [layout] = getLayouts(vp,h,w,nsamp);

    [ polyg] = getLayoutsPolyG( vp,h,w);
    patterns{i} = {normal,vp,polyg};
    subplot(2,3,i),imshow(normal)
    labels{i} = {polyG{i,:}};
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
parm.gt = {1,2,3,4,5};
% parm.verbose = 1 ;
model = svm_struct_learn(' -c 1.0 -o 1 -v 1 ', parm) ;
% w = model.w ;


% ------------------------------------------------------------------
%                                               SVM struct callbacks
% ------------------------------------------------------------------

function delta = lossCB(param, y, ybar)
%   delta = double(y ~= ybar) ;
%   if param.verbose
%     fprintf('delta = loss(%3d, %3d) = %f\n', y, ybar, delta) ;
%   end
delta = 1;
end

function psi = featureCB(param, x, y)
%   psi = sparse(y*x/2) ;
%   if param.verbose
%     fprintf('w = psi([%8.3f,%8.3f], %3d) = [%8.3f, %8.3f]\n', ...
%             x, y, full(psi(1)), full(psi(2))) ;
%   end


img = x{1};
[m,n,~] = size(img);
img1 = img(:,:,1);
img2 = img(:,:,2);
img3 = img(:,:,3);

psi = sparse(5,1);
% ceil
if ~isempty(y{1})
    BW = poly2mask(y{1}(:,1),y{1}(:,2),m,n);
    psi(1,1) = sum(255 - img3(BW==1))/sum(sum(BW.*255));
end

% floor
if ~isempty(y{2})
    BW = poly2mask(y{2}(:,1),y{2}(:,2),m,n);
    psi(2,1) = sum(img3(BW==1))/sum(sum(BW.*255));
end

% left wall
if ~isempty(y{3})
    BW = poly2mask(y{3}(:,1),y{3}(:,2),m,n);
    psi(3,1) = sum(img1(BW==1))/sum(sum(BW.*255));
end
% middle wall
if ~isempty(y{4})
    BW = poly2mask(y{4}(:,1),y{4}(:,2),m,n);
    psi(4,1) = sum(255-img2(BW==1))/sum(sum(BW.*255));
end

% right wall
if ~isempty(y{5})
    BW = poly2mask(y{5}(:,1),y{5}(:,2),m,n);
    psi(5,1) = sum(255-img1(BW==1))/sum(sum(BW.*255));    
end

end

function yhat = constraintCB(param, model, x, y)
% slack resaling: argmax_y delta(yi, y) (1 + <psi(x,y), w> - <psi(x,yi), w>)
% margin rescaling: argmax_y delta(yi, y) + <psi(x,y), w>
%   if dot(y*x, model.w) > 1, yhat = y ; else yhat = - y ; end
%   if param.verbose
%     fprintf('yhat = violslack([%8.3f,%8.3f], [%8.3f,%8.3f], %3d) = %3d\n', ...
%             model.w, x, y, yhat) ;
%   end
yhat = {[0,0],[227,46],[220,202],[0,0],[0,0]};
end