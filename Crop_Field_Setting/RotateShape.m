function [rotated] = RotateShape(shapeCoordinates, theta)

l = size(shapeCoordinates, 1);
rotated = zeros(l, 2);
rotationMatrix = [ cos(theta)  sin(theta);
                  -sin(theta)  cos(theta)];

for i=1:l
    rotated(i, :) = shapeCoordinates(i, :) * rotationMatrix;
end