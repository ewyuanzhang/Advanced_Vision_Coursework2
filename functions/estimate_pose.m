function [Rot,trans] = estimate_pose(planenorm, planelist, center_sphere, baseline_frame_index)
% estimate the rotation matrix and translation vectors for each frame

Rot = zeros(3,3,size(planenorm,1));
trans = zeros(3,size(planenorm,1));

NUM_PAIRS = size(planenorm,2);
M = zeros(3,NUM_PAIRS);
D = zeros(3,NUM_PAIRS);
n = zeros(1,3);
d = zeros(1,3);
rd = zeros(1,3,3);
for frame_index = 1 : size(planenorm,1)
    % estimate rotation
    if frame_index == baseline_frame_index
        Rot(:,:,frame_index) = eye(3);
        trans(:,frame_index) = [0,0,0];
        continue;
    end
    for i = 1:NUM_PAIRS
        n(:) = planenorm(frame_index,i,:);
        M(:,i) = n';
        d(:) = planelist(i,:);
        D(:,i) = d';
    end
    [U,DG,V] = svd(D*M');
    Rot(:,:,frame_index) = U*V';
    
    % estimate translation
    for i = 1:NUM_PAIRS
        d(:) = center_sphere(frame_index,i,:);
        d(:) = Rot(:,:,frame_index) * d';
        rd(1,i,:) = d';
    end
    t = center_sphere(baseline_frame_index,:,:) - rd;
    trans(:,frame_index) = mean(t,2);
end