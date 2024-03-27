classdef PolynomialValue_class
    properties
        nd; % Degree of the polynomial
        np; % Number of points
        x;  % Matrix for x values raised to the power
        y;  % Matrix for y values (calculated polynomial values)
        points; % Matrix to store x and y pairs
    end
    
    methods
        function obj = PolynomialValue_class(num_degree, num_points)
            obj.nd = num_degree;
            obj.np = num_points;
            obj.x = zeros(1, obj.nd+1);
            obj.y = zeros(num_points, 1);
            obj.points = zeros(obj.np, 2);
        end
        
        function obj = calculate(obj, coeff, x)
            for i = 1:obj.np
                for j = 1:obj.nd+1
                    obj.x(1, j) = x(i)^(obj.nd-j+1);
                end
                obj.y(i, 1) = obj.x * coeff;
                obj.points(i, 1) = x(i);
                obj.points(i, 2) = obj.y(i, 1);
            end
        end
    end
end
