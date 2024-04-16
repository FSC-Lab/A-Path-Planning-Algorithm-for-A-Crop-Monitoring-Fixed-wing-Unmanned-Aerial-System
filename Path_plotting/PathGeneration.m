function [path, straightWaypoints, turn] = PathGeneration(Coordinates_o, para, pointDensity)

path = [];
straightWaypoints = zeros(size(Coordinates_o, 1),2,2);
turn.shortTurn.Waypoints = zeros(size(Coordinates_o, 1)-1,4,2);
turn.shortTurn.Direction = zeros(size(Coordinates_o, 1)-1,3);
turn.longTurn.Waypoints = zeros(size(Coordinates_o, 1)-1,4,2);
turn.longTurn.Direction = zeros(size(Coordinates_o, 1)-1,3);
turn.goAroundTurn.Waypoints = zeros(size(Coordinates_o, 1)-1,5,2);
turn.goAroundTurn.Direction = zeros(size(Coordinates_o, 1)-1,4);

d = 1;
for i = 1:size(Coordinates_o, 1)    
    length = sqrt((Coordinates_o(i,1,1) - Coordinates_o(i,2,1))^2 + (Coordinates_o(i,1,2) - Coordinates_o(i,2,2))^2);
    straightPath = StraightPathGeneration(Coordinates_o(i, d/-2+1.5,:), d*pi/2, length, pointDensity);
    path = [path; straightPath];
    straightWaypoints(i,:,:) = [straightPath(1,:); straightPath(size(straightPath,1),:)];
    if i == size(Coordinates_o, 1)
        break
    end
    
    [~, ~, R_optimal, type] = Energy_Velocity_Radius_Analysis(Coordinates_o(i,d/2+1.5,:), Coordinates_o(i+1,d/2+1.5,:), para);
    if type == 1
        [turnPath, turn.shortTurn.Waypoints(i,:,:), turn.shortTurn.Direction(i,:)] = TurningPathGeneration(Coordinates_o(i,d/2+1.5,:), Coordinates_o(i+1,d/2+1.5,:), R_optimal, d, pointDensity);
        path = [path; turnPath];
    elseif type == 2
        [turnPath, turn.longTurn.Waypoints(i,:,:), turn.longTurn.Direction(i,:)] = LongTurnPathGeneration(Coordinates_o(i,d/2+1.5,:), Coordinates_o(i+1,d/2+1.5,:), R_optimal, d, pointDensity);
        path = [path; turnPath];
    else
        [turnPath, turn.goAroundTurn.Waypoints(i,:,:), turn.goAroundTurn.Direction(i,:)] = GoAroundPathGeneration(Coordinates_o(i,d/2+1.5,:), Coordinates_o(i+1,d/2+1.5,:), R_optimal, d, pointDensity);
        path = [path; turnPath];
    end
    d = d * -1;
    
end