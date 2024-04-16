function [optimizedStriaghtlineEnergy] = StraightlineEnergyOptimization(optimizedPathEndCoordinates, para)

optimizedStriaghtlineEnergy = 0;
for i = 1:size(optimizedPathEndCoordinates, 1)
    dist = abs(optimizedPathEndCoordinates(i, 1, 2) - optimizedPathEndCoordinates(i, 2, 2));
    optimizedStriaghtlineEnergy = optimizedStriaghtlineEnergy + EnergyStraight(para.Ts_optimal, dist);
end