classdef entity
    properties
        name
        x
        y
    end
methods
        function obj = entity(name, startX, startY)
            obj.name = name;
            obj.x = startX;
            obj.y = startY;
        end
    end
end
