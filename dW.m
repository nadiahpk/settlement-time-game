function res = dW(y,p)

% -- res = dW(y,p)
%
% The purpose of this function is to calculate the selection
% gradient numerically. It can be used with solveEss.m
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

del = 0.0001;
N = calcNeqm(y,p);
if N < 1
    res = 1;
else
    z1 = y-del;
    z2 = y+del;
    [eGr1,eGm1,eBr1,eBm1]=calce(N,y,z1,p); % r: resident (y)
    [eGr2,eGm2,eBr2,eBm2]=calce(N,y,z2,p); % m: mutant (z)

    sA = p.sA; sB = p.sB; sG = p.sG; R = p.R;

    Wr1 = sA + R*(eGr1*sG + eBr1*sB);
    Wr2 = sA + R*(eGr2*sG + eBr2*sB);

    Wm1 = sA + R*(eGm1*sG + eBm1*sB);
    Wm2 = sA + R*(eGm2*sG + eBm2*sB);

    del1 = Wm1-Wr1;
    del2 = Wm2-Wr2;

    if N > 1
        res = (del2-del1)/del; % A bit strange but has better robustness
    else
        res = (Wm2-Wm1)/del; % Because Wr equal
    end
end
