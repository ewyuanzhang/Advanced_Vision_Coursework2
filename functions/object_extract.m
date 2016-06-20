function [save_planes_temp, plane_list] = ...
    object_extract(R, num_planes, DISTTOL, BALANCE_VAL, ...
    RESTOL, DISTTOL_PLANE, PLANETOL, DELTA_POINTS)
    % separate diffrent objects from remaining data R after background
    % extraction. The number of objects are indicated by num_planes. 
    
    [NPts,W] = size(R);
    
    plane_list = zeros(num_planes,4);
    save_planes_temp = {};

    % find surface patches
    % here just get 5 first planes - a more intelligent process should be
    % used in practice. Here we hope the 4 largest will be included in the
    % 5 by virtue of their size
    remaining = R;
    for i = 1 : num_planes

        % select a random small surface patch
        [oldlist,plane] = select_patch(remaining, DISTTOL, BALANCE_VAL, RESTOL);

        % grow patch
        stillgrowing = 1;
        while stillgrowing

            % find neighbouring points that lie in plane
            stillgrowing = 0;
            [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts,DISTTOL_PLANE,PLANETOL);
            [NewL,W] = size(newlist);
            [OldL,W] = size(oldlist);

            if i == 1
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'m.')
            elseif i==2 
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'b.')
            elseif i == 3
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'g.')
            elseif i == 4
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'c.')
            elseif i == 5
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'y.')
            elseif i == 6
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'.','Color',[0,0.5,0])
            elseif i == 7
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'.','Color',[0.5,0.5,0])
            elseif i == 8
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'.','Color',[0.5,0,0.5])
            elseif i == 9
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'.','Color',[0,0.5,0.5])
            elseif i == 10
                plot3(newlist(:,1),newlist(:,2),newlist(:,3),'.','Color',[0.5,0,0])
            end
            save_planes_temp{i}=newlist;
            pause(1)

            if NewL > OldL + DELTA_POINTS
                % refit plane
                [newplane,fit] = fitplane(newlist, BALANCE_VAL);
                [newplane',fit,NewL]
                plane_list(i,:) = newplane';
                if fit > 0.04*NewL       % bad fit - stop growing
                    break
                end
                stillgrowing = 1;
                oldlist = newlist;
                plane = newplane;
            end
        end

        if size(remaining,1) < DELTA_POINTS
            break;
        end

        waiting=1
        pause(1)

    ['**************** Segmentation Completed']

    end
end