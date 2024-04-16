function [Energy, Velocity, Radius] = LongTurnPathEnergyOptimization(Path_1, Path_2, para)

Distances = abs(Path_1-Path_2);
D_12 = sqrt(Distances(1)^2 + Distances(2)^2);
angle_1 = atan(Distances(1) / Distances(2));
angle_2 = @(y)(abs(acos(y/(0.5*D_12))));
turnEnergy = @(x)(EnergyTurn(x, pi+2*(pi/2 - angle_1 - angle_2(x(2)/x(1))), para)+ ...
                  EnergyStraight(para.Ts_optimal, abs(2*x(2)/x(1)*tan(angle_2(x(2)/x(1))))));

x0=[5, 100];
A = [Distances(1)/2+10^-4 -1; -D_12/2, 1];
b = [0 0];
Aeq=[];
beq=[];
lb=[10^-6 10^-6];
ub=[inf inf];
nonlcons = @(x)(nonlcon(x, para)); 
[x, Energy] = fmincon(turnEnergy, x0, A, b, Aeq, beq, lb, ub, nonlcons);
Velocity=sqrt(x(2));
Radius=x(2)/x(1);