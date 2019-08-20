function [Iout]=mark(I,x,y,status,state)

if(state==1)
if(status==1)
I(x-5:x+5,y-5:y+5,1)=0;
I(x-5:x+5,y-5:y+5,3)=0;
I(x-5:x+5,y-5:y+5,2)=255;
elseif(status==2)
I(x-5:x+5,y-5:y+5,1)=255;   
I(x-5:x+5,y-5:y+5,2)=0;  
I(x-5:x+5,y-5:y+5,3)=0;  
end
elseif(state==2)
if(status==1)
I(x-2:x+2,y-2:y+2,1)=800;
elseif(status==2)
I(x-2:x+2,y-2:y+2,1)=800;  
end
end
Iout=I;
end