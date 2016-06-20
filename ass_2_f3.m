% clear;
% load('av_ass2_reg_20160307_1309.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters

% distance tolerance of detecting
DISTTOL = 0.01; %5; %0.005;
% the balance value add to the end of normal vector
% I don't know what it means
BALANCE_VAL = 100;
RESTOL = 0.1; %0.1; %1e-5;
DISTTOL_PLANE_CUBE = 0.005; % 1;
PLANETOL_CUBE = 0.1; % 10;
DELTA_POINTS = 50;
COLOR_THRESHOLD = 20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% collect cube points
cube_points = [];
for i = 1:size(save_registratered(:,1),1)
    new_data = [save_registratered{i,1}, i*ones(size(save_registratered{i,1},1),1)];
    cube_points = [cube_points; new_data];
end

%% cube plane extraction

figure(31);
clf
hold on

[save_planes_temp, plane_list] = object_extract(cube_points, 15, DISTTOL, BALANCE_VAL, ...
        RESTOL, DISTTOL_PLANE_CUBE, PLANETOL_CUBE, DELTA_POINTS);

%% save points of surfaces of the cube
[save_planes_temp] = plane_sort(save_planes_temp);

save_cube_planes = save_planes_temp(1:9);
cube_plane_list = zeros(9,4);
for i = 1:9
    cube_plane_list(i,:) = fitplane(save_cube_planes{i}, BALANCE_VAL);
end

%% plot

figure(32);
hold on;
for i = 1:size(save_cube_planes,2)
    if i == 1
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'m.')
    elseif i==2 
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'b.')
    elseif i == 3
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'g.')
    elseif i == 4
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'c.')
    elseif i == 5
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'y.')
    elseif i == 6
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'.','Color',[0,0.5,0])
    elseif i == 7
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'.','Color',[0.5,0.5,0])
    elseif i == 8
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'.','Color',[0.5,0,0.5])
    elseif i == 9
        plot3(save_cube_planes{i}(:,1),save_cube_planes{i}(:,2),save_cube_planes{i}(:,3),'.','Color',[0,0.5,0.5])
    end
end

