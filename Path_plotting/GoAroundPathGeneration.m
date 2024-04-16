function [path, turnWaypoints, turning_dir] = GoAroundPathGeneration(startingPoint, endPoint, radius, direction, pointDensity)

startingPoint = reshape(startingPoint, [1, 2]);
endPoint = reshape(endPoint, [1, 2]);

alpha = acos(abs(startingPoint(1)-endPoint(1)) / (2*radius));
s = 0;
% Assuming R*sin(alpha) - abs(y2-y1) > 0

if atan((endPoint(2)-startingPoint(2)) / (endPoint(1)-startingPoint(1))) <= 0
    turning_dir = [0,1,-1,0];
    if endPoint(2) > startingPoint(2) || (endPoint(2) == startingPoint(2) && endPoint(1) < startingPoint(1))
        temp = endPoint;
        endPoint = startingPoint;
        startingPoint = temp;
        s = 1;
    end
    straightPath_1 = StraightPathGeneration(startingPoint, pi/2, 2*radius*sin(alpha)-abs(endPoint(2)-startingPoint(2)), pointDensity);
    curvePath_1 = CurvePathGeneration(straightPath_1(end, :), pi, radius, -1*alpha, pointDensity);
    curvePath_2 = CurvePathGeneration(curvePath_1(end, :), pi-alpha, radius, pi, pointDensity);
    straightPath_2 = StraightPathGeneration(curvePath_2(end, :), -pi/2, -2*radius*sin(alpha)+abs(endPoint(2)-startingPoint(2)), pointDensity);
    path = [straightPath_1; curvePath_1; curvePath_2; straightPath_2];
    turnWaypoints = [startingPoint; straightPath_1(end, :); curvePath_1(end, :); curvePath_2(end, :); endPoint];
    if s == 1 
        path = flip(path);
        turnWaypoints = flip(turnWaypoints);
    end

else
    turning_dir = [0,-1,1,0];
    if endPoint(2) > startingPoint(2)
        temp = endPoint;
        endPoint = startingPoint;
        startingPoint = temp;
        s = 1;
    end
    straightPath_1 = StraightPathGeneration(startingPoint, pi/2, 2*radius*sin(alpha)-abs(endPoint(2)-startingPoint(2)), pointDensity);
    curvePath_1 = CurvePathGeneration(straightPath_1(end, :), 0, radius, pi+alpha, pointDensity);
    curvePath_2 = CurvePathGeneration(curvePath_1(end, :), alpha, radius, 0, pointDensity);
    straightPath_2 = StraightPathGeneration(curvePath_2(end, :), -pi/2, -2*radius*sin(alpha)+abs(endPoint(2)-startingPoint(2)), pointDensity);
    path = [straightPath_1; curvePath_1; curvePath_2; straightPath_2];
    turnWaypoints = [startingPoint; straightPath_1(end, :); curvePath_1(end, :); curvePath_2(end, :); endPoint];
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