function plot_cube_model(plane_vertice, save_cube_planes, ...
    DIST_SAMPLE, IS_100_POINTS, IS_TRANGLES, NUM_POINTS, IS_TRUE_COLOUR)
% plot the model of cube, can be choose from plotting 100 points or
% trangles

% DIST_SAMPLE = 1;

if IS_100_POINTS == 1
    figure(44);
    hold on;
end
% if IS_TRANGLES == 1
%     figure(45);
%     hold on;
% end

plot_data = [];
for i = 1:size(plane_vertice, 1) - 1
    vertices = plane_vertice{i};
    max_x = max(vertices(:,1));
    min_x = min(vertices(:,1));
    max_y = max(vertices(:,2));
    min_y = min(vertices(:,2));
    
    in_num = 0;
    sample_x = [];
    sample_y = [];
    
    indice = [];
    while in_num < NUM_POINTS
        remain_num = NUM_POINTS - in_num;
        
        rand_x = rand(100,1) * (max_x - min_x) + min_x;
        rand_y = rand(100,1) * (max_y - min_y) + min_y;
        [IN, ON] = inpolygon(rand_x, rand_y, vertices(:,1), vertices(:,2));
        in_x_new = rand_x(IN|ON);
        in_y_new = rand_y(IN|ON);
        
%         [in_x_new,in_y_new]
        
        plane_data_x = save_cube_planes{i}(:,1);
        plane_data_x = repmat(plane_data_x,[1,size(in_x_new,1)]);
        plane_data_y = save_cube_planes{i}(:,2);
        plane_data_y = repmat(plane_data_y,[1,size(in_y_new,1)]);
        in_x_new = repmat(in_x_new', [size(save_cube_planes{i},1),1]);
        in_y_new = repmat(in_y_new', [size(save_cube_planes{i},1),1]);
        dist = (plane_data_x - in_x_new).^2 + (plane_data_y - in_y_new).^2;
        dist(dist > DIST_SAMPLE^2) = 1;  % big enough
        
        [~, index] = min(dist,[],1);
        
        if remain_num >= size(index,2)
            indice = [indice;index'];
            in_num = in_num + size(index,2);
        else
            indice = [indice;index(1:remain_num)'];
            in_num = NUM_POINTS;
        end
    end
    
    sample_data = save_cube_planes{i}(indice,:);
    plot_data = [plot_data;sample_data];
    
    sample_data_square = reshape([sample_data(:,4:6),sample_data(:,1:3)], [10,10,6]);
    plotpcl(sample_data_square);
    
    if IS_100_POINTS == 1
        figure(44);
        plot3(sample_data(:,1), sample_data(:,2), sample_data(:,3), '.');
    end
%     if IS_TRANGLES == 1
%         figure(45);
%         tri = delaunay(sample_data(:,1),sample_data(:,2), sample_data(:,3));
%         trisurf(tri,sample_data(:,1), sample_data(:,2), sample_data(:,3));
%     end
    
end
%%
if IS_TRANGLES == 1
    figure(45);
    tri = delaunay(plot_data(:,1),plot_data(:,2),plot_data(:,3));
    ts = trisurf(tri,plot_data(:,1), plot_data(:,2), plot_data(:,3));
end

if IS_TRUE_COLOUR == 1
    figure(46);
    tri = delaunay(plot_data(:,1),plot_data(:,2),plot_data(:,3));
    ts = trisurf(tri,plot_data(:,1), plot_data(:,2), plot_data(:,3));
    ts.FaceVertexCData = plot_data(:,4:6)./255;
end
