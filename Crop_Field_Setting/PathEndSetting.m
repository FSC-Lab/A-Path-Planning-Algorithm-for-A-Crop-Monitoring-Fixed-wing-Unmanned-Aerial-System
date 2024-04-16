function[pathEndCoordinates] = PathEndSetting(finalShapeCoordinates, para)

pathEndCoordinates = zeros(para.no_of_flight_paths, 2, 2);
pathSeparation = para.dp_optimal;

% x-coordinate setting
pathEndCoordinates(1, :, 1) = para.Ly/2;
for i = 2:para.no_of_flight_paths
    pathEndCoordinates(i, :, 1) = pathEndCoordinates(i-1, :, 1) + pathSeparation;
end

% y-coordinate setting
for i = 1:para.no_of_flight_paths
    for j = 2:length(finalShapeCoordinates)
        if finalShapeCoordinates(j,1) >= pathEndCoordinates(i,2,1)
            m = (finalShapeCoordinates(j,2)-finalShapeCoordinates(j-1,2))/(finalShapeCoordinates(j,1)-finalShapeCoordinates(j-1,1));
            pathEndCoordinates(i,2,2) = m*(pathEndCoordinates(i,2,1)-finalShapeCoordinates(j,1)) + finalShapeCoordinates(j,2);
            break
        end
    end
end
finalShapeCoordinates = [finalShapeCoordinates; finalShapeCoordinates(1,:)];
for i = 1:para.no_of_flight_paths
    for k = length(finalShapeCoordinates)-1:-1:1
        if finalShapeCoordinates(k,1) >= pathEndCoordinates(i,1,1)
            m = (finalShapeCoordinates(k,2)-finalShapeCoordinates(k+1,2))/(finalShapeCoordinates(k,1)-finalShapeCoordinates(k+1,1));
            pathEndCoordinates(i,1,2) = m*(pathEndCoordinates(i,1,1)-finalShapeCoordinates(k,1)) + finalShapeCoordinates(k,2);
            break
        end
    end
end    

