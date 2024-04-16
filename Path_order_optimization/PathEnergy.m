function [Energy] = PathEnergy(nearEnd, farEnd, order)

Energy = 0;
state = 1;
for i = 1 : (length(order)-1)
    if state == 1
        Energy = Energy + farEnd(order(i), order(i+1));
    else
        Energy = Energy + nearEnd(order(i), order(i+1));
    end
    state = state * -1 ;
end
if Energy == inf
    Energy = 10^6;
end