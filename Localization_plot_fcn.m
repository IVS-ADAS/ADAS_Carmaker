%% Localization plotter

id_waypoint = 254; % 숫자는 확인 필요
f1 = load('D:\CM_Projects\final\src_cm4sl\Data\waypoints_data.mat');
n_waypoint = height(f1.ids); % waypoints 데이터에서 id 개수 확인

% 특정 도로 프로파일을 식별하는 인덱스
id_roadprofile = 10; 
f2 = load('D:\CM_Projects\final\src_cm4sl\Data\roadprofiles_data.mat');
n_roadprofile = height(f2.ids); % 도로 프로파일 데이터에서 id 개수 확인

% plot
figure(1);
plot(f1.waypoints(:,1), f1.waypoints(:,2), 'k.'); % 모든 waypoints를 검은 점으로
hold on
plot(f1.waypoints(id_waypoint,1), f1.waypoints(id_waypoint,2), 'ko');

% each road profile loop
for i = 1 : n_roadprofile
    x = [f1.waypoints(f2.waypoints(i,1),1)];
    y = [f1.waypoints(f2.waypoints(i,1),2)];
    for j=2:20
         % 만약 waypoints 인덱스가 0이 아니면 (유효한 waypoint라면)
        if f2.waypoints(i,j) ~= 0 
            x(end+1) = f1.waypoints(f2.waypoints(i,j),1);
            y(end+1) = f1.waypoints(f2.waypoints(i,j),2);
        end
    end
    % 현재 도로 프로파일이 선택된 프로파일이면 빨간색, 아니면 파란색
    if i == id_roadprofile
        plot(x, y, 'r-','LineWidth',2 );
    else
        plot(x, y,'b-');
    end
end
hold off;
grid on;