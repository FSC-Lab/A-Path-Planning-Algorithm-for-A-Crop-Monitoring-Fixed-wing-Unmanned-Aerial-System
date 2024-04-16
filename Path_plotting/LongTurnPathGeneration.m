function [path, turnWaypoints, turning_dir] = LongTurnPathGeneration(startingPoint, endPoint, radius, direction, pointDensity)

startingPoint = reshape(startingPoint, [1, 2]);
endPoint = reshape(endPoint, [1, 2]);
s=0;
Distances = abs(endPoint - startingPoint);
D_12 = sqrt(Distances(1)^2 + Distances(2)^2);
a = atan(Distances(1) / Distances(2));
b = real(acos(radius/(0.5*D_12)));
theta = pi/2 - a - b;

if atan((endPoint(2)-startingPoint(2)) / (endPoint(1)-startingPoint(1))) < 0
    turning_dir = [1,0,-1];
    if endPoint(2) > startingPoint(2)
        temp = endPoint;
        endPoint = startingPoint;
        startingPoint = temp;
        s = 1;
    end
    curvePath_1 = CurvePathGeneration(startingPoint, pi, radius, -theta, pointDensity);
    straightPath_1 = StraightPathGeneration(curvePath_1(end, :), -pi/2-theta, abs(2*radius*tan(b)), pointDensity);
    curvePath_2 = CurvePathGeneration(straightPath_1(end, :), pi-theta, radius, pi, pointDensity);
    path = [curvePath_1; straightPath_1; curvePath_2];
    turnWaypoints = [startingPoint; curvePath_1(end, :); straightPath_1(end, :); endPoint];
    if s == 1 
        path = flip(path);
        turnWaypoints = flip(turnWaypoints);
    end

else
    turning_dir = [1,0,-1];
    if endPoint(2) > startingPoint(2)
        temp = endPoint;
        endPoint = startingPoint;
        startingPoint = temp;
        s = 1;
    end
    curvePath_1 = CurvePathGeneration(startingPoint, 0, radius, pi+theta, pointDensity);
    straightPath_1 = StraightPathGeneration(curvePath_1(end, :), -pi/2+theta, abs(2*radius*tan(b)), pointDensity);
    curvePath_2 = CurvePathGeneration(straightPath_1(end, :), theta, radius, 0, pointDensity);
    path = [curvePath_1; straightPath_1; curvePath_2];
    turnWaypoints = [startingPoint; curvePath_1(end, :); straightPath_1(end, :); endPoint];
    if s == 1 
        path = flip(path);
        turnWaypoints = flip(turnWaypoints);
    end
end


if direction == -1
    centroid = (startingPoint + endPoint)/2;
    path = path - centroid;
    path = path * -1;
    path = path + centroid;
    path = flip(path);
    turnWaypoints = turnWaypoints - centroid;
    turnWaypoints = turnWaypoints * -1;
    turnWaypoints = turnWaypoints + centroid;
    turnWaypoints = flip(turnWaypoints);
end