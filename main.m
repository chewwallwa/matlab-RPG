% =========================================================================
% A RPG game in MATLAB
% =========================================================================
clear; clc; close all;

hero = player('thierry');
gameMap = world();
isRunning = true;

% 2. GAME LOOP
while isRunning
    clc;

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
        otherwise
            fprintf(2,'Invalid command!');
            pause(1.2); 
    end
end