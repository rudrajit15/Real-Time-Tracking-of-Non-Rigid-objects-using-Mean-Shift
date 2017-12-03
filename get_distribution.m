function [p] = get_distribution(x0,y0,delta_x,delta_y,h,img)
p = zeros(33,33,33);
C = 0;
hx = round(h*delta_x);
hy = round(h*delta_y);
for i = max(1,x0-hx):min(size(img,1),x0+hx)
    for j = max(1,y0-hy):min(size(img,2),y0+hy)
        zx = (i-x0)^2/hx^2;
        zy = (j-y0)^2/hy^2;
        f = kernel(zx+zy);
        u1 = floor(img(i,j,1)/8) + 1;
        u2 = floor(img(i,j,2)/8) + 1;
        u3 = floor(img(i,j,3)/8) + 1;
        p(u1,u2,u3) = p(u1,u2,u3) + f;
        C = C + f;
    end
end
p = p/C;



