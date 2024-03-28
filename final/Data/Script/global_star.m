clear all; close all; clc;

%% Load waypoint and roadprofile data
id_waypoint = 284;
f1 = load('D:\final\Data\Data\waypoints_data.mat');
n_waypoint = height(f1.ids);

id_roadprofile = 13;
f2 = load('D:\final\Data\Data\roadprofiles_data.mat');
n_roadprofile = height(f2.ids);

%% Create map using waypoint and roadprofile data
map = [];
for i = 1 : n_roadprofile
    indices = f2.waypoints(i,:);
    indices = indices(indices ~= 0);
    x = f1.waypoints(indices,1);
    y = f1.waypoints(indices,2);
    map = [map; [x, y]];
end

%% Set start and goal points
start = map(1,:);
goal = map(end,:);

%% A* algorithm
show_animation = true;

% Node structure
Node = struct('parent', {}, 'position', {}, 'f', {}, 'g', {}, 'h', {});

% Call the main function
main(show_animation, map, start, goal);

%% Functions

% Get action set
function action_set = get_action()
    % dx, dy, cost
    action_set = [0, -1, 1; 0, 1, 1; -1, 0, 1; 1, 0, 1; ...
                  1, -1, sqrt(2); 1, 1, sqrt(2); -1, 1, sqrt(2); -1, -1, sqrt(2)];
end

% Check collision
function col = collision_check(map, node)
    min_dist = 1; % Minimum distance threshold
    col = false;
    for i = 1:size(map, 1)
        if norm(node - map(i,:)) < min_dist
            col = true;
            break;
        end
    end
end

% Calculate heuristic
function dist = heuristic(cur_node, goal_node)
    dist = norm(cur_node.position - goal_node.position);
end

% A* algorithm implementation
function opt_path = a_star(start, goal, map, weight_heuristic, show_animation)
    start_node = struct('parent', [], 'position', start, 'f', 0, 'g', 0, 'h', 0);
    goal_node = struct('parent', [], 'position', goal, 'f', 0, 'g', 0, 'h', 0);
    
    open_list = start_node;
    closed_list = [];
    
    while ~isempty(open_list)
        % Find node with lowest cost
        [~, cur_index] = min([open_list.f]);
        cur_node = open_list(cur_index);
        
        % If goal reached, return optimal path
        if isequal(cur_node.position, goal_node.position)
            opt_path = [];
            node = cur_node;
            while ~isempty(node.parent)
                opt_path = [node.position; opt_path];
                node = node.parent;
            end
            opt_path = [node.position; opt_path];
            return
        end
        
        % Move current node from open to closed list
        open_list(cur_index) = [];
        closed_list = [closed_list, cur_node];
        
        % Generate child nodes
        action_set = get_action();
        for i = 1:size(action_set, 1)
            action = action_set(i, :);
            child_position = cur_node.position + action(1:2);
            
            % Check if child node is collision-free
            if collision_check(map, child_position)
                continue
            end
            
            % Create child node
            child_node = struct('parent', cur_node, 'position', child_position, 'f', 0, 'g', 0, 'h', 0);
            
            % Check if child node is already in closed list
            if any(arrayfun(@(x) isequal(x.position, child_node.position), closed_list))
                continue
            end
            
            % Calculate cost and heuristic for child node
            child_node.g = cur_node.g + action(3);
            child_node.h = heuristic(child_node, goal_node);
            child_node.f = child_node.g + weight_heuristic * child_node.h;
            
            % Check if child node is already in open list
            idx = find(arrayfun(@(x) isequal(x.position, child_node.position), open_list), 1);
            
            if ~isempty(idx)
                if child_node.f < open_list(idx).f
                    open_list(idx).parent = child_node.parent;
                    open_list(idx).f = child_node.f;
                end
            else
                open_list = [open_list, child_node];
            end
        end
        
        % Show animation
        if show_animation
            plot(cur_node.position(1), cur_node.position(2), 'yo')
            drawnow;
        end
    end
end

% Main function
function main(show_animation, map, start, goal)
    if show_animation
        figure('Position', [100, 100, 800, 800])
        plot(map(:,1), map(:,2), 'k.', 'MarkerSize', 10);
        hold on
        plot(start(1), start(2), 'bs', 'MarkerSize', 6)
        text(start(1), start(2)+0.5, 'start', 'FontSize', 12)
        plot(goal(1), goal(2), 'rs', 'MarkerSize', 7)
        text(goal(1), goal(2)+0.5, 'goal', 'FontSize', 12)
        grid on
        axis equal
        xlabel('X [m]'), ylabel('Y [m]')
        title('A* algorithm', 'FontSize', 20)
    end

    opt_path = a_star(start, goal, map, 10.0, show_animation);
    fprintf('Optimal path found!\n')

    if show_animation
        plot(opt_path(:,1), opt_path(:,2), 'm.-')
    end
end