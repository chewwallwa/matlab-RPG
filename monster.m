classdef monster < entity
    methods
        function obj = monster(type, startX, startY)
            obj = obj@entity(type, startX, startY);
            
            switch lower(type)
                case 'slime'
                    obj.stats.maxHP = 30;
                    obj.stats.AD = 5;
                    obj.stats.PR = 0;
                case 'goblin'
                    obj.stats.maxHP = 50;
                    obj.stats.AD = 12;
                    obj.stats.PR = 2;
                case 'lula'
                    obj.stats.maxHP = 200;
                    obj.stats.AD = 25;
                    obj.stats.PR = 15;
            end
            obj.HP = obj.stats.maxHP;
        end
    end
end