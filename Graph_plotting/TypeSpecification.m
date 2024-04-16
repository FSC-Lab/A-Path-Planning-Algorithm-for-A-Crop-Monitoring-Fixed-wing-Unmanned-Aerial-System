function[] = TypeSpecification(Type_optimal)

x = 1:length(Type_optimal);
figure(4)
y = Type_optimal(x);
plot(x,y)
xlabel("Turn")
ylabel("Type of Turn")
title("Optimal turning type in each turn")
a = axis;
axis([a(1) a(2) 0 4]);
set(gca, 'YTick', 0:4)