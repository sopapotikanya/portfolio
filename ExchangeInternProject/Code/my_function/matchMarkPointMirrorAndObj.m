function pair_mark = matchMarkPointMirrorAndObj(mark,I)
% mark(pt on mirror, pt on obj)
top = 470; 
bottom = 500;
% top = 420; 
% bottom = 460;
mark_ignore = mark(mark(:,2) > top & mark(:,2) < bottom,:);
mark_mirror = mark(mark(:,2) < top,:);
mark_obj = mark(mark(:,2) > bottom,:);

figure, imshow(I);
hold on
plot(mark_ignore(:,1),mark_ignore(:,2),'or','LineWidth',2);
plot(mark_mirror(:,1),mark_mirror(:,2),'ob','LineWidth',2);
plot(mark_obj(:,1),mark_obj(:,2),'og','LineWidth',2);

mark_mirror = sortrows(mark_mirror,2,'descend');
mark_obj = sortrows(mark_obj,2,'ascend');

pair_mark = [];
mark_obj2 = mark_obj;
for m=1:size(mark_mirror,1)
    norm_mark = [];
    for o=1:size(mark_obj2,1)
        norm_mark(o,:) = norm(mark_obj2(o,:) - mark_mirror(m,:));
    end
    [~,idx] = min(norm_mark);
    pair = [mark_mirror(m,:),mark_obj2(idx,:)];
    pair_mark = cat(1,pair_mark,pair);
    mark_obj2(idx,:) = [];
    
    plot(pair(1:2:4),pair(2:2:4),'-','LineWidth',2);
end
hold off