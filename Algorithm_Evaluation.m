close all
%% Algorithm comparison (computation time)
scaledFactor = [0.24 0.33 0.42 0.52 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 1.98];
noStraightPaths = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
tBrute_expected_before = [0.00013 0.00026 0.00078 0.00312 0.0156];
tBrute = [0.0156 0.0625 0.5469 5.4688 62.0948 743.9688]; 
tBrute_expected_after = [743.9688 8916 115908 1622712 24340680 389450880 6620664960 119171969300 2264267416000 45285348330000];
energyBrute = [734.0444 1463.2 2011.9 2447.0 2602.6 2811.8 2957.8 3102.0 3458.4 3836.4];
tGA = [8.5781 8.6562 14.1406 16.5 16.1056 20.75 14.9375 24.4844 20.75 20.3125 22.5781 21.0156 18.375 24.625 26.7656 29 28.8594 31.75 28.6406];
energyGA = [734.0444 1463.2 2011.9 2447.0 2602.6 2811.8 2957.8 3102.0 3458.4 3836.4 4361.4 4779.4 5260 5725.2 6217.8 6647.8 7065.2 7692.2 8196.8];

figure(1)
semilogy(noStraightPaths(5:10), tBrute, 'LineWidth', 1.5,'Color', [0 0.4470 0.7410])
hold on
semilogy(noStraightPaths, tGA, 'LineWidth', 1.5)
semilogy(noStraightPaths(10:19), tBrute_expected_after, 'LineWidth', 1.5, 'LineStyle', "--", 'Color', [0 0.4470 0.7410])
semilogy(noStraightPaths(1:5), tBrute_expected_before, 'LineWidth', 1.5, 'Color', [0 0.4470 0.7410])

grid on
xlabel('Number of straight paths', 'FontSize',13)
ylabel('Computation time (s)', 'FontSize',13)

legend('Brute force', 'Genetic Algorithm', 'Predicted curve for brute force', 'FontSize',11)

%% Algorithm comparison (Energy consumption for proposed flight path)
figure(2)
plot(noStraightPaths(1:10), energyBrute, 'LineWidth', 1.75)
hold on
grid on
plot(noStraightPaths, energyGA, 'LineWidth', 2,'LineStyle', "--")
xlabel('Number of straight paths', 'FontSize',13)
ylabel('Optimal turning energy required (J)', 'FontSize',13)
legend('Brute force', 'Genetic Algorithm', 'FontSize',11)
axis([0 20 0 8500])

%% Overlap comparison
oy = [40 50 60 70 80];
energy = [4776.9 5639.1 7138.4 9324.9 13203];
figure(3)
plot(oy, energy, 'LineWidth',1.5)
xlabel('Percentage overlap in the sweep direction (%)', 'FontSize',13)
ylabel('Total energy consumption in the mission (J)', 'FontSize',13)
grid on