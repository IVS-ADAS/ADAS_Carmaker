% A* algorithm implementation
function opt_path = A_star_fcn(start, goal, map, weight_heuristic, show_animation)
    start_node = struct('parent', [], 'position', start, 'f', 0, 'g', 0, 'h', 0);
    goal_node = struct('parent', [], 'position', goal, 'f', 0, 'g', 0, 'h', 0);
    
    open_list = start_node;
    closed_list = [];
    opt_path = [];
    
    while ~isempty(open_list)
%         Find node with lowest cost
        [~, cur_index] = min([open_list.f]);
        cur_node = open_list(cur_index);
        
        x = cur_node.position(1);
        y = cur_node.position(2);
        a = goal_node.position(1);
        b = goal_node.position(2);
%         If goal reached, return optimal path

        distance = sqrt((x - a)^2 + (y - b)^2);
    
        % 거리가 5 이하인지 확인
        if distance <= 0.5
            node = cur_node;
            while ~isempty(node.parent)
                opt_path = [node.position; opt_path];
                node = node.parent;
            end
            opt_path = [node.position; opt_path];
            return
        end
%         if isequal(cur_node.position, goal_node.position)
%             node = cur_node;
%             while ~isempty(node.parent)
%                 opt_path = [node.position; opt_path];
%                 node = node.parent;
%             end
%             opt_path = [node.position; opt_path];
%             return
%         end
        
%         Move current node from open to closed list
        open_list(cur_index) = [];
        closed_list = [closed_list, cur_node];
        
%         Generate child nodes
        action_set = get_action();
        for i = 1:size(action_set, 1)
            action = action_set(i, :);
            child_position = cur_node.position + action(1:2);
            
%             Check if child node is collision-free
            if collision_check(map, child_position)
                continue
            end
            
%             Create child node
            child_node = struct('parent', cur_node, 'position', child_position, 'f', 0, 'g', 0, 'h', 0);
            
%             Check if child node is already in closed list
            if any(arrayfun(@(x) isequal(x.position, child_node.position), closed_list))
                continue
            end
            
%             Calculate cost and heuristic for child node
            child_node.g = cur_node.g + action(3);
            child_node.h = heuristic(child_node, goal_node);
            child_node.f = child_node.g + weight_heuristic * child_node.h;
            
%             Check if child node is already in open list
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
        
%         Show animation
        if show_animation
            plot(cur_node.position(1), cur_node.position(2), 'yo')
            hold on;
            drawnow;
        end
    end
end
% Get action set
function action_set = get_action()
%     dx, dy, cost
    action_set = [0, -1, 1; 0, 1, 1; -1, 0, 1; 1, 0, 1; ...
                  1, -1, sqrt(2); 1, 1, sqrt(2); -1, 1, sqrt(2); -1, -1, sqrt(2)];
end

% Check collision
function col = collision_check(map, node)
    min_dist = 3; % Minimum distance threshold
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