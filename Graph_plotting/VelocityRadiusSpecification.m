function[] = VelocityRadiusSpecification(optimizedPathEndCoordinates, para)
[V_optimal, R_optimal] = ListOfSpeedsAndRadius(optimizedPathEndCoordinates, para);

figure(2)
x=1:size(optimizedPathEndCoordinates, 1)-1;

y1=R_optimal(x);
plot(x, y1)
xlabel('Turn')
ylabel('Radius (m)')
title("Optimal Turning Radius in Each Turn")

figure(3)
y2=V_optimal(x);
plot(x, y2)
xlabel('Turn')
ylabel('V_t_u_r_n (m/s)')
title("Optimal Turning Velocity in Each Turn")