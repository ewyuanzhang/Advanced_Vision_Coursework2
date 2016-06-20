clear;

load('av_pcl.mat');
addpath('./functions')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters

% distance tolerance of detecting
DISTTOL = 0.01; %5; %0.005;
% the balance value add to the end of normal vector
% I don't know what it means
BALANCE_VAL = 100;
RESTOL = 0.1; %0.1; %1e-5;
DISTTOL_PLANE_BG = 0.008; % 1;
PLANETOL_BG = 10; % 10;
DISTTOL_PLANE = 0.1; % 1;
PLANETOL = 0.07; % 10;
DELTA_POINTS = 50;
COLOR_THRESHOLD = 20;
DIST_THREHOLD = 0.1;
% number of frames
NUM_FRAMES = 16;
NUM_SPHERE = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_bg = cell(NUM_FRAMES,1);
save_sphere = cell(NUM_FRAMES,3);
save_cube = cell(NUM_FRAMES,1);
center_sphere = zeros(size(save_sphere,1),size(save_sphere,2),3);
radius_sphere = zeros(size(save_sphere,1),size(save_sphere,2),1);
center_of_mass = zeros(size(save_sphere,1),size(save_sphere,2),3);
bg_plane_list = zeros(NUM_FRAMES,4);


% rand_area = reshape(1:(size(pcl_cell{1},1)*size(pcl_cell{1},2)), ...
% [size(pcl_cell{1},1),size(pcl_cell{1},2)]);
% rand_area = rand_area(:, INI_AREA_START_C:INI_AREA_END_C);
% rand_area = reshape(rand_area,[],1);

% global model planelist planenorm facelines

frame_index = 1;

while frame_index <= 1
    %% background extraction
    figure(frame_index);
    clf
    hold on
    
    [bg_plane_list(frame_index,:), remaining, save_bg{frame_index}] = ...
        background_extract(pcl_cell, frame_index, DISTTOL, BALANCE_VAL, ...
        RESTOL, DISTTOL_PLANE_BG, PLANETOL_BG, DELTA_POINTS, DIST_THREHOLD);
    
    data_remain = remove_noise(save_bg{frame_index}, remaining, COLOR_THRESHOLD);

    %% object recognition
    
    [save_planes_temp, plane_list] = object_extract(data_remain, 10, DISTTOL, BALANCE_VAL, ...
        RESTOL, DISTTOL_PLANE, PLANETOL, DELTA_POINTS);
    
    % check whether the number of objects is greater than 4
    % if not, extract background again
%     if size(save_planes_temp,2) < 4
%         continue;
%     end
    
    %% save points of spheres and cubes
    [save_planes_temp] = plane_sort(save_planes_temp);
    
    save_cube(frame_index) = save_planes_temp(1);
    save_sphere(frame_index,:) = save_planes_temp(2:1+NUM_SPHERE);

    %% find and plot sphere
    
    [center_sphere(frame_index,:,:), radius_sphere(frame_index,:)] = ...
        sphere_recognition(save_sphere(frame_index,:));
    pause(0.1);
    
    frame_index = frame_index + 1;
end
