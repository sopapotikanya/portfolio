function savetemplate(BW,text,index)
l = bwlabel(BW)
r = regionprops(l);
mainpath='/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/roisoft/new/template2/';
for i=1:size(r,1)
    x =round(r(i).BoundingBox(1));
    y = 1;
    w = r(i).BoundingBox(3);
    h = size(BW,1)-1;
    
    
    temp = BW(y:y+h,x:x+w);
    figure ,imshow(temp);
    imwrite(temp, [mainpath 'png/' text '_' num2str(index) '_' num2str(i) '.png'])
    name = char([mainpath 'mat/' text '_' num2str(index) '_' num2str(i)]);
    save(name, 'temp')
end

