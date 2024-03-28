clear all; close all; clc;

%% Localization plotter

id_waypoint = 254; % The specific number will need verification
f1 = load('final\Data\Data\waypoints_data.mat');
n_waypoint = height(f1.ids); % Determine the number of IDs in the waypoints data

% Index identifying a specific road profile
id_roadprofile = 13;
f2 = load('final\Data\Data\roadprofiles_data.mat');
n_roadprofile = height(f2.ids); % Determine the number of IDs in the road profile data
disp(n_roadprofile)

% plot
figure(1);
plot(f1.waypoints(:,1), f1.waypoints(:,2), 'k.'); % Plot all waypoints as black dots
hold on
plot(f1.waypoints(id_waypoint,1), f1.waypoints(id_waypoint,2), 'ko'); % Highlight specific waypoint

% Loop through each road profile
for i = 1 : n_roadprofile
    x = [f1.waypoints(f2.waypoints(i,1),1)];
    y = [f1.waypoints(f2.waypoints(i,1),2)];
    for j=2:50
         % If waypoint index is not 0 (meaning it's a valid waypoint)
        if f2.waypoints(i,j) ~= 0 
            x(end+1) = f1.waypoints(f2.waypoints(i,j),1);
            y(end+1) = f1.waypoints(f2.waypoints(i,j),2);
        end
    end
    % Color the current road profile red if selected, otherwise blue
    i_set1 = linspace(1,10,10);
    i_set2 = linspace(11,20,10);
    i_set3 = linspace(21,30,10);
    i_set4 = linspace(31,33,3);
    if ismember(i,i_set1)
        plot(x, y, 'r-','LineWidth',2 );
    elseif ismember(i,i_set2)
        plot(x, y, 'g-','LineWidth',2 );
    elseif ismember(i,i_set3)
        plot(x, y,'b-');
    elseif ismember(i,i_set4)
        plot(x, y,'y-');
    end
    xlim([-200 150]);
    ylim([-200 50]);

    % Label the start point of each road profile with its ID instead of n_roadprofile
    text(x(1), y(1), ['ID: ', num2str(i)], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
hold off;
grid on;
