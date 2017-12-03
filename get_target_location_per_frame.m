function [h_final,x0_final,y0_final] = get_target_location_per_frame(x0_init,y0_init,q,img,h,delta_x,delta_y)
%this function is to be called for every frame 
%T1
delta_h = (2*h - 0.5*h)/10;
min_d = 1;
%T1
for hi = 0.5*h:delta_h:2*h
    x0 = x0_init;
    y0 = y0_init;
    while 1
        p = get_distribution(x0,y0,delta_x,delta_y,hi,img);
        rho0 = get_rho(p,q);
        % Need to round off to int here, as x0,y0 are the indices of an array which must be integers 
        [x0_new,y0_new] = get_new_target_direct(x0,y0,q,p,img,delta_x,delta_y,hi);
        x0_new = round(x0_new);
        y0_new = round(y0_new);
        p_new = get_distribution(x0_new,y0_new,delta_x,delta_y,hi,img);
        rho1 = get_rho(p_new,q);
        if(rho1 < rho0)
            x0_new = (x0_new + x0)/2;
            y0_new = (y0_new + y0)/2;
        end
        x0_new = round(x0_new);
        y0_new = round(y0_new);
        %convergence criteria
        if((x0_new == x0) && (y0_new == y0_new))
            break;
        else
            x0 = x0_new;
            y0 = y0_new; 
        end
    end
    p_new = get_distribution(x0_new,y0_new,delta_x,delta_y,hi,img);
    rho = get_rho(p_new,q);
    d = sqrt(1-rho);
    if(d < min_d)
        h_final = hi;
        min_d = d;
        x0_final = x0_new;
        y0_final = y0_new;
    end
end