function [Energy, Velocity, Radius] = TurningPathEnergyOptimization(Path_1, Path_2, para)

Distances = abs(Path_1-Path_2);
turnEnergy = @(x)(EnergyTurn(x, pi, para)+EnergyStraight(para.Ts_optimal, sqrt((Distances(1)-2*(x(2)/x(1)))^2 + Distances(2)^2)));

x0=[5, 100];
A = [-Distances(1)/2, 1];
b = 0;
Aeq=[];
beq=[];
lb=[10^-6 10^-6];
ub=[inf inf];
nonlcons = @(x)(nonlcon(x, para)); 
[x, Energy] = fmincon(turnEnergy, x0, A, b, Aeq, beq, lb, ub, nonlcons);
Velocity=sqrt(x(2));
Radius=x(2)/x(1);