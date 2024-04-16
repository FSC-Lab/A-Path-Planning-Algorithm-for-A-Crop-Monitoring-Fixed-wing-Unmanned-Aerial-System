% Define Parameters for Crop Monitoring Mission

%% Photogrammetry
para.focal_length = 0.152;
para.sensor_height = 0.024;
para.sensor_width = 0.036;
para.pixel_length = 4.8e-6;
para.Ix = para.sensor_height/para.pixel_length; 
para.Iy = para.sensor_width/para.pixel_length;
para.GSD = 0.003;
%para.GSD = 0.02; % Simulator_test
para.Ts = 1/30;
para.ox = 0.85;
para.oy = 0.6;
para.Lx = para.Ix*para.GSD;
para.Ly = para.Iy*para.GSD;
para.lx = para.Lx * para.ox;
para.ly = para.Ly * para.oy;

%% Field property

% shape coordinates input format [x_1 y_1; x_2 y_2; ... ; x_M; y_M]
%para.shape = [0 0; 500 0; 625 500; -125 500]; % Simulator_test_normal
%para.shape = [-40 400; 0 180; 280 0; 320 80; 300 300; 160 440]; % Simulator_test_tight
%para.shape = [0 0; 100 0; 100 100; 0 100]; % Square
%para.shape = [0 0; 100 0; 100 150; 0 150]; % Rectangle
%para.shape = [0 0; 100 25; 45 120]; % Triangle
para.shape = [0 0; 72 24; 105 90; 36 120; -36 60]; % Polygon
%para.scaleFactor = 0.75;
%para.shape = [0 0; 72 24; 105 90; 36 120; -36 60]*para.scaleFactor; % Scaled-Polygon
%para.shape = []; % Other shapes

para.shapeCoordinates = flip(para.shape, 2); % in (y_i, x_i)
[~, para.Dy] = SweepDirectionOptimization(para.shapeCoordinates);
para.rho = 1.293;
para.g = 9.81;

%% Path planning
para.dp = para.Ly - para.ly;
para.no_of_flight_paths = ceil((para.Dy-para.ly) / para.dp);
para.dp_optimal = (para.Dy-para.Ly) / (para.no_of_flight_paths-1);

%% Aircraft property
para.W = 30;
para.S = 0.36;
para.Cd_not = 0.03;
para.AR = 4;
para.e = 0.775;
para.K = 1/(pi * para.e * para.AR);
para.Cl_max = 1;
para.T_max = 10;
para.m = para.W/para.g;
para.efficiency = 0.9;

%% Flight constraints
para.safety_factor = 1; % Updated for safety
para.h_max = para.GSD*para.focal_length/para.pixel_length;
para.V_min_straight = (2*para.W/(para.rho*para.S*para.Cl_max))^0.5;
para.V_max_straight = (para.Lx-para.lx)/para.Ts;
para.n_max = 1.5557; % Assume maximum bank angle is 50 degrees
%para.n_max = (para.T_max/para.W)/(2*(para.K*para.Cd_not)^0.5) / para.safety_factor;
%para.V_min_turn = @(x)((para.W^2/(0.25*para.rho^2*para.S^2*para.Cl_max^2-para.m^2/x^2))^0.25);

%% Steady level flight
para.Ts_optimal = 2*para.W*(para.K*para.Cd_not)^0.5;
para.Vs_optimal = sqrt(2*para.W/(para.rho*para.S*sqrt(para.Cd_not/para.K)));
