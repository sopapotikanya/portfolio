function savePatient(CMRtool_name,dcm_name,ROI_folder,roi,orig_img_fig,dicom_img_fig)
CMRtool_path = strsplit(CMRtool_name,'/');
    
    dcm_path = strsplit(dcm_name,'/');
    dcm_folder = dcm_path{1,size(dcm_path,2)-1};
    if size(strfind(CMRtool_path{1,size(CMRtool_path,2)},'LIVER'),1) == 1
        if size(strfind(CMRtool_path{1,size(CMRtool_path,2)},'LT'),1) == 1
            part = [dcm_folder '_LT'];
        elseif size(strfind(CMRtool_path{1,size(CMRtool_path,2)},'RT'),1) == 1
            part = [dcm_folder '_RT'];
        end
    else
        part = dcm_folder;
    end
save([ROI_folder '/roi_' part '.mat'],'roi');
saveas(orig_img_fig,[ROI_folder '/orig_img_' part '.jpg']) ;
saveas(dicom_img_fig,[ROI_folder '/dicom_img_fig_' part '.jpg']) ;