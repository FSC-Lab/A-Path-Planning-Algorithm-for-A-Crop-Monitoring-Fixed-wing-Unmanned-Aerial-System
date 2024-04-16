function [curvePath] = CurvePathGeneration(startingPoint, startingAngle, radius, endAngle, pointDensity)

points = round(pointDensity*radius*abs(endAngle-startingAngle));
n = linspace(startingAngle, endAngle, points);
curvePath = zeros(points, 2);
for i = 1:points
    curvePath(i, 1) = startingPoint(1) + radius*cos(n(i)) - radius*cos(startingAngle);
    curvePath(i, 2) = startingPoint(2) + radius*sin(n(i)) - radius*sin(startingAngle);
end

if points == 0
    curvePath = startingPoint;
    return
end