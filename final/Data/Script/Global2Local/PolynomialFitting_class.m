classdef PolynomialFitting_class
    properties
        nd; % Degree of the polynomial
        np; % Number of points
        A;  % Design matrix
        b;  % Vector of y-values
        coeff; % Coefficients of the polynomial
    end
    
    methods
        function obj = PolynomialFitting_class(num_degree, num_points)
            obj.nd = num_degree;
            obj.np = num_points;
            obj.A = zeros(obj.np, obj.nd+1);
            obj.b = zeros(obj.np, 1);
            obj.coeff = zeros(num_degree+1, 1);
        end
        
        function obj = fit(obj, points)
            for i = 1:obj.np
                for j = 1:obj.nd+1
                    obj.A(i, j) = points(i, 1)^(obj.nd-j+1);
                end
                obj.b(i, 1) = points(i, 2);
            end
            obj.coeff = (obj.A' * obj.A) \ (obj.A' * obj.b);
        end
    end
end