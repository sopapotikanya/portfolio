function draw_phantom(savepath,DICOM)
% draw circle ROI on phantom 15 position
% draw_phantom(savepath_roi,DICOM_FILE)
% 
% 

    info = dicominfo(DICOM);
    Y = dicomread(info);
    imshow(Y, 'DisplayRange', []);
    [x, y] = getpts;
    disp('getting roi ...');
    
    if(size(x,1) == 8)
        roiall = zeros(240,240);
        for i=1:size(x,1)
            i
            circles(i,:) = [x(i),y(i) ,3];
            roi_black = uint8(zeros(size(Y)));
            roi_phantom = insertShape(roi_black, 'FilledCircle', circles(i,:), 'Color', uint8([255 255 255]), 'Opacity', 1, 'SmoothEdges', false);
            roi = logical(roi_phantom(:,:,1));
            savename = [savepath num2str(i) '/roi.mat'];
            save(savename, 'roi');
%             subplot(3,5,i) , imshow(roi_phantom);
            roishow = Y + uint16(roi*600);
            imshow(roishow, 'DisplayRange', []);
            saveas(h,[savepath num2str(i) '/roi.png']);
            roiall = roiall + roi;
        end
        disp('get roi done!');
        roiall = roiall*600;
        roishow = Y + uint16(roiall);
        imshow(roishow, 'DisplayRange', []);
    else
        disp('size != 15 fail , backto mainpath !!');
    end