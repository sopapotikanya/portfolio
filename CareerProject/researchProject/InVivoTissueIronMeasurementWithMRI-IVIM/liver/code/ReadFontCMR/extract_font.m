function BW_img = extract_font(color_img,color)
h = size(color_img,1);
w = size(color_img,2);
BW_img = ones(h,w);

for m=1:h
    for n=1:w
        if (color_img(m,n,1) == color_img(m,n,2)) && (color_img(m,n,1) == color_img(m,n,3))
            BW_img(m,n) = 0;
        end
        if color_img(m,n,:) == color
            BW_img(m,n) = 0;
        end
    end
end