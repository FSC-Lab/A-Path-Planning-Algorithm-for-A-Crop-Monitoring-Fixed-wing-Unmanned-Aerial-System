%% Add files to path
addpath('Crop_Field_Setting\')
addpath('Dynamics_and_Energy\')
addpath('Graph_plotting\')
addpath('Path_order_optimization\')
addpath('Path_plotting\')
addpath('Verification\')

%% Define Parameters
para_def;

%% Sweep Direction Optimization
[finalShapeCoordinates, ~] = SweepDirectionOptimization(para.shapeCoordinates);
pathEndCoordinates = PathEndSetting(finalShapeCoordinates, para);
finalShapeCoordinates = [finalShapeCoordinates; finalShapeCoordinates(1,:)];

%% Crop Field Generation
close all
figure(1)
plot(finalShapeCoordinates(:,2), finalShapeCoordinates(:,1), 'Color','g', 'LineWidth', 1.25)
hold on
axis equal
xlabel('x-coordinates (m)')
ylabel('y-coordinates (m)')
title('Optimal Flight Path')
grid on

%% Flight Path Optimization
[nearEnd, farEnd] = EnergyMatrixGeneration(pathEndCoordinates, para);
[bruteOrder, bruteTurningEnergy, tBrute, optimizedPathOrder, optimizedTurningEnergy, tGenetic] = PathOrderOptimization(nearEnd, farEnd);
optimizedPathEndCoordinates = CoordinateOptimization(pathEndCoordinates, optimizedPathOrder);

%% Comparision for computation time needed to optimize the path order
%tCompare = [tBrute tGenetic];

%% Contour Plotting of Energy Consumption
%{
ContourPlotting([0 0], [50 10], para) % Type 1 U-turns
ContourPlotting([0 0], [10 60], para) % Type 2 U-turns
ContourPlotting([0 0], [10 10], para) % Type 3 U-turns
%}
%% Flight Path Generation
pointDensity = 3;
[path, straightWaypoints, pathInfo.turnInfo] = PathGeneration(optimizedPathEndCoordinates, para, pointDensity);

figure(1)
x = path(:, 2); y = path(:, 1);
axis([min(x)-5, max(x)+5, min(finalShapeCoordinates(:,1))-5, max(finalShapeCoordinates(:,1))+5])

% Static plot
plot(x, y, "b")

% Moving plot
%{
h = plot(x(1), y(1), "b");
for i = 1:length(x)
    set(h, 'XData', x(1:i))
    set(h, 'YData', y(1:i))
    pause(0.0001)
end
%}
text(x(1)-5,y(1), 'S', 'FontWeight','bold', 'FontSize', 12)
text(x(length(x))-5,y(length(x)), 'F', 'FontWeight','bold', 'FontSize', 12)

%% Flight Path Specifications
% Plots for velocity, radius and type of each turn
[V_optimal, R_optimal, Type_optimal] = ListOfSpeedsAndRadius(optimizedPathEndCoordinates, para);
VelocityRadiusSpecification(optimizedPathEndCoordinates, para)
TypeSpecification(Type_optimal)

% Optimized total energy
optimizedStraightLineEnergy = StraightlineEnergyOptimization(optimizedPathEndCoordinates, para);
E_optimal = optimizedTurningEnergy + optimizedStraightLineEnergy;

% Total distance of whole flight path
[turningDistance, straightDistance] = DistanceCalculation(optimizedPathEndCoordinates, para);
totalDistance = turningDistance + straightDistance;
turningPathSpec = [V_optimal, R_optimal, Type_optimal];

% Flying altitude
alt = para.h_max;

% For simulator test
pathInfo.Vs_optimal = para.Vs_optimal;
pathInfo.turnInfo.V_optimal = V_optimal;
pathInfo.turnInfo.R_optimal = R_optimal;
pathInfo.turnInfo.Type_optimal = Type_optimal;
pathInfo.turnInfo.shortTurn.Waypoints = flip(pathInfo.turnInfo.shortTurn.Waypoints,3);
pathInfo.turnInfo.longTurn.Waypoints = flip(pathInfo.turnInfo.longTurn.Waypoints,3);
pathInfo.turnInfo.goAroundTurn.Waypoints = flip(pathInfo.turnInfo.goAroundTurn.Waypoints,3);
pathInfo.straightWaypoints = flip(straightWaypoints,3);
pathInfo.h_max = para.h_max;
pathInfo.finalShapeCoordinates = finalShapeCoordinates;
pathInfo.path = path;

%% Photo Covereage of the Mission
h=figure(13);
h.Renderer = 'Painters';
plot(finalShapeCoordinates(:,2), finalShapeCoordinates(:,1), 'Color','g', 'LineWidth', 1.25)
hold on
axis equal
xlabel('x-coordinates (m)')
ylabel('y-coordinates (m)')
title('Total coverage of the mission')
grid on
axis([min(finalShapeCoordinates(:,2))-5-para.Lx/2, max(finalShapeCoordinates(:,2))+5+para.Lx/2, min(finalShapeCoordinates(:,1))-5, max(finalShapeCoordinates(:,1))+5])
for i = 1:para.no_of_flight_paths
    plot([pathEndCoordinates(i,1,2), pathEndCoordinates(i,2,2)],[pathEndCoordinates(i,1,1), pathEndCoordinates(i,2,1)], 'Color','b')
    plot(pathEndCoordinates(i,1,2), pathEndCoordinates(i,1,1), 'Marker','.', 'Color','b', 'MarkerSize',12)
    plot(pathEndCoordinates(i,2,2), pathEndCoordinates(i,2,1), 'Marker','.', 'Color','b', 'MarkerSize',12)
    area = patch([pathEndCoordinates(i,1,2)-para.Lx/2 pathEndCoordinates(i,1,2)-para.Lx/2 pathEndCoordinates(i,2,2)+para.Lx/2 pathEndCoordinates(i,2,2)+para.Lx/2], [pathEndCoordinates(i,1,1)-para.Ly/2 pathEndCoordinates(i,1,1)+para.Ly/2 pathEndCoordinates(i,2,1)+para.Ly/2 pathEndCoordinates(i,2,1)-para.Ly/2], 'b');
    set(area, 'EdgeColor',[0 .447 .741], 'FaceColor',[0.929 .694 .125], 'FaceAlpha',.3)
end
%% Flight path plot in 2D and 3D
figure(14)
plot(finalShapeCoordinates(:,2), finalShapeCoordinates(:,1), 'Color','g', 'LineWidth', 1.25)
hold on
axis equal
xlabel('x-coordinates (m)')
ylabel('y-coordinates (m)')
title('Optimal Flight Path in Top View')
grid on
x = path(:, 2); y = path(:, 1);
axis([min(x)-5, max(x)+5, min(finalShapeCoordinates(:,1))-5, max(finalShapeCoordinates(:,1))+5])
plot(x, y, "b")
text(x(1)-7,y(1)+2, 'S', 'FontWeight','bold', 'FontSize', 12)
text(x(length(x))-7,y(length(x)), 'F', 'FontWeight','bold', 'FontSize', 12)

figure(15)
finalShapeHeight = ones(length(finalShapeCoordinates)) * para.h_max;
z = ones(length(x)) * para.h_max;
plot3(finalShapeCoordinates(:,2), finalShapeCoordinates(:,1), finalShapeHeight, 'Color','g', 'LineWidth', 1.25)
hold on
axis equal
xlabel('x-coordinates (m)')
ylabel('y-coordinates (m)')
zlabel('z-coordinates (m)')
title('Optimal Flight Path in Isometric View')
grid on
axis([min(x)-5, max(x)+5, min(finalShapeCoordinates(:,1))-5, max(finalShapeCoordinates(:,1))+5, para.h_max-15, para.h_max+15])
plot3(x, y, z, "b")