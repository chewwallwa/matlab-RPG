classdef entity
    properties
        name
        x
        y
        
        stats
        HP % actual hp
        mana % actual mana
    end
    methods
        function obj = entity(name, startX, startY)
            obj.name = name;
            obj.x = startX;
            obj.y = startY;

            % Inicializando a struct de stats com zeros/valores padrão.
            % As classes filhas (player, monster) vão alterar isso depois.
            obj.stats.maxHP = 1;
            obj.stats.maxMana = 0;
            obj.stats.AD = 0;
            obj.stats.AP = 0;
            obj.stats.PR = 0;
            obj.stats.MR = 0;
            obj.stats.CDR = 0;
            
            % O estado atual começa sempre cheio
            obj.HP = obj.stats.maxHP;
            obj.mana = obj.stats.maxMana;
        end
    end
end
