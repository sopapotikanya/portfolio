mainpath = pwd;
temppath='/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/roisoft/new/template/temp-mat';
cd(temppath)
 
tempname = {'1' '2' '3' '4' '5' '6' '7' '8' '9' '0' 'a' 'dot'}; 
for i=1:size(tempname,2)
    name = [char(tempname(i)) '.mat'];
    load(name);
    newname = ['temp' char(tempname(i))];
    eval(sprintf('%s = %d;',newname,0));
    eval(sprintf('%s = temp;',newname));
end

cd(mainpath)