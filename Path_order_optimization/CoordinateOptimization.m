function [optimizedCoordinates] = CoordinateOptimization(pathEndCoordinates, optimizedPathOrder)

optimizedCoordinates = zeros(size(pathEndCoordinates));

for i = 1:size(optimizedPathOrder, 2)
    optimizedCoordinates(i,:,:) = pathEndCoordinates(optimizedPathOrder(i),:,:);
end