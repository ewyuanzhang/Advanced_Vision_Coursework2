function [plane_vertice] = find_intersection(cube_points, ...
    save_cube_planes, cube_plane_list, baseline_bg_plane, IS_SPHERE_PLOT)
% find intersectin points of cube planes, plot them and sort them

    %% plot sube points and fitted sphere
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

    [sph_cube_center, sph_cube_rad] = sphereFit(cube_points(:,1:3));
    if IS_SPHERE_PLOT == 1
        [X,Y,Z] = sphere(20);
        surf(sph_cube_center(1)+X*sph_cube_rad, sph_cube_center(2)+Y*sph_cube_rad, sph_cube_center(3)+Z*sph_cube_rad);
    end

    %% find intersection points by solving linear equations of 3 planes
    A = zeros(3);
    b = zeros(3,1);
    cube_plane_list(10,:) = baseline_bg_plane;
    plane_vertice = cell(size(cube_plane_list,1),1);
    for i = 1:size(cube_plane_list,1)
        plane_vertice{i} = zeros(0,3);
        for j = 1:size(cube_plane_list,1)-1
            if i == j
                continue;
            end
            for k = j+1:size(cube_plane_list,1)
                if i == k
                    continue;
                end
                n1 = cube_plane_list(i,:);
                n2 = cube_plane_list(j,:);
                n3 = cube_plane_list(k,:);
                if abs(n1(1:3) * n2(1:3)') > 0.8 || abs(n1(1:3) * n3(1:3)') > 0.8 || ...
                        abs(n2(1:3) * n3(1:3)') > 0.8
                    continue;
                end
                A(1,:) = n1(1:3);
                A(2,:) = n2(1:3);
                A(3,:) = n3(1:3);
                b(1) = -n1(4);
                b(2) = -n2(4);
                b(3) = -n3(4);
                intersect = (A \ b)'; 
                if i == 10 || j == 10 || k == 10
                    if norm(intersect-sph_cube_center) > sph_cube_rad * 1.6
                        continue;
                    end
                else
                    if norm(intersect-sph_cube_center) > sph_cube_rad * 1.35
                        continue;
                    end
                end
                quit = 0;
                for p = 1:i
                    if size(plane_vertice{p},1) > 0
                        for q = 1:size(plane_vertice{p},1)
                            if norm(intersect - plane_vertice{p}(q,:)) < 0.35 * sph_cube_rad
                                intersect = (intersect + plane_vertice{p}(q,:)) / 2;
                                plane_vertice{p}(q,:) = intersect;
                                quit = p;
                            end
                        end
                    end
                end
                if quit ~= i
                    plane_vertice{i}(end+1,:) = intersect;
                end
                [X,Y,Z] = sphere(20);
                surf(intersect(1)+X*0.002, intersect(2)+Y*0.002, intersect(3)+Z*0.002);
                pause(0.1);
            end
        end
    end
    
    %% sort the vertices to make the planes convex polygons
    for i = 1:size(plane_vertice,1)
        if size(plane_vertice{i},1) <= 3
            continue;
        end
        for j = 1:size(plane_vertice{i},1)-2
            dis_min = 1;
            min_index = j + 1;
            for k = j+1:size(plane_vertice{i},1)
                dis = norm(plane_vertice{i}(j,:) - plane_vertice{i}(k,:));
                if dis < dis_min
                    min_index = k;
                    dis_min = dis;
                end
            end
            tmp = plane_vertice{i}(min_index,:);
            plane_vertice{i}(min_index,:) = plane_vertice{i}(j+1,:);
            plane_vertice{i}(j+1,:) = tmp;
        end
    end
end