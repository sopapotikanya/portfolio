clear all

indexxx = [2 , 3, 4, 5, 6, 7, 8, 9, 10 ,11 ,12 ,13 ,14 ,15, 16 ,17];

for j = 1:size(indexxx,2)
    cd(num2str(indexxx(j)));
    dicomlist = dir('S*');
    
    for i = 1 : size(dicomlist,1)
        dcml = dicominfo(dicomlist(i).name);
        echotime(i,1) = dcml.EchoTime;
        echotime(i,2) = dcml.EchoNumber;
        echotime(i,3) = str2num(dcml.SeriesTime);
        %     echotime{i,1} = dcml.EchoTime;
        %     echotime{i,2} = dcml.EchoNumber;
        %     echotime{i,3} = dcml.SeriesTime;
        %     echotime{i,4} = dicomlist(i).name;
    end
    eval(sprintf('seri%d = sort(echotime, 1);', indexxx(j)));
    j
    cd ../
end
