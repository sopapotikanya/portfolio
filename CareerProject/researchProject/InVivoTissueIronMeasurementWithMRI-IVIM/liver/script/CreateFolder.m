part_orig = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/PatientsOLD/Adults/disease/1.5T/newDICOM2';
part_target = '/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Patients/Adult/Thalassemic';

cd(part_orig)
d_name = dir;

cd(part_target)
j = 2;
for i = 1:(size(d_name,1)-4)
    j = j+1;
    dir_name = d_name(j).name    
    mkdir(dir_name);
    cd(dir_name);
    !mkdir HEART LIVER PANCREASE
        cd HEART
        !mkdir 1.5T 3T
            cd 1.5T
            !mkdir DICOM ROI CMRtools
            cd ../3T
            !mkdir DICOM ROI CMRtools
        cd ../..
        
        cd LIVER
        !mkdir 1.5T 3T
            cd 1.5T
            !mkdir DICOM ROI CMRtools
            cd ../3T
            !mkdir DICOM ROI CMRtools
        cd ../..
        
   
        
        cd PANCREASE
        !mkdir 1.5T 3T
            cd 1.5T
            !mkdir DICOM ROI CMRtools
            cd ../3T
            !mkdir DICOM ROI CMRtools
        cd ../..
     cd(part_target)
end