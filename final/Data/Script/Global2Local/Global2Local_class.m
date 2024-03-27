classdef Global2Local_class
    properties
        n
        GlobalPoints
        LocalPoints
        theta
        rotation_matrix
    end
    
    methods
        function obj = Global2Local_class(num_points)
            obj.n = num_points;
            obj.GlobalPoints = zeros(num_points, 2);
            obj.LocalPoints = zeros(num_points, 2);
        end
        
        function obj = convert(obj, points, Yaw_ego, X_ego, Y_ego)
            obj.GlobalPoints = points;
            obj.theta = -Yaw_ego;
            obj.rotation_matrix = [cos(obj.theta), -sin(obj.theta); sin(obj.theta), cos(obj.theta)];
            for i = 1:obj.n
                point_convert = (obj.GlobalPoints(i,:)-[X_ego, Y_ego])';
                point_convert = obj.rotation_matrix * point_convert;
                obj.LocalPoints(i,:) = point_convert';
            end
        end
    end
end
