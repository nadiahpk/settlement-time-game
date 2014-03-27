function res = dW(mu,p)

del = 0.0001;
N = calcNeqm(mu,p);
if N < 1
    res = 1;
else
    mup1 = mu-del;
    mup2 = mu+del;
    if N <= p.TG+p.TB
        % Probability of getting a good territory
        [PGr1,PGm1] = calcEm(N,mu,mup1,p);
        [PGr2,PGm2] = calcEm(N,mu,mup2,p); % Note that resident changes with mutant
        % Probability of getting a bad territory
        PBr1 = 1-PGr1;
        PBr2 = 1-PGr2;
        PBm1 = 1-PGm1;
        PBm2 = 1-PGm2;
    else
        % Probability of getting a good territory
        [PGr1,PGm1,PKm1] = calcEm(N,mu,mup1,p);
        [PGr2,PGm2,PKm2] = calcEm(N,mu,mup2,p);
        % Probability of getting a bad territory for residents
        PBr1 = p.TB/N;
        PBr2 = p.TB/N;
        % Probability of getting no territory for mutant
        PNm1 = sum(PKm1(p.TB+p.TG+1:end));
        PNm2 = sum(PKm2(p.TB+p.TG+1:end));
        % Probability of getting a bad territory for mutants
        PBm1 = 1-PGm1-PNm1;
        PBm2 = 1-PGm2-PNm2;
    end
    sA = p.sA; sB = p.sB; sG = p.sG; R = p.R;

    Wr1 = sA + R*(PGr1*sG + PBr1*sB);
    Wr2 = sA + R*(PGr2*sG + PBr2*sB);

    Wm1 = sA + R*(PGm1*sG + PBm1*sB);
    Wm2 = sA + R*(PGm2*sG + PBm2*sB);

    del1 = Wm1-Wr1;
    del2 = Wm2-Wr2;

    if N > 1
        res = (del2-del1)/del; % A bit strange but has better robustness
    else
        res = (Wm2-Wm1)/del; % Because Wr equal
    end
end
