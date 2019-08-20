close all
load('/Users/sopapotikanya/Documents/MATLAB/floorplan2/Database/sample/imgTypeAll.mat')

path_result = '../../Results/gridmethod/test1/';

% path_result1 = '../../Results/gridmethod/test1/lines/';
% path_result2 = '../../Results/gridmethod/test1/polar/';
% path_result3 = '../../Results/gridmethod/test1/layout/';
DB_type = 'HedauDB';
imdir=['../../Database/' DB_type '/Images/'];
load(['../../Database/' DB_type '/Allvpdata.mat']);
load(['../../Database/' DB_type '/imsegs.mat']);

Gap_dis = 15;
Gap_polar = 0.9;

imgnum_test = 1;
% imgnum_test = 13;
% imgnum_test = 37;

for imgnum=imgnum_test:314
    close all
    if ~isempty(imgTypeAll(imgnum).imname)
%         if true
        if (imgTypeAll(imgnum).typeOfLineObjFull == 3)
%         if ((imgTypeAll(imgnum).typeOfLineColor == 1) && (imgTypeAll(imgnum).typeOfLineWallFull == 1) && (imgTypeAll(imgnum).typeOfLineObjFull ~= 2)) % all correct
%         if ((imgTypeAll(imgnum).typeOfLineColor == 1) && (imgTypeAll(imgnum).typeOfLineWallFull == 1)) 
            imagename = imgTypeAll(imgnum).imname;
            fileName = imagename(1,1:end-4);
            index = imgnum;

            img = imread([imdir imagename]);
            lines = Allvpdata(index).lines;
            linemem = Allvpdata(index).linemem;
            VP = Allvpdata(index).vp;
            if ~isempty(VP)

                vp_honz = VP(2,:);
                vp_vert = VP(1,:);
                vp_center = VP(3,:);
                VP2 = cat(1,vp_honz,vp_vert,vp_center);

                if vp_honz(1,1) < vp_center(1,1)
                    vp_honz_type = 'left';
                else
                    vp_honz_type = 'right';
                end
        %         fig_lines_old = figure;
        %         imshow(img);
        %         hold on
        %         for i=1:size(lines,1)
        %             color = [0 0 0];
        %             color(linemem(i,1)) = 1;
        %             plot(lines(i,1:2),lines(i,3:4),'-','LineWidth',2,'Color',color);
        %         end
        %         hold off

        %         if strcmp(vp_honz_type,'left')
        %         if strcmp(vp_honz_type,'right')
                % format line
                Lines = [lines(:,1),lines(:,3),lines(:,2),lines(:,4)];


                linesH = estimateLine(Lines(linemem == 2,:),vp_honz,img,Gap_dis,Gap_polar);
                linesV = estimateLine(Lines(linemem == 1,:),vp_vert,img,Gap_dis,Gap_polar);
                linesZ = estimateLine(Lines(linemem == 3,:),vp_center,img,Gap_dis,Gap_polar);

                fig_lines_new = plotTypeLine(linesH,linesV,linesZ,img);
                saveas(fig_lines_new,[path_result 'lines/' fileName '.png']);

                % [point_start,point_end,dis_start,dis_end,angleD_avg,lineABC,width]
                LINES = cat(1,linesH,linesV,linesZ);
                label = [ones(size(linesH,1),1);2*ones(size(linesV,1),1);3*ones(size(linesZ,1),1)];
                [V,type,junction_list,intersect_Y_list] = detectingJunction(LINES,label);

%                 fig_junction = figure; imshow(img);
%                 hold on
%                 for i=1:size(junction_list,1)
%                     intersect = junction_list(i,:);
%                     junction_pt = intersect(1,3:4);
%                     v = V(i,:);
%                     drawJunction(junction_pt,[VP2(1,:);VP2(2,:);VP2(3,:)],v,'red');
%                 end
%                 hold off

                %%
                [centerHRelative, centerVRelative, ...
                    polarHRelative, polarHRelative2, ...
                    polarVRelative, polarVRelative2, ...
                    polarZRelative,polarZRelative2, ...
                    widthH, widthV, minH, minV] = ...
                    line2polar(img,linesH,linesV,linesZ,vp_honz,vp_vert,vp_center,path_result,fileName);
                
                
%                 gridLayout(centerHRelative, centerVRelative, ...
%                     polarHRelative, polarVRelative, polarZRelative, ...
%                     widthH, widthV, minH, minV, path_result, fileName)
                iLayout(centerHRelative, centerVRelative, ...
                    polarHRelative, polarVRelative, polarZRelative, ...
                    path_result, fileName)
                
% %                     selPoint = [50,60,1];
% %                     selPoint = [43,60,1];
%                 error_score_All = zeros(9,9);
%                 for gridY = 10:10:90
%                     for gridX = 10:10:90
% %                 for gridY = 20:10:100
% %                     for gridX = 40:10:70
%                         selPoint = [gridX,gridY,1];
%                         error_score = gridLayout(centerHRelative, centerVRelative, ...
%                             polarHRelative, polarHRelative2, ...
%                             polarVRelative, polarVRelative2, ...
%                             polarZRelative,polarZRelative2, ...
%                             widthH, widthV, minH, minV, ...
%                             selPoint);
%                         error_score_All(gridY/10,gridX/10) = error_score;
%                         close all
%                     end
%                 end

                
                %%
            end
        elseif imgTypeAll(imgnum).typeOfLineColor == 2 % some incorrect

        else

        end
    end
end