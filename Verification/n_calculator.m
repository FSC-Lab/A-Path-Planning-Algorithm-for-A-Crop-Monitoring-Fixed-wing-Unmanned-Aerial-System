function [n] = n_calculator(V, R, para)

n = sqrt((V^2/(R*para.g))^2 + 1);