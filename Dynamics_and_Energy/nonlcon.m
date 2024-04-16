function [c, ceq] = nonlcon(x, para)

c = [1/para.g^2*x(1)^2+1-para.n_max^2, 1/para.g^2*x(1)^2+1-x(2)^2*(0.5*para.Cl_max*para.rho*para.S/para.W)^2];
%c = [sqrt(x(1)^2/para.g^2 + 1)-para.n_max, 2*para.W/para.rho/para.S/x(2)*sqrt(x(1)^2/para.g^2 + 1)-para.Cl_max];
ceq = [];