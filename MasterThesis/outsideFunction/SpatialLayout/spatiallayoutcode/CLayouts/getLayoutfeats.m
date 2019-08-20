function [line_lab_features ]=getLayoutfeats(Polyg,integData,vp,h,w,showfeats,quantsiz)
%Get features for a given candidate layout Polyg 

%features:-
%line-membership features:1:20
%correct label confidence: 21-25
%label entropy :26 -30
%weighted line-memership features:31-40
%surface label confidence :41 -75




LineNum=4;
LabelNum=7;
line_features=[];

if ~exist('quantsiz','var')
    quantsiz=500;
end


corrmem=zeros(5,1);
incorrmem=zeros(5,1);
corrmem_wconf=zeros(5,1);
incorrmem_wconf=zeros(5,1);

totmem=zeros(5,1);
Farea=zeros(5,1);
Rlines=zeros(5,1);
CorrLabConf=zeros(5,1);
LabEnt=zeros(5,1);
LabConf=zeros(35,1);%5*7

coorlab=[4 8 17 23 33];

nbins=6;

% line membership features weighted line membership features and label
% confidence features
for f=1:numel(Polyg)
    
    regfeats_hog(f,:)=zeros(1,nbins);
    if numel(Polyg{f}) > 0
        
        
        Farea(f)=polyarea([Polyg{f}(:,1);Polyg{f}(1,1)],[Polyg{f}(:,2);Polyg{f}(1,2)])/(w*h);
                
        xs=round(Polyg{f}(:,1));
        ys=round(Polyg{f}(:,2));
        
        if f==1 | f==5 %floor ceiling zx plane
            vno1=2;vno2=3;
            corrmem_inds=[2 3 4];
            incorrmem_inds=[1];
            intI=integData.intI23;
            intnum=integData.intnum23;
        elseif f==2 %middle wall
            vno1=1;vno2=2;
            corrmem_inds=[1 2 4];
            incorrmem_inds=[3];
            intI=integData.intI12;
            intnum=integData.intnum12;
        elseif f==3 |f==4 %right & left  wall
            vno1=3;vno2=1;
            corrmem_inds=[1 3 4];
            incorrmem_inds=[2];
            intI=integData.intI31;
            intnum=integData.intnum31;
        end
        
        [th1 th2]=gettheta_ind(xs,ys,vp([vno1 vno2],:),h,w,quantsiz);
        
        th1min(f)=min(th1);
        th1max(f)=max(th1)+1;
        th2min(f)=min(th2);
        th2max(f)=max(th2)+1;
        
        for l1=1:4
            regfeats(f,l1)=getRegfeats(th1min(f),th1max(f),th2min(f),th2max(f),intI{l1});
        end
        
        for l2=1:4
            regfeats_wconf(f,l2)=getRegfeats(th1min(f),th1max(f),th2min(f),th2max(f),intI{LineNum+l2});
        end
        
        corrmem(f)=sum(regfeats(f,corrmem_inds));
        incorrmem(f)=sum(regfeats(f,incorrmem_inds));
        totmem(f)=corrmem(f)+incorrmem(f);
        
        corrmem_wconf(f)=sum(regfeats_wconf(f,corrmem_inds));
        incorrmem_wconf(f)=sum(regfeats_wconf(f,incorrmem_inds));
        totmem_wconf(f)=corrmem_wconf(f)+incorrmem_wconf(f);
        
        for l3=1:7
            ttemp=getRegfeats(th1min(f),th1max(f),th2min(f),th2max(f),intnum);
            LabConf((f-1)*7+l3)=getRegfeats(th1min(f),th1max(f),th2min(f),th2max(f),intI{2*LineNum+l3})/(ttemp+(ttemp==0));
        end
        
        
        
        CorrLabConf(f)=LabConf(coorlab(f));
        tempconf=LabConf((f-1)*7+1:(f-1)*7+7);tempconf(tempconf==0)=eps;
        LabEnt(f)=-1*sum(LabConf((f-1)*7+1:(f-1)*7+7).*log2(tempconf));
        
        
    end
    
    Rlines(f)=totmem(f);
    
end

tind=find(abs(corrmem) <= 10^(-7));
corrmem(tind)=0;
tind=find(abs(corrmem_wconf) <= 10^(-7));
corrmem_wconf(tind)=0;

tind=find(abs(incorrmem) <= 10^(-7));
incorrmem(tind)=0;
tind=find(abs(incorrmem_wconf) <= 10^(-7));
incorrmem_wconf(tind)=0;


tind=find(abs(totmem) <= 10^(-7));
totmem(tind)=0;
tind=find(abs(totmem_wconf) <= 10^(-7));
totmem_wconf(tind)=0;


Rlines=Rlines/(sum(totmem)+eps*(sum(totmem)==0));

line_features=[(corrmem./(corrmem+incorrmem+eps*((corrmem+incorrmem)==0)))' (incorrmem./(corrmem+incorrmem+eps*((corrmem+incorrmem)==0)))' ...
    Farea' Rlines'];

wconfline_features=[(corrmem_wconf./(corrmem_wconf+incorrmem_wconf+eps*((corrmem_wconf+incorrmem_wconf)==0)))'...
    (incorrmem_wconf./(corrmem_wconf+incorrmem_wconf+eps*((corrmem_wconf+incorrmem_wconf)==0)))'];

line_lab_features=[line_features CorrLabConf' LabEnt' wconfline_features LabConf'];


return;