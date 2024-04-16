function [turningDistance, straightDistance] = DistanceCalculation(optimizedPathEndCoordinates,para)

s=length(optimizedPathEndCoordinates);
d = 1;
turningDistance = 0; straightDistance = 0;
for i = 1:s-1
    straightDistance = straightDistance + abs(optimizedPathEndCoordinates(i,2,2) - optimizedPathEndCoordinates(i,1,2));
    
    Distances = abs(optimizedPathEndCoordinates(i,d/2+1.5,:)-optimizedPathEndCoordinates(i+1,d/2+1.5,:));
    D_12 = sqrt(Distances(1)^2 + Distances(2)^2);
    [~, ~, radius, type] = Energy_Velocity_Radius_Analysis(optimizedPathEndCoordinates(i,d/2+1.5,:), optimizedPathEndCoordinates(i+1,d/2+1.5,:), para);
    if type == 1
        turningDistance = turningDistance + radius*pi + sqrt((Distances(1)-2*(radius))^2 + Distances(2)^2);
    end
    if type == 2
        angle_1 = atan(Distances(1) / Distances(2));
        angle_2 = @(y)(abs(acos(y/(0.5*D_12))));
        turningDistance = turningDistance + radius*(pi+2*(pi/2-angle_1-angle_2(radius))) + abs(2*radius*sin(acos(Distances(1)/(2*radius)))-Distances(2));
    end
    if type == 3
        turningDistance = turningDistance + radius*(pi+2*acos(Distances(1)./(2*radius))) + abs(2*radius*sin(acos(Distances(1)/(2*radius)))-Distances(2));
    end
    d = d * -1;
end
straightDistance = straightDistance + abs(optimizedPathEndCoordinates(s,2,2) - optimizedPathEndCoordinates(s,1,2));