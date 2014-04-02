function res = calcanalyticdU(y,p);

% -- res = calcanalyticdU(y,p)
%
% The purpose of this function is to calculate the selection
% gradient analytically. The derivation of the analytic
% solution can be found in Appendix 1. This function can be
% used with solveEss.m
%
% INPUTS
% 
% y: Settling time strategy
%
% p: Dictionary of parameter values
%
% OUTPUTS
%
% res: The selection gradient at y. 

N = calcNeqm(y,p);
phi = calcphi(N,y,p);
u = calcu(N,y,p);
aa = sum(sum(phi.*u.*(1-u)));
A = (p.fG-p.fB)*((p.lambdaB-p.lambdaG)/N)*aa;
bb = sum(phi(:,N).*u(:,N))-u(1,1);
B = ((p.fG-p.fB)/p.v)*bb;
if N > p.TB+p.TG
    C = -p.fB/v;
else
    C = 0;
end

res = A+B+C;
