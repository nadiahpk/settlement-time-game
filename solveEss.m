function [y,fval] = solveEss(y0,p);

% -- [y,fval] = solveEss(y0,p);
%
% The purpose of this function is to find the evolutionarily
% singular settling time strategy. It does this numerically
% using dW.m and fsolve.
%
% INPUTS
%
% y0: An initial y* estimate
%
% p: A dictionary of parameter values
% 
% OUTPUTS
%
% y: The singular settling time strategy y*
%
% fval: Residual from fsolve

f = @(v) dW(v,p);
[y,fval] = fsolve(f,y0);

