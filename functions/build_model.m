function [planelist, planenorm, pairs] = ...
    build_model(center_of_mass, center_sphere, baseline_frame_index, pairs)
% build a model by creating 3 vactors from center of each sphere pointing 
% to another sphere's center of mass. planelist is the model of baseline,
% and planenorm is the others (including baseline). 

NUM_FRAMES = size(center_sphere,1);
NUM_PAIRS = size(center_sphere,2);
planenorm = zeros(NUM_FRAMES, NUM_PAIRS, 3);
for i = 1:NUM_FRAMES
    planenorm(i,1,:) = center_of_mass(i,pairs(i,1,2),:) - center_sphere(i,pairs(i,2,2),:);
    planenorm(i,2,:) = center_of_mass(i,pairs(i,2,2),:) - center_sphere(i,pairs(i,3,2),:);
    planenorm(i,3,:) = center_of_mass(i,pairs(i,3,2),:) - center_sphere(i,pairs(i,1,2),:);
end

planelist = zeros(3,3);
planelist(:) = planenorm(baseline_frame_index,:,:);