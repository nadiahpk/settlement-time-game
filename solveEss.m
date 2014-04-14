function [y,fval] = solveEss(y0,p,flagAnalytic);

% -- [y,fval] = solveEss(y0,p);
% -- [y,fval] = solveEss(y0,p,flagAnalytic);
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
% flagAnalytic: Set to 1 if you want to use the analytic
% definition of the fitness gradient
% 
% OUTPUTS
%
% y: The singular settling time strategy y*
%
% fval: Residual from fsolve

if nargin < 3
    flagAnalytic = 1;
end

if flagAnalytic == 1
    f = @(v) calcanalyticdU(v,p);
else
    f = @(v) calcnumericdU(v,p);
end
[y,fval] = fsolve(f,y0);

