function [center_sphere, radius_sphere, center_of_mass] = ...
    sphere_recognition(save_sphere)
% find and plot spheres

    center_sphere = zeros(size(save_sphere,2),3);
    radius_sphere = zeros(size(save_sphere,2),1);
    center_of_mass = zeros(size(save_sphere,2),3);
    
    for i = 1:size(save_sphere,2)
        [center_sphere(i,:), radius_sphere(i)]...
            = sphereFit(save_sphere{i});
        center_of_mass(i,:) = mean(save_sphere{i}(:,1:3));
    end
    
    for i = 1:size(save_sphere,2)
        [X,Y,Z] = sphere(10);
        surf(X*radius_sphere(i)+center_sphere(i,1), ...
            Y*radius_sphere(i)+center_sphere(i,2), ...
            Z*radius_sphere(i)+center_sphere(i,3))
        p_list = save_sphere{i};
        if i == 1
            plot3(p_list(:,1),p_list(:,2),p_list(:,3),'r.')
        elseif i==2 
            plot3(p_list(:,1),p_list(:,2),p_list(:,3),'b.')
        elseif i == 3
            plot3(p_list(:,1),p_list(:,2),p_list(:,3),'g.')
        end
    end
end