function [mu,fval] = solveEss(mu0,p);

f = @(v) dW(v,p);
[mu,fval] = fsolve(f,mu0);

