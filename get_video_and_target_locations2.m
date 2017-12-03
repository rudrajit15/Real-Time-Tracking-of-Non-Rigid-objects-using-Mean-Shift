function [] = get_video_and_target_locations2()
folder_name = uigetdir();
%for malaya2
%y0_init = 284;
%x0_init = 31;
%delta_y = 18;
%delta_x = 19;
%h = sqrt(delta_x^2+delta_y^2);
%for gaussian
%hx = 18;
%hy = 19;

%for TableT1
y0_init = 167;
x0_init = 90;
%delta_y = 8;
%delta_x = 11;
delta_y = 6;
delta_x = 9;
h = 1;
%h = sqrt(delta_x^2+delta_y^2);
%for gaussian
%h = 8; 
%hy = ceil(6*sqrt(2));
%hx = ceil(9*sqrt(2));
%hy = 6;
%hx = 9;
%h = 10;
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
        h = h_new;
        x0 = x0_new;
        y0 = y0_new;
    end
    for j = max(1,x0-delta_x):min(size(curr_frame,1),x0+delta_x)
        curr_frame(j,max(1,y0-delta_y),1) = 255;
        curr_frame(j,min(size(curr_frame,2),y0+delta_y),1) = 255;
        curr_frame(j,max(1,y0-delta_y),2) = 255;
        curr_frame(j,min(size(curr_frame,2),y0+delta_y),2) = 255;
        curr_frame(j,max(1,y0-delta_y),3) = 255;
        curr_frame(j,min(size(curr_frame,2),y0+delta_y),3) = 255;
    end
    for j = max(1,y0-delta_y):min(size(curr_frame,2),y0+delta_y)
        curr_frame(max(1,x0-delta_x),j,1) = 255;
        curr_frame(min(size(curr_frame,1),x0+delta_x),j,1) = 255;
        curr_frame(max(1,x0-delta_x),j,2) = 255;
        curr_frame(min(size(curr_frame,1),x0+delta_x),j,2) = 255;
        curr_frame(max(1,x0-delta_x),j,3) = 255;
        curr_frame(min(size(curr_frame,1),x0+delta_x),j,3) = 255;
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
  