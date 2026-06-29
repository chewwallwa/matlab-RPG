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
        function [obj, target] = attack(obj, target)
            % roll a 6-sided die for damage variation
            dice = randi(6);

            % compute raw damage based on attack damage (AD)
            rawDamage = round(obj.stats.AD * (1 - (dice/10)), 0);

            % subtract target physical resistance (PR). ensure at least 1 damage
            finalDamage = max(1, rawDamage - target.stats.PR);

            % deduct HP from the target (use the defined property name)
            target.HP = max(0, target.HP - finalDamage);

            fprintf('%s attacked %s for %d damage! (%s HP: %d/%d)\n', ...
                obj.name, target.name, finalDamage, target.name, target.HP, target.stats.maxHP);
        end

        function [obj, target] = startCombat(obj, target)
            fprintf('\n================================================\n');
            fprintf('          BATTLE START: %s vs %s!         \n', obj.name, target.name);
            fprintf('================================================\n');

            % turn-based loop while both are alive
            while obj.HP > 0 && target.HP > 0
                % attack by the initiator
                [obj, target] = obj.attack(target);

                % if target still alive, it retaliates
                if target.HP > 0
                    [target, obj] = target.attack(obj);
                end

                pause(1.2);
            end

            % final outcome
            fprintf('\n================================================\n');
            if obj.HP > 0
                warning('%s is victorious!', obj.name);                
            else
                fprintf(2, '%s was defeated by %s...', obj.name, target.name);                
            end
            fprintf('\n================================================\n');
            pause(4);
            
        end
    end
end
