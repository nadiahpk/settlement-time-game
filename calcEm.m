function [PG_y,PG_z,Pk_yz] = calcEm(N,y,z,p)

% N birds arrive and settle one after the other, but one of them is a
% mutant with settling time z. This function calculates the probability that
% the resident and the mutant will acquire a good territory PG_y and
% PG_z. It also finds the probability of a mutant acquirking rank k.

% Pg_ky
%   $P_g(k,y)$, the probability that a bird of rank k in a population
%   with strategy y is faced with g good territories remaining
% PG_gky
%   $P_G(g,k,y)$, the probability that a resident of rank k faced with
%   g good territories chooses a good territory
% PG_gkz
%   $P_G(g,k,z)$, the probability that a mutant of rank k faced with
%   g good territories chooses a good territory
% PG_ky
%   %P_G(k,y)$, the probability that a resident of rank k will choose
%   a good territory
% PG_kz
%   %P_G(k,z)$, the probability that a mutant of rank k will choose
%   a good territory
% Pk_y
%   $P_k(y)$, the probability of a resident having rank k
% Pk_yz
%   $P_k(y,z)$, the probability of a mutant having rank k


% Find the probability of each rank bird acquiring a good territory
% assuming that they all play the resident strategy

% Probability of resident acquiring a good territory given rank K
phi = calcphi(N,y,p); % Probability of being faced with g territories remaining
PG_gky = calcu(N,y,p); % Probability of acquiring a good territory give g territories remaining
for K=1:N
    PG_ky(K)=phi(1:end,K)'*PG_gky(1:end,K);
end

% Find the probability that a mutant bird acquires a good territory
% assuming that all the others play the resident strategy
PG_gkz = calcu(N,z,p);
for K=1:N
    PG_kz(K)=phi(1:end,K)'*PG_gkz(1:end,K);
end

% Probability of rank of mutants and residents
[Pk_y,Pk_yz] = probrank(y,z,p.v,N-1);

% Proability of mutants and residents acquiring a good territory
PG_y = PG_ky*Pk_y;
PG_z = PG_kz*Pk_yz;

