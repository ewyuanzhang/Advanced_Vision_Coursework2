function [center_y_balls, center_w_big_balls, center_w_small_balls, pairs] = ...
    pair_spheres(save_sphere, center_sphere, radius_sphere, baseline_frame_index)
% pair 3 spheres by their colors and sizes. Put all of the paired data in 
% center_y_balls, center_w_big_balls and center_w_small_balls 

NUM_FRAMES = size(save_sphere,1);
NUM_PAIRS = size(center_sphere,2);
center_y_balls = zeros(NUM_FRAMES,3);
center_w_big_balls = zeros(NUM_FRAMES,3);
center_w_small_balls = zeros(NUM_FRAMES,3);

% indicate the pairs of vectors of vertices of baseline model and others
% pair(i,j,1) is from baseline and pair(i,j,2) is others
pairs = zeros(NUM_FRAMES,NUM_PAIRS,2);

for i = 1:NUM_FRAMES
    % find the yellow ball by its color
    min_dis_yellow = norm([256,256,256]);
    for j = 1:3
        data_ball = save_sphere{i,j};
        dis_yellow = norm(median(data_ball(:,4:6)) - [255, 255, 0]);
        if min_dis_yellow > dis_yellow
            min_dis_yellow = dis_yellow;
            yellow_index = j;
        end
    end
    center_y_balls(i,:) = center_sphere(i,yellow_index,:);
    
    % find the big white ball by size
    index = 1:3;
    index2 = index(index~=yellow_index);
    [~,white_big_index] = max(radius_sphere(i,index2));
    center_w_big_balls(i,:) = center_sphere(i,index2(white_big_index),:);
    
    % the third one
    index3 = sum(index) - yellow_index - index2(white_big_index);
    center_w_small_balls(i,:) = center_sphere(i,index3,:);
    
    pairs(i,1,2) = yellow_index;
    pairs(i,2,2) = index2(white_big_index);
    pairs(i,3,2) = index3;
    if i == baseline_frame_index
        for nf = 1:NUM_FRAMES
            pairs(NUM_FRAMES,1,1) = yellow_index;
            pairs(NUM_FRAMES,2,1) = index2(white_big_index);
            pairs(NUM_FRAMES,3,1) = index3;
        end
    end
end