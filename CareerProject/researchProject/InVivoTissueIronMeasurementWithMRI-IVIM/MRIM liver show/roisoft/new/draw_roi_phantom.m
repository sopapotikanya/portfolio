close all
clear all
core_path = pwd;
main_path = dir('20*');
h = figure;
for j =[13,14] %1:size(main_path,1)
    cd(main_path(j).name);
    main_path(j).name
    cd 3T
    dicom_path = dir('DICOM*');
    cd(dicom_path(1).name);
    dcm_path = dir('S*');
    info = dicominfo(dcm_path(1).name);
    Y = dicomread(info);
    imshow(Y, 'DisplayRange', []);
    cd ../ROI
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
            savepath = sprintf('%d/roi3t.mat', i);
            save(savepath, 'roi');
%             subplot(3,5,i) , imshow(roi_phantom);
            roishow = Y + uint16(roi*600);
            imshow(roishow, 'DisplayRange', []);
            saveas(h,[num2str(i) '/roi3t.png']);
            roiall = roiall + roi;
        end
        disp('get roi done!');
        roiall = roiall*600;
        roishow = Y + uint16(roiall);
        imshow(roishow, 'DisplayRange', []);
        cd(core_path);
    else
        disp('size != 15 fail , backto mainpath !!');
        cd(core_path);
    end
    
end


