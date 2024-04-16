function [listOfSpeeds, listOfRadius, listOfTypes] = ListOfSpeedsAndRadius(Coordinates_o, para)

listOfSpeeds = zeros((size(Coordinates_o, 1)-1),1);
listOfRadius = zeros((size(Coordinates_o, 1)-1),1);
listOfTypes = zeros((size(Coordinates_o, 1)-1),1);
d = 1;
for i = 1:size(Coordinates_o, 1)-1
    [~, listOfSpeeds(i), listOfRadius(i), listOfTypes(i)] = Energy_Velocity_Radius_Analysis(Coordinates_o(i,d/2+1.5,:), Coordinates_o(i+1,d/2+1.5,:), para);
    d = d* -1;
end