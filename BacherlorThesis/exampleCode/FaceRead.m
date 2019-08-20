function [Point, TotPoints] = FaceRead(LocationIn, ImageFile, InputFile)
% Importing 3D data from BU-3DFE database
% LocationIn = 'E:\Project_4\3D_database\F0001\';
% InputFile = 'F0001_NE00WH_F3D';
% ImageFile = 'F0001_NE00WH_F2D';

Txt = fopen([LocationIn,InputFile '.wrl'], 'r');
i = 1;
skp = zeros(1, 100);
 
while (i<=19)
    skp = fgetl(Txt);
    i = i+1;
end
 
i = 1;
Point = zeros(100000, 3);
L0 = 0;
cont = zeros(1, 75);
 
while (L0 == 0)
    cont = fgetl(Txt);
    C = '                                        ]';
    L1 =  cont(1, 1:41);
    if strcmp(L1,C) %(L1 == C)
        L0 = 1;
    else
        Point(i, :) = sscanf(cont, '%f %f %f');
        i = i+1;                   
    end
end
TotPoints = i-1;
Point(i:100000,:) = [];
fclose(Txt);
end
