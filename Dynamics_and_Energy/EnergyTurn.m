function [energy] = EnergyTurn(x, theta, para)

energy = 0.5*para.rho*para.S*(para.Cd_not+para.K*(para.W^2/x(2)^2+para.m^2/(x(2)/x(1))^2)/(0.25*para.rho^2*para.S^2))*x(2)^2/x(1)*theta;
