function [Energy, Velocity, Radius] = GoAroundPathEnergyOptimization(Path_1, Path_2, para)

Distances = abs(Path_1-Path_2);
D_12 = sqrt(Distances(1)^2 + Distances(2)^2);
turnEnergy = @(x)(EnergyTurn(x, pi+2*acos(Distances(1)/(2*x(2)/x(1))), para)+ ...
                  EnergyStraight(para.Ts_optimal, abs(2*x(2)/x(1)*sin(acos(Distances(1)/(2*x(2)/x(1))))-Distances(2))));

x0=[100/(Distances(1)/1.8), 100];
A = [D_12/2+10^-6, -1];
b = 0;
Aeq=[];
beq=[];
lb=[10^-6 10^-6];
ub=[inf inf];
nonlcons = @(x)(nonlcon(x, para)); 
[x, Energy] = fmincon(turnEnergy, x0, A, b, Aeq, beq, lb, ub, nonlcons);
Velocity=sqrt(x(2));
Radius=x(2)/x(1);