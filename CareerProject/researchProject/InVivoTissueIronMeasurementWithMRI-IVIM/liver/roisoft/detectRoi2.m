function cropimg = detectRoi2(image)

  i=image;
%  j=i;
% % 
% y=size(i,1);
% x=size(i,2);
% 
% strR=[1,(y/2)+22];
% strL=[x,(y/2)+22];
% strU=[x/10+10,1];
% strB=[x/10+10,y];
% 
% 
% count=0;
% checkRepeat=0;
% 
% for I=strR(1):x
%     
%     j(strR(2),I,:)=[0,0,0];
%     
%     if i(strR(2),I,1)<5 & i(strR(2),I,2)<5 & i(strR(2),I,3)<5
%         j(strR(2),I,:)=[255,0,0];
%         if checkRepeat==0
%             ptx=I;
%             checkRepeat=1;
%         end
%         count=count+1;
%         
%         if count>10
%             break
%         end
%     else
%         ptx=0;
%         checkRepeat=0;
%     end
% end
% 
% count=0;
% checkRepeat=0;
% 
% for I=strL(1):-1:1
%     
%     j(strL(2),I,:)=[0,0,0];
%     
%     if i(strL(2),I,1)<5 & i(strL(2),I,2)<5 & i(strL(2),I,3)<5
%         j(strL(2),I,:)=[255,0,0];
%         if checkRepeat==0
%             ptl=I;
%             checkRepeat=1;
%         end
%         count=count+1;
%         
%         if count>10
%             
%             break
%             
%         end
%         
%     else
%         ptl=0;
%         checkRepeat=0;
%         
%     end
%     
% end
% 
% count=0;
% checkRepeat=0;
% 
% for I=strU(2):y
%     
%     j(I,strU(1),:)=[0,0,0];
%     
%     if i(I,strU(1),1)<5 & i(I,strU(1),2)<5 & i(I,strU(1),3)<5
%         j(I,strU(1),:)=[255,0,0];
%         if checkRepeat==0
%             ptU=I;
%             checkRepeat=1;
%         end
%         count=count+1;
%         
%         if count>10
%             
%             break
%             
%         end
%         
%     else
%         ptU=0;
%         checkRepeat=0;
%         
%     end
%     
% end
% 
% 
% 
% 
% count=0;
% checkRepeat=0;
% 
% for I=strB(2):-1:1
%     
%     j(I,strB(1),:)=[0,0,0];
%     
%     if i(I,strB(1),1)<5 & i(I,strB(1),2)<5 & i(I,strB(1),3)<5
%         j(I,strB(1),:)=[255,0,0];
%         if checkRepeat==0
%             ptB=I;
%             checkRepeat=1;
%         end
%         count=count+1;
%         
%         if count>10
%             
%             break
%             
%         end
%         
%     else
%         ptB=0;
%         checkRepeat=0;
%         
%     end
%     
% end

ptx=161;
ptU=621;
ptl=867;
ptB=1153;
cropimg=imcrop(i,[ptx ptU ptl-ptx ptB-ptU]);

% imshow(cropimg);
%
% figure
%
%figure ,imshow(cropimg);
