% clear
% load('av_ass2_obj_20160307_1626.mat');
% load('av_ass2_obj_20160307_1311.mat');
% clear;
% load('av_ass2_model_20160308_2141.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
BG_EXTRACT = 0;
baseline_frame_index = 11;
IS_SPHERE_PLOT = 1;
DIST_SAMPLE = 0.01;  % largest distance from sample points to real ones
IS_100_POINTS = 1;
IS_TRANGLES = 1;
NUM_POINTS = 100;
IS_TRUE_COLOUR = 1;
DIST_THREHOLD = 0.1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% background extraction for baseline
if BG_EXTRACT == 1
    figure(41);
    clf
    hold on
    
    [baseline_bg_plane, ~, ~] = ...
        background_extract(pcl_cell, baseline_frame_index, DISTTOL, BALANCE_VAL, ...
        RESTOL, DISTTOL_PLANE_BG, PLANETOL_BG, DELTA_POINTS, DIST_THREHOLD);
end

%% find intersectin points of cube planes, plot them and sort them
figure(42);
clf
hold on;

[plane_vertice] = find_intersection(cube_points, ...
    save_cube_planes, cube_plane_list, baseline_bg_plane, IS_SPHERE_PLOT);

%% evaluation
evaluate_register(save_cube_planes, baseline_frame_index, BALANCE_VAL);

%% sample

plot_cube_model(plane_vertice, save_cube_planes, ...
    DIST_SAMPLE, IS_100_POINTS, IS_TRANGLES, NUM_POINTS, IS_TRUE_COLOUR);
