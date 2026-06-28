classdef monster < entity
    properties
        Money_rwd
        XP_rwd

        HP % heath points
        AD % atack damage
        AP % ability power
        PR % physical resistance
        MR % magical resistance
    end
    methods
        function obj = monster(name, startX, startY)
            obj = obj@entity(name, startX, startY);
        end
    end
end
