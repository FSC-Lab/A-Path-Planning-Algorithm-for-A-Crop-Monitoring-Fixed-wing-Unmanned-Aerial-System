function [E_optimal, V_optimal, R_optimal, type] = Energy_Velocity_Radius_Analysis(Path_1, Path_2, para)

EVR_matrix = zeros(3,3);

Path_1 = reshape(Path_1, [1, 2]);
Path_2 = reshape(Path_2, [1, 2]);

[EVR_matrix(1,1), EVR_matrix(1,2), EVR_matrix(1,3)] = TurningPathEnergyOptimization(Path_1, Path_2, para);
if Path_1(2) == Path_2(2)
    EVR_matrix(2,:) = [inf inf inf];
else
    [EVR_matrix(2,1), EVR_matrix(2,2), EVR_matrix(2,3)] = LongTurnPathEnergyOptimization(Path_1, Path_2, para);
end
[EVR_matrix(3,1), EVR_matrix(3,2), EVR_matrix(3,3)] = GoAroundPathEnergyOptimization(Path_1, Path_2, para);

% Verify that Energy > 0, n < n_max and Cl < Cl_max
for i=1:3
    if EVR_matrix(i,1) < 0 || n_calculator(EVR_matrix(i,2), EVR_matrix(i,3), para) > para.n_max || ClCalculation(EVR_matrix(i,2), EVR_matrix(i,3), para) > para.Cl_max
        EVR_matrix(i,:)=[inf inf inf];
    end
end


[~, i] = min(EVR_matrix(:, 1));
E_optimal = EVR_matrix(i,1);
V_optimal = EVR_matrix(i,2);
R_optimal = EVR_matrix(i,3);
type = i;

%{
Distances = abs(Path_1-Path_2);
D_12 = sqrt(Distances(1)^2 + Distances(2)^2);

if Distances(1) >= 2*para.R_min
    energy = @(x)(EnergyTurn(x, pi, para) + EnergyStraight(para.Ts_optimal, sqrt((Distances(1)-2*x)^2 + Distances(2)^2)));
    R_optimal = fminbnd(energy, para.R_min, 1000);
else
    if D_12 < 2*para.R_min     
        energy = @(x)(EnergyTurn(x, pi+2*acos(Distances(1)/(2*x)), para) + EnergyStraight(para.Ts_optimal, abs(2*x*sin(acos(Distances(1)/(2*x)))-Distances(2))));
        R_optimal = fminbnd(energy, para.R_min, 1000);
    else  
        a = atan(Distances(1) / Distances(2));
        b = @(x)(abs(acos(x/(0.5*D_12))));
        energy = @(x)(EnergyTurn(x, pi+(pi/2 - a - b(x)), para) + EnergyStraight(para.Ts_optimal, abs(2*x*tan(b(x)))));
        R_optimal = fminbnd(energy, para.R_min, 0.5*D_12);
    end
end
velocity = @(x)(Vturn(x, para));

E_optimal = energy(R_optimal);
V_optimal = velocity(R_optimal);

%}