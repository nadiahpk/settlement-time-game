function N1 = calcN1(N0,y,p);

% Calculate the number of birds at time t+1 given the number of birds
% at time t

%E_good = calce(N0,y,p);

% Find the expected number of good territories selected
phi = calcphi(N0,y,p); % Probability of being faced with g territories remaining
u = calcu(N0,y,p); % Probability of acquiring a good territory give g territories remaining
for K=1:N0
    PG_ky(K)=phi(1:end,K)'*u(1:end,K);
end
E_good = sum(PG_ky);

if N0 > p.TG + p.TB;
    % Then some number will get no territories
    E_none = N0 - (p.TG + p.TB);
    % And if E_good + E_bad + E_none = N0
    E_bad = N0 - E_good - E_none;
    % then the number at the next year (1) is
else
    E_bad = N0 - E_good;
end
N1 = p.sA*N0 + p.R*E_good*p.sG + p.R*E_bad*p.sB;
