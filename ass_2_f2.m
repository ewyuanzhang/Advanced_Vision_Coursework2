% clear;
% load('av_ass2_20160306_0010.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
baseline_frame_index = 11;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% (now it is in ass_2_f1)
center_of_mass = zeros(NUM_FRAMES, 3, 3);
for i = 1:NUM_FRAMES
    center_of_mass(i,1,:) = mean(save_sphere{i,1}(:,1:3));
    center_of_mass(i,2,:) = mean(save_sphere{i,2}(:,1:3));
    center_of_mass(i,3,:) = mean(save_sphere{i,3}(:,1:3));
end

%% pairing

[center_y_balls, center_w_big_balls, center_w_small_balls, pairs] = ...
    pair_spheres(save_sphere, center_sphere, radius_sphere, baseline_frame_index);

%% estimate the pose

[planelist, planenorm] = build_model(center_of_mass, center_sphere, baseline_frame_index, pairs);

[Rot,trans] = estimate_pose(planenorm, planelist, center_sphere, baseline_frame_index);

%% register

[save_registratered, registratered_center] = ...
    register(Rot, trans, save_cube, save_sphere, center_sphere, baseline_frame_index);

[r_center_y_balls, r_center_w_big_balls, r_center_w_small_balls] ...
    = register_balls(Rot, trans, center_y_balls, center_w_big_balls, center_w_small_balls);

%% plot 
plot_data = [];
for frame_index = 1:16
    for j = 1:size(save_registratered,2)
        plot_data = [plot_data; save_registratered{frame_index,j}];
    end
%     for j = 1:size(save_cube,2)
%         plot_data = [plot_data; save_cube{frame_index,j}];
%     end
%     for j = 1:size(save_sphere,2)
%         plot_data = [plot_data; save_sphere{frame_index,j}];
%     end
end
plot_data = [plot_data(:,4:6),plot_data(:,1:3)];
pcl = ones(102400,size(plot_data,2));
pcl(1:size(plot_data,1),:) = plot_data;
pcl = reshape(pcl, 320,320,6);

plotpcl(pcl);

%% evaluate registration
normal_b = cross(r_center_y_balls(baseline_frame_index,:) ...
    - r_center_w_big_balls(baseline_frame_index,:), ...
    r_center_w_big_balls(baseline_frame_index,:) ...
    - r_center_w_small_balls(baseline_frame_index,:));
for i = 1:NUM_FRAMES
    if i == baseline_frame_index
        continue;
    end
    normal_v = cross(r_center_y_balls(i,:) - r_center_w_big_balls(i,:), ...
        r_center_w_big_balls(i,:) - r_center_w_small_balls(i,:));
    cross(normal_b, normal_v)
end



