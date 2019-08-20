function [mark,varargout]  = detectTriangleboardPoints(I,box,cornerShape,th)
%   mark = detectTriangleboardPoints(I,box)
%   [mark, BW, edgeImg, score]  = detectTriangleboardPoints(I,box)
%
%   Input :
%   I = gray scale image
%   box = [h/2, w/2]
% 
%   Output : 
%   mark = checkerboard corner point (x,y) in m-by-2
%   BW = image threshold
%   edgeImg = position for boxx scan
%   score = ratio black and white in each box

BW = imbinarize(I,'adaptive','ForegroundPolarity','bright');
BW(:,:,2:3) = [];

% edge
SE = strel('square',5);
edgeImg = imclose(edge(BW),SE);

% box scan 
roiarea = (box(1)*2+1)*(box(2)*2+1);
score = zeros(size(BW));
scoreList = [];
bbox = [];
for i=box(1)+1:size(BW,1)-box(1)
    for j=box(2)+1:size(BW,2)-box(2)
        if edgeImg(i,j) == 1 % target all points in edge line
            % get pixel value of edge in roi
            roi = BW(i-box(1):i+box(1),j-box(2):j+box(2));
            pixelList = [roi(1,:), roi(2:end-1,end)',fliplr(roi(end,:)), fliplr(roi(2:end-1,1)')];
            
            % ignore edge in roi that have same value all
            if sum(pixelList) ~= size(pixelList,2) && sum(pixelList) ~= 0 
                
                % change start point of edge
%                 while 1
%                     if pixelList(1) == pixelList(end)
%                         pixelList = [pixelList(end),pixelList(1:end-1)];
%                     else
%                         break;
%                     end
%                 end
                
                % count number of group in edge
                pixelList2 = pixelList;
                g = pixelList2(1);
                no_g = 1;
%                 while ~isempty(pixelList2)
%                     if pixelList2(1) ~= g
%                         no_g = no_g + 1;
%                         g = pixelList2(1);
%                     end
%                     pixelList2(1) = [];
%                 end
                for k = pixelList2
                    if k ~= g
                        no_g = no_g + 1;
                        g = k;
                    end
                end
                if pixelList(1) == pixelList(end)
                    no_g = no_g - 1;
                end
                % calculate score from ratio region in roi
                % high score when black and white is equal
                if no_g == cornerShape
                    s = 1 - abs(sum(roi(:)) - roiarea/2)/roiarea;
                    if s > th
                        score(i,j) = s;
                        scoreList = cat(1,scoreList,score(i,j));
                        bbox = cat(1,bbox,[i,j]);
                    end
                end
            end
        end
    end
end


% get center of score
% scoreDilate = score>th;
% SE = strel('square',15);
SE = strel('line', 10, 45);
scoreDilate = imclose(score>th,SE);
SE = strel('line', 10, -45);
scoreDilate = imclose(scoreDilate>th,SE);
stats = regionprops('table',scoreDilate);
statsTB = [stats.Area,stats.Centroid];
mark = statsTB((statsTB(:,1) > 25),2:3);

% output
nout = max(nargout,1) - 1;
if nout
    varargout{1} = BW;
    varargout{2} = edgeImg;
    varargout{3} = score;
    varargout{4} = scoreDilate;
end





