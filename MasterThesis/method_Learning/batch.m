clear
addpath('../calDistance')
addpath('../LineSegment')
addpath('../Junction')
% addpath('../circlemethod')
% addpath('../gridmethod')

load('/Users/sopapotikanya/Documents/MATLAB/floorplan2/Database/sample/imgTypeAll.mat')

path_result = '../../Results/Learning/test1/';

DB_type = 'HedauDB';
imdir=['../../Database/' DB_type '/Images/'];
labeldir=['../../Database/' DB_type '/label/'];
load(['../../Database/' DB_type '/Allvpdata.mat']);
load(['../../Database/' DB_type '/imsegs.mat']);

Gap_dis = 15;
Gap_polar = 0.9;

imgnum_test = 1;
for imgnum=imgnum_test:314
    close all
    if ~isempty(imgTypeAll(imgnum).imname)
        if (imgTypeAll(imgnum).typeOfLineObjFull == 3)
            
            imagename = imgTypeAll(imgnum).imname;
            fileName = imagename(1,1:end-4);

            img = imread([imdir imagename]);
            lines = Allvpdata(imgnum).lines;
            linemem = Allvpdata(imgnum).linemem;
            VP = Allvpdata(imgnum).vp;
            load([labeldir fileName '_labels.mat']); % fields, gtPolyg, labels
            
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
                
                % format line
                Lines = [lines(:,1),lines(:,3),lines(:,2),lines(:,4)];


                linesH = estimateLine(Lines(linemem == 2,:),vp_honz,img,Gap_dis,Gap_polar);
                linesV = estimateLine(Lines(linemem == 1,:),vp_vert,img,Gap_dis,Gap_polar);
                linesZ = estimateLine(Lines(linemem == 3,:),vp_center,img,Gap_dis,Gap_polar);

                % [point_start,point_end,dis_start,dis_end,angleD_avg,lineABC,width]
                LINES = cat(1,linesH,linesV,linesZ);
                lines_label = [ones(size(linesH,1),1);2*ones(size(linesV,1),1);3*ones(size(linesZ,1),1)];
                [V,type,junction_list,intersect_Y_list] = detectingJunction(LINES,lines_label);

                
                
                
                %% show
                fig_lines_old = figure;
                imshow(img);
                hold on
                for i=1:size(lines,1)
                    color = [0 0 0];
                    color(linemem(i,1)) = 1;
                    plot(lines(i,1:2),lines(i,3:4),'-','LineWidth',2,'Color',color);
                end
                hold off
                
                fig_lines_new = plotTypeLine(linesH,linesV,linesZ,img);
                
                figure, imshow(labels,'DisplayRange',[])
                
                
                
                testbug = 1;
            end
        end
    end
end