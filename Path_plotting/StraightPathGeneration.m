function [straightPath] = StraightPathGeneration(startingPoint, startingAngle, length, pointDensity)

points = round(pointDensity * length);
n = linspace(0, length, points); 
straightPath = zeros(points, 2);
for i = 1:points
    straightPath(i,1) = startingPoint(1) + cos(startingAngle)*n(i);  
    straightPath(i,2) = startingPoint(2) + sin(startingAngle)*n(i);
end

if points == 0
    straightPath = startingPoint;
    return
end