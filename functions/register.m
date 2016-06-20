function [save_registratered, registratered_center] = ...
    register(Rot, trans, save_cube, save_sphere, center_sphere, baseline_frame_index)
% Apply rotatin and translation to the cubes and the spheres to get the
% registered range data. 

NUM_FRAMES = size(save_cube,1);
NUM_PAIRS = size(save_sphere,2);
save_registratered = cell(NUM_FRAMES, 4);
registratered_center = zeros(size(center_sphere));
point = zeros(3,1);
for frame_index = 1:NUM_FRAMES
    
    % deal with baseline separately
    if frame_index == baseline_frame_index
        save_registratered(frame_index,1) = save_cube(frame_index);
        save_registratered(frame_index,2:4) = save_sphere(frame_index,:);
        continue;
    end
    % register the cubes
    test_data = save_cube{frame_index};
    for i = 1:size(test_data,1)
        test_data_point = test_data(i,1:3)';
        test_data_point = Rot(:,:,frame_index) * test_data_point;
        test_data_point = test_data_point + trans(:,frame_index);
        test_data(i,1:3) = test_data_point;
    end
    save_registratered{frame_index,1} = test_data;
    % register the spheres
    for j = 1:NUM_PAIRS
        test_data = save_sphere{frame_index,j};
        for i = 1:size(test_data,1)
            test_data_point = test_data(i,1:3)';
            test_data_point = Rot(:,:,frame_index) * test_data_point;
            test_data_point = test_data_point + trans(:,frame_index);
            test_data(i,1:3) = test_data_point;
            % register the center of spheres
            point(:) = center_sphere(frame_index,j,:);
            point = Rot(:,:,frame_index) * point;
            point = point + trans(:,frame_index);
            registratered_center(frame_index,j,:) = point;
        end
        save_registratered{frame_index,j+1} = test_data;
    end
end
