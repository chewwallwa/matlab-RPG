% =========================================================================
% A RPG game in MATLAB
% =========================================================================
clear; clc; close all;
warning('off', 'backtrace');

hero = player('thierry');
gameMap = world();
isRunning = true;

% initial game state
gameState = 'Exploration';
currentEnemy = [];
currentEnemyIdx = 0;

% 2. GAME LOOP
while isRunning

    clc;
    switch gameState
        case 'Exploration'

            disp("================================================");
            disp("                  MATLAB RPG                    ");
            disp("================================================");
            
            hero.printHUD();
            
            gameMap.drawMap(hero.x, hero.y);
            
            % Nota: tiramos o boss.name daqui, o mundo gerencia isso agora
            gameMap.printContext(hero.x, hero.y);
            
            fprintf('\n\n');
            command = input('[w] Up | [s] Down | [a] Left | [d] Right | [i] Inventory | [q] Quit >> ', 's');
            
            switch lower(command)
                case 'w', hero = hero.move(0, 1);
                case 's', hero = hero.move(0, -1);
                case 'a', hero = hero.move(-1, 0);
                case 'd', hero = hero.move(1, 0);
                case 'i', hero.printInventory(); pause(3); 
                case 'q'
                    isRunning = false;
                    fprintf(2,'Closing the game...');
                    pause(1);
                otherwise
                    fprintf(2,'Invalid command!');
                    pause(1.2); 
            end

            % check for enemy encounter after movement/command
            encounterIdx = gameMap.printContext(hero.x, hero.y);
            if encounterIdx > 0
                currentEnemyIdx = encounterIdx;
                currentEnemy = gameMap.enemyList{encounterIdx};
                gameState = 'Combat';
                gameMap.drawMap(hero.x, hero.y);
            end

            % [botar opcao de lutar ou fugir, e se fugir, voltar pro estado de exploracao]

        case 'Combat'
            
            % run the (automatic for now) combat
            [hero, currentEnemy] = hero.startCombat(currentEnemy);

            % [remove enemy from world (remove mob, drop items, respawn)]

            % check player death [change this to ressurect at town]
            if hero.HP <= 0
                fprintf(2, 'You have been defeated. Game over.\n');
                isRunning = false;
                continue;
            end

            % reset combat state and return to exploration
            currentEnemy = [];
            currentEnemyIdx = 0;
            gameState = 'Exploration';

    end

end