function VPdetection(name,DB_type,LSD_type)

inputDir = ['../Results/' LSD_type '/data/' DB_type '/' name '.tmp'];
outputDir_out = ['../Results/' LSD_type '/data/' DB_type '/' name '.out'];
outputDir_mat = ['../Results/' LSD_type '/data/' DB_type '/' name '.mat'];

tic
[status, result] = system(['vpdetection ' inputDir ' ' outputDir_out]);
if status
    disp(result)
end
t_vp = toc;

save(outputDir_mat,'t_vp','-append');

indoor 0190
