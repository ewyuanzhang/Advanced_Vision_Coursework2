function [plane_norm, remaining, bg_data] = ...
    background_extract(pcl_cell, frame_index, DISTTOL, BALANCE_VAL, ...
    RESTOL, DISTTOL_PLANE_BG, PLANETOL_BG, DELTA_POINTS, DIST_THREHOLD)
    % Extract background from the frame indicated by frame_index in
    % pcl_cell. 
    
    pcl_img = pcl_cell{frame_index};
    
    R = [reshape(pcl_img(:,:,4),[],1), reshape(pcl_img(:,:,5),[],1), ...
        reshape(pcl_img(:,:,6),[],1), reshape(pcl_img(:,:,1),[],1), ...
        reshape(pcl_img(:,:,2),[],1), reshape(pcl_img(:,:,3),[],1)];
    R = R(max(R(:,1:3),[],2) > 0,:);
    
    %plot3(R(:,1),R(:,2),R(:,3),'k.')

    [NPts,W] = size(R);

    % find surface patches
    % here just get 5 first planes - a more intelligent process should be
    % used in practice. Here we hope the 4 largest will be included in the
    % 5 by virtue of their size    
    NewL = 0;
    
    while NewL < 200000
        
        remaining = R;
        NewL = 0;
        % select a random small surface patch
        [oldlist,plane] = select_patch(remaining, DISTTOL, BALANCE_VAL, RESTOL, 1, DIST_THREHOLD);
        plot3(oldlist(:,1),oldlist(:,2),oldlist(:,3),'k.')

        % grow patch
        stillgrowing = 1;
        
        while stillgrowing

            % find neighbouring points that lie in plane
            stillgrowing = 0;
            [newlist,remaining] = getallpoints(...
                plane,oldlist,remaining,NPts,DISTTOL_PLANE_BG,PLANETOL_BG);
            [NewL,W] = size(newlist);
            [OldL,W] = size(oldlist);
            
            plot3(newlist(:,1),newlist(:,2),newlist(:,3),'r.')

            pause(1);
            
            if NewL < 10000
                break;
            end
            
            if NewL > OldL + DELTA_POINTS
                % refit plane
                [newplane,fit] = fitplane(newlist, BALANCE_VAL);
                [newplane',fit,NewL]
                plane_norm = newplane';
                bg_data = newlist;
                if fit > 0.04*NewL       % bad fit - stop growing
                    break
                end
                stillgrowing = 1;
                oldlist = newlist;
                plane = newplane;
            end

        end

        waiting=1
        pause(1)

    ['**************** Segmentation Completed']

    end
end