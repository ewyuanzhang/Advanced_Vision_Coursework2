function evaluate_register(save_cube_planes, baseline_frame_index, BALANCE_VAL)
% evaluate the effect of register by computing the inner product between
% the normal vectors of the top of the cube from baseline and other views

plane_data = save_cube_planes{1};
plane_data = plane_data(plane_data(:,7) == baseline_frame_index, :);
NUM_FRAMES = max(plane_data(:,7));
eval_normal = zeros(NUM_FRAMES,4);
[plane, fit] = fitplane(plane_data, BALANCE_VAL);
baseline_normal = plane;
for i = 1:NUM_FRAMES
    if i == baseline_frame_index
        continue;
    end
    plane_data = save_cube_planes{1};
    plane_data = plane_data(plane_data(:,7) == i, :);
    [plane, fit] = fitplane(plane_data, BALANCE_VAL);
    eval_normal(i,:) = plane;
    
    evaluation = 1-baseline_normal(1:3)' * plane(1:3)
end