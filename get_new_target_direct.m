function [x0_new,y0_new] = get_new_target_direct(x0,y0,q,p,img,delta_x,delta_y,h)
x0_new = 0;
y0_new = 0;
Z = 0;
hx = round(h*delta_x);
hy = round(h*delta_y);
for i = max(1,x0-hx):min(size(img,1),x0+hx)
    for j = max(1,y0-hy):min(size(img,2),y0+hy)
        u1 = floor(img(i,j,1)/8) + 1;
        u2 = floor(img(i,j,2)/8) + 1;
        u3 = floor(img(i,j,3)/8) + 1;
        wi = sqrt(q(u1,u2,u3)/p(u1,u2,u3));
        dx = (i-x0)^2/hx^2;
        dy = (j-y0)^2/hy^2;
        g = kernel_derivative(dx+dy);
        x0_new = x0_new + i*wi*g;
        y0_new = y0_new + j*wi*g;
        Z = Z + wi*g;
    end
end
x0_new = x0_new/Z;
y0_new = y0_new/Z;