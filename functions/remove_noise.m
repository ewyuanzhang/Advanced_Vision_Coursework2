function data_remain = remove_noise(bg_data, remaining, COLOR_THRESHOLD)
    % remove noise by indensity image
    
    bg_color = median(bg_data(:,4:6));
    data_remain = [];
    for i = 1:size(remaining,1)
        if abs(median(remaining(i,4:6)) - bg_color) > COLOR_THRESHOLD
            data_remain(end+1,:) = remaining(i,:);
        end
    end
end