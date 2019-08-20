function [numbers] = detectnumber(img)

loadtemp;

ind = {'a' '1' '2' '3' '4' '5' '6' '7' '8' '9' '0' 'dot'}; 
name = {'a' '1' '2' '3' '4' '5' '6' '7' '8' '9' '0' '.'}; 

count = 1;
count2 = 0;
for j=1:size(ind,2)

    [h w]=size(img);
    eval(sprintf('temp = temp%s;',char(ind(j))));
    [ht wt]=size(temp);
    
    for i=1:w

        roi = img(:,i:i+wt-1);
        newroi = temp - roi;
        if j==12 || j==2
            if sum(any(newroi)) == 0

                if j==1
                    img(:,i:i+wt-1) = 0;
                    count2 = count2 +1;
                
                
                elseif j==3
                    img(11,i+7-1) = 0;
                    pos(count,1) = j;
                    pos(count,2) = i;
                    count = count +1;
                else

                
    %                 figure ,imshow(roi);
                    pos(count,1) = j;
                    pos(count,2) = i;
                    count = count +1;
                end
            end
        else
            
            if sum(any(newroi)) < 1 && j == 9
                
                pos(count,1) = j;
                    pos(count,2) = i;
                    count = count +1;
                
            elseif sum(any(newroi)) < 3

                if j==1
                    img(:,i:i+wt-1) = 0;
                    count2 = count2 +1;
                
                
                elseif j==3
                    img(11,i+7-1) = 0;
                    pos(count,1) = j;
                    pos(count,2) = i;
                    count = count +1;
                else

                
    %                 figure ,imshow(roi);
                    pos(count,1) = j;
                    pos(count,2) = i;
                    count = count +1;
                 end
            end
        end
        


        
        if i+wt+1 > w
            break;
        end
    end

end

pos = sortrows(pos,2);

numbers = '';
for i=1:size(pos,1)
    index = pos(i,1);
    
    if i==1
    numbers = char(name(index));
    else
    
    number = char(name(index));
    numbers = [numbers number];
    end
end



g= 0;
