classdef world
    properties
        matrixGrid
        figHandle
        axHandle
        backgroundImage
        playerHandle % NOVO: Guarda o "ID" apenas do plot do jogador
    end
    methods
        function obj = world()
            obj.matrixGrid = ones(10, 10); % mapa base
            obj.matrixGrid(7,7) = 2; % cidade principal
            obj.matrixGrid(9,2) = 3; % boss
            
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
                [bossY, bossX] = find(obj.matrixGrid == 3);                
                plot(obj.axHandle, townX, townY, 'sk', 'MarkerFaceColor', 'c', 'MarkerSize', 12);
                plot(obj.axHandle, bossX, bossY, 'xk', 'LineWidth', 2, 'MarkerSize', 12, 'Color', 'y');
                
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
        
        function printContext(obj, heroX, heroY)
            terrainVal = obj.matrixGrid(heroY, heroX);
            
            if terrainVal == 3
                fprintf('\nALERT: You stepped into a monster lair!\n');
            elseif terrainVal == 2
                fprintf('\nWelcome to the Central Town. It is safe here.\n');
            else
                fprintf('\nYou are exploring the wild. Pos: (%d, %d)\n', heroX, heroY);
            end
        end

    end
end