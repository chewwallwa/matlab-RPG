classdef player < entity
    properties
        Inventory
        Money
        XP
LVL

        HP % heath points
        AD % atack damage
        AP % ability power
        PR % physical resistance
        MR % magical resistance
        CDR % cooldown reduction
    end
    methods
        function obj = player(name, startX, startY)
            obj = obj@entity(name, startX, startY);
        end
        
        function obj = move(obj, dx, dy)
            newX = obj.x + dx;
            newY = obj.y + dy;
            
            if newX >= 1 && newX <= 10 && newY >= 1 && newY <= 10
                obj.x = newX;
                obj.y = newY;
            else
                disp('Ouch! You hit the invisible wall at the edge of the world!');
            end
        end
end
methods (static)
function printHUD(obj)
fprintf('LVL: %d(%d exp) | HP: %d | Money: %d', LVL, XP, HP, Money);
function printInventory(obj)
fprintf('inventoryprint');
end
    end
end

