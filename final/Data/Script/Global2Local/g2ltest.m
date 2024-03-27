clear all;close all;clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Global to Local Conversion Example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numPoints = 5;
globalPoints = [10, 7; 15, 5; 20, 21; 25, 18; 30, 20];

Yaw_ego = pi/4; % 45 degrees in radians
X_ego = 5; % X coordinate of ego vehicle
Y_ego = 5; % Y coordinate of ego vehicle

g2l = Global2Local_class(numPoints);
g2l = g2l.convert(globalPoints, Yaw_ego, X_ego, Y_ego);

% Assuming g2l.LocalPoints is the correct variable where local points are stored after conversion
localPoints = g2l.LocalPoints; % Make sure this matches the property name where converted points are stored

figure(1);
plot(globalPoints(:,1), globalPoints(:,2), 'bo-', 'DisplayName', 'Global Coordinates');
hold on


x = linspace(5,6);
y = pi*(x-5)/4 + 5;
plot(x,y)

plot(localPoints(:,1), localPoints(:,2), 'rs-', 'MarkerFaceColor','r', 'DisplayName','Local Coordinates');


% Adding legend, axis labels, and title
legend('Location','best');
xlabel('X');
ylabel('Y');
title('Comparison of Global and Local Coordinates');
grid on;
axis equal;

figure(2)
plot(localPoints(:,1), localPoints(:,2), 'rs-', 'MarkerFaceColor','r', 'DisplayName','Local Coordinates');

% Adding legend, axis labels, and title
legend('Location','best');
xlabel('X');
ylabel('Y');
title('Comparison of Global and Local Coordinates');
grid on;
axis equal;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% polynomial fitting example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3)

% 5차 다항식 fitting을 위한 클래스 인스턴스 생성
polyFit = PolynomialFitting_class(5, size(localPoints, 1));

% 다항식 fitting
polyFit = polyFit.fit(localPoints);

% 시각화를 위한 다항식 값 계산 클래스 인스턴스 생성
polyVal = PolynomialValue_class(5, 100); % 시각화를 위해 더 많은 점 사용

% x값 범위 설정 (예: 1부터 4까지 0.1간격으로)
xRange = linspace(1, 30, 100)';

% 계산된 다항식 값
polyVal = polyVal.calculate(polyFit.coeff, xRange);

% 시각화

plot(xRange, polyVal.y, 'b-', 'LineWidth', 2); % 다항식 그래프
hold on
plot(localPoints(:,1), localPoints(:,2), 'ro', 'MarkerFaceColor', 'r'); % 원본 데이터 점
xlabel('X');
ylabel('Y');
title('5차 다항식 Fitting');
legend('Fitted Polynomial', 'Original Data', 'Location', 'Best');
grid on;

















