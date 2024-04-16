function [finalShapeCoordinates, finalDiameter] = SweepDirectionOptimization(shapeCoordinates)

l = size(shapeCoordinates, 1);
diameter_theta_matrix = zeros(l, 2);

for i = 1:l-1
    theta = atan2((shapeCoordinates(i+1,2)-shapeCoordinates(i,2)), (shapeCoordinates(i+1,1)-shapeCoordinates(i,1)));
    theta = pi/2 - theta;
    rotated = RotateShape(shapeCoordinates, theta);
    diameter = max(rotated(:,1))-rotated(i,1);
    diameter_theta_matrix(i,1) = diameter;
    diameter_theta_matrix(i,2) = theta;
end

theta = atan2((shapeCoordinates(1,2)-shapeCoordinates(l,2)), (shapeCoordinates(1,1)-shapeCoordinates(l,1)));
theta = pi/2 - theta;
rotated = RotateShape(shapeCoordinates, theta);
diameter = max(rotated(:,1))-rotated(l,1);
diameter_theta_matrix(l,1) = diameter;
diameter_theta_matrix(l,2) = theta;


[finalDiameter, edge] = min(diameter_theta_matrix(:, 1));
finalShapeCoordinates = RotateShape(shapeCoordinates, diameter_theta_matrix(edge, 2));
finalShapeCoordinates = circshift(finalShapeCoordinates, [-edge+1 0]);
finalShapeCoordinates(:, 1) = finalShapeCoordinates(:, 1) - finalShapeCoordinates(1, 1);
finalShapeCoordinates(:, 2) = finalShapeCoordinates(:, 2) - finalShapeCoordinates(1, 2);