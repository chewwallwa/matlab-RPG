classdef player < entity
    properties
        Inventory
        Money
        XP
        LVL
    end
    methods
        function obj = player(name)
            obj = obj@entity(name, 7,9);

            obj.stats.maxHP = 100;
            obj.stats.maxMana = 50;
            obj.stats.AD = 10;
            obj.stats.AP = 0;
            obj.stats.PR = 5;
            obj.stats.MR = 2;
            obj.stats.CDR = 0;
            
            obj.HP = obj.stats.maxHP;
            obj.mana = obj.stats.maxMana;
            
            obj.LVL = 1;
            obj.XP = 1;
            obj.Money = 0;

            obj.Inventory = {}; 
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

        function printHUD(obj)
            fprintf('%s | Lvl: %d (exp: %d) | HP: %d/%d | Mana: %d/%d | Gold: %d \n', ...
                    obj.name, obj.LVL, obj.XP, obj.HP, obj.stats.maxHP, obj.mana, obj.stats.maxMana, obj.Money);
        end

        function printInventory(~)
            fprintf('inventoryprint');
        end
    end
end

