function [current_road_id, localPoints_map] = Global2Local_path(path, start_x, start_y)
% Load data
f1 = load('final\Data\Data\waypoints_data.mat');
f2 = load('final\Data\Data\roadprofiles_data.mat');
n_roadprofile = height(f2.ids);
num_future_points = 40;

% Initialize outputs
current_road_id = path(1);
localPoints_map = [];

% Extract the global X, Y coordinates for the current path
i = current_road_id;
p_x = [f1.waypoints(f2.waypoints(i,1),1)];
p_y = [f1.waypoints(f2.waypoints(i,1),2)];

for j=2:50
    if f2.waypoints(i,j) ~= 0 % Valid waypoint
        p_x(end+1) = f1.waypoints(f2.waypoints(i,j),1);
        p_y(end+1) = f1.waypoints(f2.waypoints(i,j),2);
    end
end

% Calculate orientation based on the first segment
Yaw_ego = atan2((p_y(2) - p_y(1)), (p_x(2) - p_x(1)));

% Create a Global2Local_class object for converting the entire map
g2l_map = Global2Local_class(length(f1.waypoints));

% Convert the entire map to local coordinates
localPoints_map = g2l_map.convert([f1.waypoints(:,1), f1.waypoints(:,2)], Yaw_ego, start_x, start_y).LocalPoints;
end