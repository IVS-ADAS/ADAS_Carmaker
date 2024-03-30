
function steering_angle = stanley_control_fcn(x, y, psi, path_x, path_y, k)
    % 최소 거리와 해당 인덱스 찾기
    [min_dist, idx] = min(sqrt((path_x - x).^2 + (path_y - y).^2));
    if idx == length(path_x), idx = idx - 1; end % 인덱스 보정
    % 경로와 차량의 헤딩 각도 차이
    path_angle = atan2(path_y(idx+1) - path_y(idx), path_x(idx+1) - path_x(idx));
    heading_error = angle_wrap(path_angle - psi);
    % 크로스 트랙 오차
    cross_track_error = min_dist * sign(sin(path_angle - atan2(y - path_y(idx), x - path_x(idx))));
    % 스탠리 조향 제어 법칙
    steering_angle = heading_error + atan2(k * cross_track_error, 1);
end

function angle = angle_wrap(angle)
    % 각도를 -pi ~ pi 범위로 조정
    while angle > pi, angle = angle - 2*pi; end
    while angle < -pi, angle = angle + 2*pi; end
end
