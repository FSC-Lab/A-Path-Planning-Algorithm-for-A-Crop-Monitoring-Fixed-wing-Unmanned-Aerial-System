function [] = GraphGeneration(Path_1, Path_2, R_optimal, para)

Distances = abs(Path_1-Path_2);
D_12 = sqrt(Distances(1)^2 + Distances(2)^2);
N = 100;

if Distances(1) >= 2*para.R_min
    energy = @(x)(EnergyTurn(x, pi, para) + EnergyStraight(para.Ts_optimal, sqrt((Distances(1)-2*x)^2 + Distances(2)^2)));
    x_1 = linspace(0, 30, N);
else
    if D_12 < 2*para.R_min     
        energy = @(x)(EnergyTurn(x, pi+2*acos(Distances(1)/(2*x)), para) + EnergyStraight(para.Ts_optimal, abs(2*x*sin(acos(Distances(1)/(2*x)))-Distances(2))));
        x_1 = linspace(0, 80, N);
    else  
        a = atan(Distances(1) / Distances(2));
        b = @(x)(acos(x/(0.5*D_12)));
        energy = @(x)(EnergyTurn(x, pi+(pi/2 - a - b(x)), para) + EnergyStraight(para.Ts_optimal, abs(2*x*tan(b(x)))));
        x_1 = linspace(0, D_12/2, N);
    end
end

energy_1 = zeros(size(x_1));

for i = 1 : N
    energy_1(i) = energy(x_1(i));
end

figure
plot(x_1, energy_1)
xlabel('Radius (m)')
ylabel('Energy (J)')
xline(para.R_min, '--', 'R_m_i_n')
xline(R_optimal, '--', 'R_o_p_t_i_m_a_l', 'Color', 'g')
