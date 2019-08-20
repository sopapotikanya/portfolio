
mainpath = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms';
cd(mainpath);
phantom_path = dir('20*');
for j=15:size(phantom_path,1)
    cd(phantom_path(j).name);
    phantom_path(j).name;
    cd 1.5T/ROI_sort_new
    for i=1:15

        if i<10
            holeInd = ['0' num2str(i)];
        else
            holeInd = num2str(i);
        end
        name1 = ['dicom_img_fig_ROI_15T_' holeInd '.jpg'];
        name2 = ['orig_img_ROI_15T_' holeInd '.jpg'];
        name3 = ['ROI_15T_' holeInd '.dcm'];
        name4 = ['ROI_15T_' holeInd '.mat'];
        name5 = ['ROI_15T_' holeInd '.rgb.dcm'];
        name6 = ['ROI_15T_' holeInd '.tts'];
        mkdircommand = sprintf('mkdir %d', i);
        cpcommand = sprintf('cp %s %s %s %s %s %s %d',name1, name2, name3, name4, name5, name6, i);
        unix(mkdircommand);
        unix(cpcommand);  
    end
    cd(mainpath);
end