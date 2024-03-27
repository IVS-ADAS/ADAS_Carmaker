clf;
clc;
left_first_line_x = left_first_line_point_x.Data(:);
left_first_line_y = left_first_line_point_y.Data(:);
right_first_line_x = right_first_line_point_x.Data(:);
right_first_line_y = right_first_line_point_y.Data(:);
left_second_line_x = left_second_line_point_x.Data(:);
left_second_line_y = left_second_line_point_y.Data(:);
right_second_line_x = right_second_line_point_x.Data(:);
right_second_line_y = right_second_line_point_y.Data(:);
left_third_line_x = left_third_line_point_x.Data(:);
left_third_line_y = left_third_line_point_y.Data(:);
right_third_line_x = right_third_line_point_x.Data(:);
right_third_line_y = right_third_line_point_y.Data(:);
left_fourth_line_x = left_fourth_line_point_x.Data(:);
left_fourth_line_y = left_fourth_line_point_y.Data(:);
right_fourth_line_x = right_fourth_line_point_x.Data(:);
right_fourth_line_y = right_fourth_line_point_y.Data(:);
left_fifth_line_x = left_fifth_line_point_x.Data(:);
left_fifth_line_y = left_fifth_line_point_y.Data(:);
right_fifth_line_x = right_fifth_line_point_x.Data(:);
right_fifth_line_y = right_fifth_line_point_y.Data(:);
% hold on;
% plot(left_first_line_x,left_first_line_y,"o");
% plot(right_first_line_x,right_first_line_y,"o");
% plot(left_second_line_x,left_second_line_y,"o");
% plot(right_second_line_x,right_second_line_y,"o");
% plot(left_third_line_x,left_third_line_y,"o");
% plot(right_third_line_x,right_third_line_y,"o");
% plot(left_fourth_line_x,left_fourth_line_y,"o");
% plot(right_fourth_line_x,right_fourth_line_y,"o");
% plot(left_fifth_line_x,left_fifth_line_y,"o");
% plot(right_fifth_line_x,right_fifth_line_y,"o");
% axis equal;

global_map_temp = [left_first_line_x left_first_line_y;left_second_line_x left_second_line_y;left_third_line_x left_third_line_y;left_fourth_line_x left_fourth_line_y;left_fifth_line_x left_fifth_line_y;right_first_line_x right_first_line_y;right_second_line_x right_second_line_y;right_third_line_x right_third_line_y;right_fourth_line_x right_fourth_line_y;right_fifth_line_x right_fifth_line_y];
global_map = [];

for i=1:length(global_map_temp(:,1))
    add_point = true;
    for j=1:size(global_map,1)
        if sqrt((global_map_temp(i,1)-global_map(j,1))^2 + (global_map_temp(i,2)-global_map(j,2))^2) < 3
            add_point = false;
            break;
        end
    end
    if add_point
        global_map = [global_map; global_map_temp(i,:)];
    end
end

plot(global_map(:,1),global_map(:,2),'g.');
axis equal;
hold on;
