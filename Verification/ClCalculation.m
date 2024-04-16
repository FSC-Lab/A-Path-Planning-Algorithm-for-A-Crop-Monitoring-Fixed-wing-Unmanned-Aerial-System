function [C_L] = ClCalculation(V, R, para)

C_L = sqrt(para.W^2/V^4 + para.m^2/R^2)/(0.5*para.rho*para.S);