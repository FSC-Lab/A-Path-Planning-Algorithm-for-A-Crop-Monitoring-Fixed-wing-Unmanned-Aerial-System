function [] = ContourPlotting(Path_1, Path_2, para)

[E_optimal, V_optimal, R_optimal, type] = Energy_Velocity_Radius_Analysis(Path_1, Path_2, para);
Distances = abs(Path_1-Path_2);
D_12 = sqrt(Distances(1)^2 + Distances(2)^2);

if type == 1
    Velocity_1 = linspace(10,25,1000);
    Radius_1 = linspace(10, Distances(1)/2, 1000);
    shortTurn = zeros(1000);
    loadconstraint = zeros(1000);
    liftconstraint = zeros(1000);

    for i = 1:1000
        for j = 1:1000
            shortTurn(i,j) = (0.5*para.rho*Velocity_1(i)^2*para.S*(para.Cd_not + para.K*(para.W^2/Velocity_1(i)^4+para.m^2/Radius_1(j)^2)/(0.25*para.rho^2*para.S^2))*Radius_1(j)*pi + ...
                     para.Ts_optimal*sqrt((Distances(1)-2*Radius_1(j))^2 + Distances(2)^2));
            loadconstraint(i,j) = sqrt((Velocity_1(i)^2/(Radius_1(j)*para.g))^2+1);
            liftconstraint(i,j) = 2*para.W/(para.rho*para.S*Velocity_1(i)^2)*sqrt((Velocity_1(i)^2/(Radius_1(j)*para.g))^2+1);
        end
    end

    figure(5)
    contour(Velocity_1, Radius_1, shortTurn', 'ShowText','on', "LabelFormat","%0.1f J", "LabelSpacing", 288)
    hold on
    [~, h_n] = contourf(Velocity_1, Radius_1, loadconstraint', [para.n_max para.n_max], "--r");
    h_n.FaceAlpha = 0.05;
    hold on
    [~, h_cl] = contourf(Velocity_1, Radius_1, liftconstraint', [para.Cl_max para.Cl_max], "--m");
    h_cl.FaceAlpha = 0.05;
    hold on
    plot(V_optimal, R_optimal, "MarkerSize",15, "Marker", "x", "LineWidth", 2)
    text(V_optimal + 0.5, R_optimal, append('\leftarrow E_{1}^* =  ', int2str(round(E_optimal)), ' J'))
    grid on
    xlabel("Velocity (m/s)")
    ylabel("Radius (m)")
    title(["Contour Plot of Energy Consumption for Type 1 Turns"; "with n and C_L constraints"])
end

if type == 2
    angle_1 = atan(Distances(1) / Distances(2));
    angle_2 = @(y)(abs(acos(y/(0.5*D_12))));
    Velocity_2 = linspace(8,36,1000);
    Radius_2 = linspace(Distances(1)/2, D_12/2, 1000);
    longTurn = zeros(1000);
    loadconstraint = zeros(1000);
    liftconstraint = zeros(1000);
    for i = 1:1000
        for j = 1:1000
            longTurn(i,j) = 0.5*para.rho*Velocity_2(i)^2*para.S*(para.Cd_not + para.K*(para.W^2/Velocity_2(i)^4+para.m^2/Radius_2(j)^2)/(0.25*para.rho^2*para.S^2))*Radius_2(j)*(pi+2*(pi/2-angle_1-angle_2(Radius_2(j)))) + ...
                para.Ts_optimal*abs(2*Radius_2(j)*tan(angle_2(Radius_2(j))));
            loadconstraint(i,j) = sqrt((Velocity_2(i)^2/(Radius_2(j)*para.g))^2+1);
            liftconstraint(i,j) = 2*para.W/(para.rho*para.S*Velocity_2(i)^2)*sqrt((Velocity_2(i)^2/(Radius_2(j)*para.g))^2+1);
        end
    end    
    figure(6)
    contour(Velocity_2, Radius_2, longTurn', 'ShowText','on', "LabelFormat","%0.1f J", "LabelSpacing", 200)
    hold on
    [~, h_n] = contourf(Velocity_2, Radius_2, loadconstraint', [para.n_max para.n_max], "--r");
    h_n.FaceAlpha = 0.05;
    hold on
    [~, h_cl] = contourf(Velocity_2, Radius_2, liftconstraint', [para.Cl_max para.Cl_max], "--m");
    h_cl.FaceAlpha = 0.05;
    hold on
    plot(V_optimal, R_optimal, "MarkerSize",15, "Marker", "x", "LineWidth", 2)
    text(V_optimal + 0.5, R_optimal, append('\leftarrow E_{2}^* =  ', int2str(round(E_optimal)), ' J'))
    grid on
    xlabel("Velocity (m/s)")
    ylabel("Radius (m)")
    title(["Contour Plot of Energy Consumption for Type 2 Turns"; "with n and C_L constraints"])
end

if type == 3
    Velocity_3 = linspace(5,25,1000);
    Radius_3 = linspace(D_12/2, 40, 1000);
    goAround = zeros(1000);
    loadconstraint = zeros(1000);
    liftconstraint = zeros(1000);
    for i = 1:1000
        for j = 1:1000
            goAround(i,j) = 0.5*para.rho*Velocity_3(i)^2*para.S*(para.Cd_not + para.K*(para.W^2/Velocity_3(i)^4+para.m^2/Radius_3(j)^2)/(0.25*para.rho^2*para.S^2))*Radius_3(j)*(pi+2*acos(Distances(1)/(2*Radius_3(j)))) + ...
               para.Ts_optimal*abs(2*Radius_3(j)*sin(acos(Distances(1)/(2*Radius_3(j))))-Distances(2));
            loadconstraint(i,j) = sqrt((Velocity_3(i)^2/(Radius_3(j)*para.g))^2+1);
            liftconstraint(i,j) = 2*para.W/(para.rho*para.S*Velocity_3(i)^2)*sqrt((Velocity_3(i)^2/(Radius_3(j)*para.g))^2+1);
        end
    end    
    figure(7)
    contour(Velocity_3, Radius_3, goAround', 'ShowText','on', "LabelFormat","%0.1f J", "LabelSpacing", 200)
    hold on
    [~, h_n] = contourf(Velocity_3, Radius_3, loadconstraint', [para.n_max para.n_max], "--r");
    h_n.FaceAlpha = 0.05;
    hold on
    [~, h_cl] = contourf(Velocity_3, Radius_3, liftconstraint', [para.Cl_max para.Cl_max], "--m");
    h_cl.FaceAlpha = 0.05;
    hold on
    plot(V_optimal, R_optimal, "MarkerSize",15, "Marker", "x", "LineWidth", 2)
    text(V_optimal + 0.5, R_optimal, append('\leftarrow E_{3}^* =  ', int2str(round(E_optimal)), ' J'))
    grid on
    xlabel("Velocity (m/s)")
    ylabel("Radius (m)")
    title(["Contour Plot of Energy Consumption for Type 3 Turns"; "with n and C_L constraints"])
end
