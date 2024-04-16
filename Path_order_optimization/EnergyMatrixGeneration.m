function [nearEndEnergyMatrix, farEndEnergyMatrix] = EnergyMatrixGeneration(pathEndCoordinates, para)

s = size(pathEndCoordinates, 1);
nearEndEnergyMatrix = zeros(s, s);
farEndEnergyMatrix = zeros(s, s);
for i = 1:s
    for j = i:s
        if i ~= j
            [E, ~, ~, ~] = Energy_Velocity_Radius_Analysis(pathEndCoordinates(i,1,:), pathEndCoordinates(j,1,:), para);
            nearEndEnergyMatrix(i, j) = E;
            [E, ~, ~, ~] = Energy_Velocity_Radius_Analysis(pathEndCoordinates(i,2,:), pathEndCoordinates(j,2,:), para);
            farEndEnergyMatrix(i, j) = E;
        end
    end
end

for i = 1:s
    for j = 1:i
        nearEndEnergyMatrix(i, j) = nearEndEnergyMatrix(j, i);
        farEndEnergyMatrix(i, j) = farEndEnergyMatrix(j, i);
    end
end