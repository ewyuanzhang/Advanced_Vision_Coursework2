function [r_center_y_balls, r_center_w_big_balls, r_center_w_small_balls] ...
    = register_balls(Rot, trans, center_y_balls, center_w_big_balls, center_w_small_balls)
% register the paired balls

NUM_FRAMES = size(Rot,3);
r_center_y_balls = zeros(NUM_FRAMES,3);
r_center_w_big_balls = zeros(NUM_FRAMES,3);
r_center_w_small_balls = zeros(NUM_FRAMES,3);

for i = 1:NUM_FRAMES
    r_center_y_balls(i,:) = (Rot(:,:,i) * center_y_balls(i,:)') + trans(:,i);
    r_center_w_big_balls(i,:) = (Rot(:,:,i) * center_w_big_balls(i,:)') + trans(:,i);
    r_center_w_small_balls(i,:) = (Rot(:,:,i) * center_w_small_balls(i,:)') + trans(:,i);
end