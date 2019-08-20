
DB_type = 'YorkUrbanDB';
listfile = dir(['../Database/' DB_type ]);
for i = 3:size(listfile,1)
    if listfile(i).isdir
        filename = listfile(i).name;
        if ~strncmp(filename, '.', 1)
            [~] = lsd(filename,DB_type);
        end
    end
end

DB_type = 'HedauDB';
listfile = dir(['../Database/' DB_type '/Images']);
for i = 3:size(listfile,1)
    filename = listfile(i).name;
    if ~strncmp(filename, '.', 1) && ~strncmp(filename, 'Thumb.db', 1)
        [~] = lsd(filename(1,1:end-4),DB_type);
    end
end

