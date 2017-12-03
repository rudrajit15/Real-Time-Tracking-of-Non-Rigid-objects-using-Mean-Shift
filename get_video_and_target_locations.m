function [] = get_video_and_target_locations()
folder_name = uigetdir();
%for TableT1
y0_init = 167;
x0_init = 90;
delta_y = 7;
delta_x = 10;
h = 1;
h2 = 1;

%for i = 8:422
for i = 1:89
    i
    code_folder = cd(folder_name);
    if(i < 10)
        img_name = strcat('0000',int2str(i),'.jpg');
    elseif((i >= 10) && (i < 100))
        img_name = strcat('000',int2str(i),'.jpg');
    else
        img_name = strcat('00',int2str(i),'.jpg');
    end
    %curr_frame = rgb2gray(imread(img_name)); 
    curr_frame = imread(img_name); 
    cd(code_folder);
    %if(i == 8)
    if(i == 1)
        x0 = x0_init;
        y0 = y0_init;
        q = get_distribution(x0,y0,delta_x,delta_y,1,curr_frame);
    else
        [h_new,x0_new,y0_new] = get_target_location_per_frame(x0,y0,q,curr_frame,h,delta_x,delta_y);
        %p_new = get_distribution(x0_new,y0_new,hx,hy,delta_x,delta_y,curr_frame);
        %rho = get_rho(p_new,q);
        %sqrt(1-rho)
        %h = h_new;
        h2 = h_new;
        x0 = x0_new;
        y0 = y0_new;
    end
    %hx = round(h2*delta_x);
    %hy = round(h2*delta_y); 
    hx = delta_x;
    hy = delta_y;
    for j = max(1,x0-hx):min(size(curr_frame,1),x0+hx)
        curr_frame(j,max(1,y0-hy),1) = 255;
        curr_frame(j,min(size(curr_frame,2),y0+hy),1) = 255;
        curr_frame(j,max(1,y0-hy),2) = 255;
        curr_frame(j,min(size(curr_frame,2),y0+hy),2) = 255;
        curr_frame(j,max(1,y0-hy),3) = 255;
        curr_frame(j,min(size(curr_frame,2),y0+hy),3) = 255;
    end
    for j = max(1,y0-hy):min(size(curr_frame,2),y0+hy)
        curr_frame(max(1,x0-hx),j,1) = 255;
        curr_frame(min(size(curr_frame,1),x0+hx),j,1) = 255;
        curr_frame(max(1,x0-hx),j,2) = 255;
        curr_frame(min(size(curr_frame,1),x0+hx),j,2) = 255;
        curr_frame(max(1,x0-hx),j,3) = 255;
        curr_frame(min(size(curr_frame,1),x0+hx),j,3) = 255;
    end
    code_folder = cd(folder_name);
    if(i < 10)
        img_name = strcat('k0000',int2str(i),'.jpg');
    elseif((i >= 10) && (i < 100))
        img_name = strcat('k000',int2str(i),'.jpg');
    else
        img_name = strcat('k00',int2str(i),'.jpg');
    end
    imwrite(curr_frame,img_name);
    cd(code_folder);
end
  