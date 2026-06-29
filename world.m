classdef world
    properties
        matrixGrid
        figHandle
        axHandle
        backgroundImage
        playerHandle % "ID" apenas do plot do jogador
        enemyList % array de monstros instanciados
    end
    methods
        function obj = world()
            obj.matrixGrid = ones(10, 10); % mapa base
            obj.matrixGrid(7,7) = 2; % cidade principal            
            
            obj.enemyList = {
                monster('Slime', 4, 6);
                monster('Goblin', 8, 3);
                monster('Lula', 9, 9)
            };
            
            obj.figHandle = figure(1); 
            set(obj.figHandle, 'Name', 'World Map', 'NumberTitle', 'off');
            obj.axHandle = axes(obj.figHandle);
        end
        
        function drawMap(obj, heroX, heroY)

            if isempty(obj.playerHandle) % RENDERIZAÇÃO INICIAL

                obj.backgroundImage = imread('worldmap.jpg');
                image(obj.axHandle, [1 10], [1 10], obj.backgroundImage);

                hold(obj.axHandle, 'on');
                
                % Plota lugares no mapa
                [townY, townX] = find(obj.matrixGrid == 2);
                plot(obj.axHandle, townX, townY, 'sk', 'MarkerFaceColor', 'c', 'MarkerSize', 12);

                % Plot os monstros
                for i = 1:length(obj.enemyList)
                    enemy = obj.enemyList{i};
                    plot(obj.axHandle, enemy.x, enemy.y, 'xk', 'LineWidth', 2, 'MarkerSize', 12, 'Color', 'r');
                end
                
                % Plota o Player
                obj.playerHandle = plot(obj.axHandle, heroX, heroY, 'ko', 'MarkerFaceColor', 'w', 'MarkerSize', 8);
                
                hold(obj.axHandle, 'off');
                
                set(obj.axHandle, 'YDir', 'normal'); 
                xlim(obj.axHandle, [0.5 10.5]);
                ylim(obj.axHandle, [0.5 10.5]);                
                grid(obj.axHandle, 'on');
                xticks(obj.axHandle, 1:10); 
                yticks(obj.axHandle, 1:10);
                
            else  % Move apenas o player                  

                set(obj.playerHandle, 'XData', heroX, 'YData', heroY);

            end
            
            drawnow;
        end
        
        function encounterIdx = printContext(obj, heroX, heroY)
            % returns the index of the encountered enemy in obj.enemyList
            % or 0 when there's no encounter
            encounterIdx = 0;
            terrainVal = obj.matrixGrid(heroY, heroX);
            
            if terrainVal == 2
                warning('\nWelcome to the Central Town. It is safe here.\n');
                return; % no encounter in town
            end

            for i = 1:length(obj.enemyList)
                enemy = obj.enemyList{i};
                if heroX == enemy.x && heroY == enemy.y
                    fprintf(2, '\nALERT: You bumped into a %s (HP: %d)! Pos: (%d, %d)\n', enemy.name, enemy.HP, heroX, heroY);
                    encounterIdx = i;
                    return;
                end
            end

            fprintf('\nYou are exploring the wild. Pos: (%d, %d)\n', heroX, heroY);
        end

    end
end