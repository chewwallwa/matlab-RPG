% =========================================================================
% A RPG game in MATLAB
% =========================================================================
clear; clc; close all;

% 1. INITIALIZATION
hero = player("Hero", 7,9);
boss = monster("Main boss", 10, 10);

gameMap = world();
isRunning = true;

% 2. GAME LOOP
while isRunning
    clc; % pra nao gerar log
    
    disp("================================================");
    disp("                  MATLAB RPG                    ");
    disp("================================================");
    
    gameMap.drawMap(hero.x, hero.y);
    gameMap.printContext(hero.x, hero.y, boss.name);
    
    fprintf('\n\n');
    command = input('Give a Command: [w] Up | [s] Down | [a] Left | [d] Right | [q] Quit: ', 's');
    
    % Executa a ação baseada no input
    switch lower(command)
        case 'w'
            hero = hero.move(0, 1);
        case 's'
            hero = hero.move(0, -1);
        case 'a'
            hero = hero.move(-1, 0);
        case 'd'
            hero = hero.move(1, 0);
        case 'q'
            isRunning = false;
            disp('Closing the game...');
            close all;
        otherwise
            disp('Invalid command!');
            pause(1.2);
    end

end