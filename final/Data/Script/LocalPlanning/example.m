clear;close;clc;

% Define path and start coordinates
path = 1:10;
start_x = 59.0003214677011;
start_y = 24.2296986157458;

% Call path_animation function
[current_road_id, localPoints_map] = Global2Local_path(path, start_x, start_y);

% Plot the entire map in local coordinates
figure(1);
plot(localPoints_map(:,1), localPoints_map(:,2), 'k.'); % Plot all waypoints as black dots
hold on;

xlim([-100 100]);
ylim([-100 100]);
xlabel('X (m)');
ylabel('Y (m)');
title(['Current Road ID: ' num2str(current_road_id)]);
grid on;