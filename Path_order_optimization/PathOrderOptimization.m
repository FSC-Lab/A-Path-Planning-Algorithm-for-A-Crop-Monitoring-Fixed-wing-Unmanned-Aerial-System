function [bruteOrder, bruteTurningEnergy, tBrute, optimizedPathOrder, optimizedTurningEnergy, tGenetic] = PathOrderOptimization(nearEnd, farEnd)


tBruteStart = cputime;
bruteOrder = zeros(1,size(nearEnd, 1));
bruteTurningEnergy = 0;

if size(nearEnd, 1) <= 11
    pathOrder = 1:length(nearEnd);
    listOfPathOrder = perms(pathOrder);
    s = size(listOfPathOrder, 1);
    listOfEnergy = zeros(s, 1);
    for i = 1:size(listOfPathOrder, 1)
        listOfEnergy(i) = PathEnergy(nearEnd, farEnd, listOfPathOrder(i,:));
    end
    
    [bruteTurningEnergy, index] = min(listOfEnergy);
    bruteOrder = listOfPathOrder(index,:);
end
tBrute = cputime - tBruteStart;

%{
tBruteStart = cputime;
bruteOrder = 1:size(nearEnd, 1);
bruteTurningEnergy = PathEnergy(nearEnd, farEnd, bruteOrder);
n = size(nearEnd,1);
for k=1:factorial(n)
    order = GetEnumPerm(k, n);
    energy = PathEnergy(nearEnd, farEnd, order);
    if energy < bruteTurningEnergy
        bruteOrder = order;
        bruteTurningEnergy = energy;
    end
end
tBrute = cputime - tBruteStart;
%}

tGeneticStart = cputime;
optimizedPathOrder = GeneticAlgorithm(nearEnd, farEnd);
optimizedTurningEnergy = PathEnergy(nearEnd, farEnd, optimizedPathOrder);
tGenetic = cputime - tGeneticStart;