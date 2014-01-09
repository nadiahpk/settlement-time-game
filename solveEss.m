function [mu,fval] = solveEss(mu0,p);

%f = @(v) dE(v,p); % Old version, didn't deal with N>TG+TB
f = @(v) dW(v,p);
[mu,fval] = fsolve(f,mu0);

