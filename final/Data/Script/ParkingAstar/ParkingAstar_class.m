% start = [10.0, 0.0, pi];
% goal = [10.0, 10.0, 0.0];
start = [3.72, -37.67]; % x=3.72, y = -37.67
goal = [35, -5]; %[29.83, -41.44]; %[30.96, -31.05];
% Searching space : [min_x, max_x, min_y, max_y]
space = [-2.0, 15.0, -2.0, 15.0]; 
% Obstacle : (x, y, radius)
% obstacle_list = [[3, 5, 1];
%                      [3, 6, 1];
%                      [3, 7, 1];
%                      [3, 8, 1];
%                      [3, 9, 1]; 
%                      [3, 10, 1]; 
%                      [4, 5, 1];
%                      [5, 5, 1]; 
%                      [6, 5, 1]; 
%                      [7, 5, 1]; 
%                      [8, 5, 1]; 
%                      [9, 5, 1]; 
%                      [10, 5, 1]; 
%                      [11, 5, 1]; 
%                      [12, 5, 1]; 
%                      [13, 5, 1]; 
%                      [14, 5, 1]; 
%                      [15, 5, 1]]; 
obstacle_list = [[7.3   -28.7];
    [12.8   -6.8];
    [21.3   -6.6];
    [30   -6.5];
    [41.7   -6.3];
    [6.9   -6.9];
    [7   -21.8];
    [18.6   -21.8];
    [24.3   -21.9];
    [36   -21.9];
    [38.8   -21.8];
    [41.8   -21.8];
    [12.6   -28.8];
    [24.3   -28.9];
    [41.6   -28.9];
    [9.9   -44.4];
    [21.4   -44.3];
    [24.5   -44.4];
    [36   -44.4];
    [41.8   -44.5];
    [44.6   -44.4];];

% 새로운 포인트 저장을 위한 리스트
new_obstacle_list = [];

% 각 장애물에 대해 사각형 형태의 새로운 포인트 생성
for i = 1:size(obstacle_list, 1)
    x = obstacle_list(i, 1);
    y = obstacle_list(i, 2);
    
    % 상하좌우 포인트 추가
    new_points = [
        x-1, y; x+1, y; x, y-1; x, y+1;  % 상하좌우
        x-1, y-1; x-1, y+1; x+1, y-1; x+1, y+1;  % 대각선
        x, y-2;  % 추가된 아래쪽 포인트
        
        
        x-1, y-2; x+1, y-2]; % 아래쪽 확장된 포인트
    
    % 새로운 포인트를 리스트에 추가
    new_obstacle_list = [new_obstacle_list; new_points];
end

% 중복 포인트 제거
new_obstacle_list = unique(new_obstacle_list, 'rows');

% 기존 장애물 리스트와 새로운 포인트 합치기
combined_obstacle_list = [obstacle_list; new_obstacle_list];

% obstacle_list = [[3, 5];
%                      [3, 6];
%                      [3, 7];
%                      [3, 8];
%                      [3, 9]; 
%                      [3, 10]; 
%                      [4, 5];
%                      [5, 5]; 
%                      [6, 5]; 
%                      [7, 5]; 
%                      [8, 5]; 
%                      [9, 5]; 
%                      [10, 5]; 
%                      [11, 5]; 
%                      [12, 5]; 
%                      [13, 5]; 
%                      [14, 5]; 
%                      [15, 5]]; 
x = combined_obstacle_list(:, 1); % x 좌표
y = combined_obstacle_list(:, 2); % y 좌표

plot(x, y, 'o'); % 데이터 점 찍기
hold on;
xlabel('X 축'); % x 축 레이블
ylabel('Y 축'); % y 축 레이블
title('데이터 포인트 그래프'); % 그래프 제목
% refpath = hybrid_a_star_fcn(start, goal, space, obstacle_list, 5.0, 2.0, 0.5, 1.1);
% hybrid_a_star_fcn(start, goal, space, obstacle_list, R, Vx, delta_time_step, weight)
% hybrid_a_star_fcn(start, goal, map, weight_heuristic, show_animation, deltaTimeStep, R, Vx)
% opt_path = hybrid_a_star_fcn(start, goal, obstacle_list, 50, true, 5, 1, 2, space);


opt_path = A_star_fcn(start, goal, combined_obstacle_list, 10, true);
disp(opt_path)
plot(opt_path(:,1), opt_path(:,2), 'm.-')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% %% Load waypoint and roadprofile data
% id_waypoint = 284;
% f1 = load('C:\Users\seobokyeong\Downloads\waypoints_data.mat');
% n_waypoint = height(f1.ids);
% 
% id_roadprofile = 13;
% f2 = load('C:\Users\seobokyeong\Downloads\roadprofiles_data.mat');
% n_roadprofile = height(f2.ids);
% 
% %% Create map using waypoint and roadprofile data
% map = [];
% for i = 1 : n_roadprofile
%     indices = f2.waypoints(i,:);
%     indices = indices(indices ~= 0);
%     x = f1.waypoints(indices,1);
%     y = f1.waypoints(indices,2);
%     map = [map; [x, y]];
% end
% 
% start = map(1,:);
% goal = map(end,:);
% 
% opt_path = a_star_fcn(start, goal, map, 10, true);