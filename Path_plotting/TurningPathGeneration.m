function [path, turnWaypoints, turning_dir] = TurningPathGeneration(startingPoint, endPoint, radius, direction, pointDensity)

startingPoint = reshape(startingPoint, [1, 2]);
endPoint = reshape(endPoint, [1, 2]);
s = 0;
alpha = abs(atan(abs(endPoint(2)-startingPoint(2))/(abs(endPoint(1)-startingPoint(1))-2*radius)));
length = sqrt((abs(endPoint(1)-startingPoint(1))-2*radius)^2 + abs(endPoint(2)-startingPoint(2))^2);

if atan((endPoint(2)-startingPoint(2))/(endPoint(1)-startingPoint(1))) <= 0
    turning_dir = [1,0,1];
    if endPoint(2) > startingPoint(2) || (endPoint(2) == startingPoint(2) && endPoint(1) < startingPoint(1))
        temp = endPoint;
        endPoint = startingPoint;
        startingPoint = temp;
        s = 1;
    end
    curvePath_1 = CurvePathGeneration(startingPoint, pi, radius, pi/2-alpha, pointDensity);
    straightPath = StraightPathGeneration(curvePath_1(end, :), -alpha, length, pointDensity);
    curvePath_2 = CurvePathGeneration(straightPath(end, :), pi/2-alpha, radius, 0, pointDensity);
    path = [curvePath_1; straightPath; curvePath_2];
    turnWaypoints = [startingPoint; curvePath_1(end, :); straightPath(end, :); endPoint];
    if s==1
        path = flip(path);
        turnWaypoints = flip(turnWaypoints);
        turning_dir = turning_dir * -1;
    end
else
    turning_dir = [-1,0,-1];
    if endPoint(2) >= startingPoint(2)
        temp = endPoint;
        endPoint = startingPoint;
        startingPoint = temp;
        s = 1;
    end
    curvePath_1 = CurvePathGeneration(startingPoint, 0, radius, pi/2+alpha, pointDensity);
    straightPath = StraightPathGeneration(curvePath_1(end, :), pi+alpha, length, pointDensity);
    curvePath_2 = CurvePathGeneration(straightPath(end, :), pi/2+alpha, radius, pi, pointDensity);
    path = [curvePath_1; straightPath; curvePath_2];
    turnWaypoints = [startingPoint; curvePath_1(end, :); straightPath(end, :); endPoint];
    if s==1
        path = flip(path);
        turnWaypoints = flip(turnWaypoints);
        turning_dir = turning_dir * -1;
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
    turning_dir = turning_dir * -1;
end
