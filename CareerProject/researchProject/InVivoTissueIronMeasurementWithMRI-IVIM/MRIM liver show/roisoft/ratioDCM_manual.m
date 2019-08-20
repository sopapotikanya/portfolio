function [roi_resize1 ratio_w ratio_h] = ratioDCM_manual(save_ref_posit,save_ref_posit2,normal_img,roi_img,dicom_img)


w_normal=abs(save_ref_posit(1,3)-save_ref_posit(1,1));
h_normal=abs(save_ref_posit(2,4)-save_ref_posit(2,2));

w_dcm=abs(save_ref_posit2(1,3)-save_ref_posit2(1,1));
h_dcm=abs(save_ref_posit2(2,4)-save_ref_posit2(2,2));

ratio_normal=w_normal/h_normal;
ratio_dcm=w_dcm/h_dcm;

if(w_normal<w_dcm)
    w1=w_dcm;
    w2=w_normal;
else
    w2=w_dcm;
    w1=w_normal;
end

if(h_normal<h_dcm)
    h1=h_dcm;
    h2=h_normal;
else
    h2=h_dcm;
    h1=h_normal;
end

ratio_w=w1/w2;
ratio_h=h1/h2;

if(save_ref_posit(1,3)<save_ref_posit(1,1))

    x2=save_ref_posit(1,3);
else
    x2= save_ref_posit(1,1);
end


if(save_ref_posit(2,4)<save_ref_posit(2,2))
    y2=save_ref_posit(2,4);
else
    y2=save_ref_posit(2,2);
end

if(save_ref_posit2(1,3)<save_ref_posit2(1,1))

    x1=save_ref_posit2(1,3);
else
    x1= save_ref_posit2(1,1);
end


if(save_ref_posit2(2,4)<save_ref_posit2(2,2))
    y1=save_ref_posit2(2,4);
else
    y1=save_ref_posit2(2,2);
end



normal_crop=normal_img;
% normal_resize=imresize(normal_crop,[1/ratio_h], 'nearest');
normal_resize=imresize(normal_crop,[size(normal_crop,1)*1/ratio_h  size(normal_crop,2)*1/ratio_w]);
roi_crop=roi_img;
roi_resize1=imresize(roi_crop,[size(normal_crop,1)*1/ratio_h  size(normal_crop,2)*1/ratio_w], 'nearest');
%roi_resize2=imresize(roi_crop,[size(normal_crop,1)*1/ratio_h  size(normal_crop,2)*1/ratio_w]);

%roi_resize_edge=imresize(roi_img_edge,[size(normal_crop,1)*1/ratio_h  size(normal_crop,2)*1/ratio_w], 'nearest');

% x1=save_ref_posit2(1,1);
% y1=save_ref_posit2(1,2);
% x2=save_ref_posit(1,1);
% y2=save_ref_posit(1,2);

anchor_leftD=x1;
anchor_aboveD=y1;
anchor_rightD=size(dicom_img,2)-x1;
anchor_bottomD=size(dicom_img,1)-y1;

anchor_leftN=round(x2/ratio_w);
anchor_aboveN=round(y2/ratio_h);
anchor_rightN=size(normal_resize,2)-anchor_leftN;
anchor_bottomN=size(normal_resize,1)-anchor_aboveN;

if(anchor_leftN>anchor_leftD)
    offsetL=anchor_leftN-anchor_leftD;
    roi_resize1(:,1:offsetL)=[];
%     roi_resize_edge(:,1:offsetL)=[];
else
    offsetL=anchor_leftD-anchor_leftN;
    zerooffset=zeros(size(roi_resize1,1),offsetL);
    roi_resize1=[zerooffset roi_resize1];
%     roi_resize_edge=[zerooffset roi_resize_edge];
end

if(anchor_aboveN>anchor_aboveD)
    offsetA=anchor_aboveN-anchor_aboveD;
    roi_resize1(1:offsetA,:)=[];
%     roi_resize_edge(1:offsetA,:)=[];
else
    offsetA=anchor_aboveD-anchor_aboveN;
    zerooffset=zeros(offsetA,size(roi_resize1,2));
    t1=zerooffset';
    t2=roi_resize1';
    t3=[t1 t2];
    t4=t3';
    roi_resize1=t4;

%     zerooffset_edge=zeros(offsetA,size(roi_resize_edge,2));
%     t1_edge=zerooffset_edge';
%     t2_edge=roi_resize_edge';
%     t3_edge=[t1_edge t2_edge];
%     t4_edge=t3_edge';
%     roi_resize_edge=t4_edge;
end

if(anchor_rightN>anchor_rightD)
    offsetR=anchor_rightN-anchor_rightD;
    roi_resize1(:,size(roi_resize1,2)-offsetR:size(roi_resize1,2))=[];
%     roi_resize_edge(:,size(roi_resize_edge,2)-offsetR:size(roi_resize_edge,2))=[];
else
    offsetR=anchor_rightD-anchor_rightN;
    zerooffset=zeros(size(roi_resize1,1),offsetR);
    roi_resize1=[roi_resize1 zerooffset];

%     zerooffset_edge=zeros(size(roi_resize_edge,1),offsetR);
%     roi_resize_edge=[roi_resize_edge zerooffset_edge];
end

if(anchor_bottomN>anchor_bottomD)
    offsetB=anchor_bottomN-anchor_bottomD;
    roi_resize1(size(roi_resize1,1)-offsetB:size(roi_resize1,1),:)=[];
%     roi_resize_edge(size(roi_resize_edge,1)-offsetB:size(roi_resize_edge,1),:)=[];
else
    offsetB=anchor_bottomD-anchor_bottomN;
    zerooffset=zeros(offsetB,size(roi_resize1,2));
    t1=zerooffset';
    t2=roi_resize1;
    t2=t2';
    t3=[t2 t1];
    t4=t3';
    roi_resize1=t4;

%     zerooffset_edge=zeros(offsetB,size(roi_resize_edge,2));
%     t1_edge=zerooffset_edge';
%     t2_edge=roi_resize_edge;
%     t2_edge=t2_edge';
%     t3_edge=[t2_edge t1_edge];
%     t4_edge=t3_edge';
%     roi_resize_edge=t4_edge;
end
