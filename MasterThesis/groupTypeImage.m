clear
%% old error
% imgTypeAll(imgnum).typeOfLineColor = typeImg1;
% imgTypeAll(imgnum).typeOfLineWallFull = typeImg2;
% imgTypeAll(imgnum).typeOfLineObjFull = typeImg3;  
% imgTypeAll(imgnum).typeOfLineFull = typeImg4; 
% imgTypeAll(imgnum).typeOfFurniture = typeImg5;
% imgTypeAll(imgnum).typeOfRoom = typeImg6;


DB_type = 'HedauDB';
imdir=['../Database/' DB_type '/Images/'];
load(['../Database/' DB_type '/Allvpdata.mat']);
load(['../Database/' DB_type '/imsegs.mat']);
d_img=dir([imdir '*.jpg']);

if exist('../Database/sample/imgTypeAll.mat', 'file') == 2
    load('../Database/sample/imgTypeAll.mat');
    imgnum_test = size(imgTypeAll,2);
else
    imgnum_test = 1;
    imgTypeAll = struct;
end

for imgnum = imgnum_test:size(d_img,1)
    close all
    index = find(strcmp({imsegs.imname}, d_img(imgnum).name)==1);
%     imagename=d_img(imgnum).name;
    imagename=imsegs(index).imname;
    fileName = imagename(1,1:end-4);
    disp(['[' num2str(imgnum) '/' num2str(size(d_img,1)) '] ' imagename])
    img = imread([imdir imagename]);

    lines = Allvpdata(index).lines;
    linemem = Allvpdata(index).linemem;
    VP = Allvpdata(index).vp;
    
    testbug1=true;
    testbug2=true;
    testbug3=true;
    testbug4=true;
    testbug5=true;
    testbug6=true;
    if ~isempty(VP)
        fig_lines_old = figure;
        imshow(img);
        hold on
        for i=1:size(lines,1)
            color = [0 0 0];
            color(linemem(i,1)) = 1;
            plot(lines(i,1:2),lines(i,3:4),'-','LineWidth',2,'Color',color);
        end
        hold off
    
    
        imgTypeAll(imgnum).imname = imagename;
    %     fn = {'Perfect','Good: line not meet to jt','Great: no line in jt','Bad1: no edge line','Bad2: incorrect type line','Bad1&2'};
    %     [typeImg,tf] = listdlg('PromptString','Select a file:',...
    %                            'SelectionMode','single',...
    %                            'ListString',fn);
    %     imgTypeAll(imgnum).typeOfPerfectLine = typeImg;

%         fn = {'All Correct','Some Incorrect'};
%         [typeImg1,tf] = listdlg('PromptString','line color',...
%                                'SelectionMode','single',...
%                                'ListString',fn);
%         imgTypeAll(imgnum).typeOfLineColor = typeImg1;


        fn = {'Complete','not Complete','no line between wall (hide by obj)'};
        [typeImg2,tf] = listdlg('PromptString','is line between wall?',...
                               'SelectionMode','single',...
                               'ListString',fn);
        imgTypeAll(imgnum).typeOfLineWallFull = typeImg2;


        fn = {'Full (can see to obj)','not full (cannot see to obj)','no obj'};
        [typeImg3,tf] = listdlg('PromptString','(if line between wall is hide by obj) have line on obj?',...
                               'SelectionMode','single',...
                               'ListString',fn);
        imgTypeAll(imgnum).typeOfLineObjFull = typeImg3;  


%         fn = {'meet','not meet'};
%         [typeImg4,tf] = listdlg('PromptString','line meet to junction?',...
%                                'SelectionMode','single',...
%                                'ListString',fn);
%         imgTypeAll(imgnum).typeOfMeetLine = typeImg4;  


%         fn = {'Empty room','a little furniture','furniture on conner','a lot furniture','ignore'};
%         [typeImg5,tf] = listdlg('PromptString','Select a file:',...
%                                'SelectionMode','single',...
%                                'ListString',fn);
%         imgTypeAll(imgnum).typeOfFurniture = typeImg5;
% 
%         fn = {'not room (1wall)','room corner (2wall)','room center (3wall)','corridor','not square room','etc'};
%         [typeImg6,tf] = listdlg('PromptString','Select a file:',...
%                                'SelectionMode','single',...
%                                'ListString',fn);
%         imgTypeAll(imgnum).typeOfRoom = typeImg6;
        
        

%         if isempty(typeImg1)
%             testbug1=false;
%         end
        if isempty(typeImg2)
            testbug2=false;
        end
        if isempty(typeImg3)
            testbug3=false;
        end
%         if isempty(typeImg4)
%             testbug4=false;
%         end
%         if isempty(typeImg5)
%             testbug5=false;
%         end
%         if isempty(typeImg6)
%             testbug6=false;
%         end
    
    else
        msgbox('Empty Vanishing Point')
    end
%     if testbug1 && testbug2 && testbug3 && testbug4 && testbug5 && testbug6
    if testbug2 && testbug3
        save('../Database/sample/imgTypeAll.mat','imgTypeAll','imgnum_test');
    else
        break
    end
end
