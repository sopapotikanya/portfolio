function iLayout(centerHRelative, centerVRelative, ...
                    polarHRelative, polarVRelative, polarZRelative, ...
                    path_result, fileName)
                
                
gridBin = 10;
gridGab = 100/gridBin;

%% Line ABC
polarH = polarABC(polarHRelative);
polarV = polarABC(polarVRelative);
polarZ = polarABC(polarZRelative);

separate_point = [centerHRelative,centerVRelative];

[polarH_L, polarH_R, polarH_TH] = separateLinesLR(polarH,separate_point);
[polarV_L, polarV_R, polarV_TH] = separateLinesLR(polarV,separate_point);
[polarZ_L, polarZ_R, polarZ_TH] = separateLinesLR(polarZ,separate_point);

fig = figure; 
hold on
if ~isempty(polarH_L), plot(polarH_L(:,1:2)',polarH_L(:,3:4)','-r'); end
if ~isempty(polarV_L), plot(polarV_L(:,1:2)',polarV_L(:,3:4)','-r'); end
if ~isempty(polarZ_L), plot(polarZ_L(:,1:2)',polarZ_L(:,3:4)','-r'); end

if ~isempty(polarH_R), plot(polarH_R(:,1:2)',polarH_R(:,3:4)','-b'); end
if ~isempty(polarV_R), plot(polarV_R(:,1:2)',polarV_R(:,3:4)','-b'); end
if ~isempty(polarZ_R), plot(polarZ_R(:,1:2)',polarZ_R(:,3:4)','-b'); end
hold off
    
   


% selPointB = [49, 17, 1];
% selPointT = [49, 80, 1];

gridT_x = 10:10:centerHRelative;
gridT_y = ceil(centerVRelative/10)*10:10:90;
gridB_x = 10:10:centerHRelative;
gridB_y = 10:10:centerVRelative;

isShow = true;
for gridX = gridB_x
    for gridY_B = gridB_y
        for gridY_T = gridT_y
            selPointB = [gridX, gridY_B, 1];
            selPointT = [gridX, gridY_T, 1];
            [width_g1_H, width_g1_V, width_g1_Z, ...
                width_g2_H, width_g2_V, width_g2_Z, ...
                width_g3_H, width_g3_V, width_g3_Z, ...
                width_g4_H, width_g4_V, width_g4_Z, ...
                width_cross_12, width_cross_13, width_cross_14, width_cross_23, width_cross_34 ...
                ] = iFilter(selPointT,selPointB,separate_point,polarH_L,polarV_L,polarZ_L,fileName,isShow);
        end
    end
end
testbug=1;