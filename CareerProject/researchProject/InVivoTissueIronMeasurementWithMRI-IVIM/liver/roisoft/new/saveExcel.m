function saveExcel(a, b, c, r, FolderName, FileReportName, tesla, n_hole)

% FileReportName = 'report_cmrtool.xlsx';
% FolderName = '2014-9-30';
% tesla = '15T';
alldata = cell(n_hole,6);
for i=1:n_hole
%     a=i;
%     b=i+1;
%     c=i+2;
%     r=i+3;
    sheet = i;
    [ndata, text, data] = xlsread(FileReportName, sheet);
    data{18,3} = [];
    data{19,1} = 'r-square';
    data{19,2} = r(i,1);
    data{20,1} = 'a';
    data{20,2} = a(i,1);
    data{21,1} = 'b';
    data{21,2} = b(i,1);
    data{22,1} = 'c';
    data{22,2} = c(i,1);
    T = cell2table(data(2:22,:),'VariableNames',{'TE','Segment_1','Scale_Factor'});
        if i<10
            label = ['0' num2str(i)]; 
        else
            label = num2str(i);
        end
    Filename = ['CMR_analyse_' FolderName '_' tesla '_' label '.csv'];
    writetable(T,Filename)
    alldata(i,:) = {i, a(i,1), b(i,1), c(i,1), r(i,1), data{18,2}};
end

iron_data = readtable('/Volumes/data2/data_staff/AIMC Research/Liver project_IVMI/MRIM-R2S_Validate/Phantoms/15T_iron_new.csv')

T2 = cell2table(alldata,'VariableNames',{'map_position','a_CMR','b_CMR','c_CMR','r_square_CMR','T2star_CMR'});
if size(T2,1)==8
    T3 = [iron_data(1:8,2:5) T2(:,2:6)];
else
    T3 = [iron_data(:,2:5) T2(:,2:6)];
end

writetable(T3,['CMR_analyse_' FolderName '_' tesla '.csv'])

