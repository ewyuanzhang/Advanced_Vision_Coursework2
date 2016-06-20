function [save_planes_temp] = plane_sort(save_planes_temp)
%sort the planes by the nuber of points in it

    for i = 1:(size(save_planes_temp,2)-1)
        for j = (i+1):size(save_planes_temp,2)
            if size(save_planes_temp{i},1) < size(save_planes_temp{j},1)
                tmp = save_planes_temp{j};
                save_planes_temp{j} = save_planes_temp{i};
                save_planes_temp{i} = tmp;
            end
        end
    end
    
    