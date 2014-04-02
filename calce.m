function [eG_yy,eG_yz,eB_yy,eB_yz,e0_yy,e0_yz] = calce(N,y,z,p)

% -- [eG_yy,eG_yz,eB_yy,eB_yz,e0_yy,e0_yz] = calce(N,y,z,p)
% 
% The purpose of this function is to return the the resident
% and mutant probability of getting a sites of various types
% depending upon the population size, resident and mutant
% strategies, and parameter values.
%
% INPUTS
%
% N: Population size
%
% y: Resident settling time.
%
% z: Mutant settling time.
%
% p: Dictionary of parameter values
%
% OUTPUTS
%
% eG_yy: The probability of a resident getting a good
% territory given that all residents have the same settling
% time, $e_G(y,y)$
%
% eG_yz: The probability of a mutant getting a good
% territory given that residents the same settling time y
% and the mutnat has settling time z, $e_G(y,y)$
%
% eB_yy: The probability of a resident getting a bad
% territory given that all residents have the same settling
% time, $e_G(y,y)$
%
% eB_yz: The probability of a mutant getting a bad
% territory given that residents the same settling time y
% and the mutnat has settling time z, $e_G(y,y)$
%
% e0_yy: The probability of a resident getting no
% territory given that all residents have the same settling
% time, $e_G(y,y)$. This is only non-zero when N > T.
%
% e0_yz: The probability of a mutant getting no
% territory given that residents the same settling time y
% and the mutnat has settling time z, $e_G(y,y)$. This is
% only non-zero when N > T.

% Probability of resident acquiring a good territory given rank K
phi = calcphi(N,y,p); % Probability of being faced with g territories remaining
uy = calcu(N,y,p); % Probability of acquiring a good territory give g territories remaining
for K=1:N
    eG_ky(K)=phi(1:end,K)'*uy(1:end,K);
end

% Find the probability that a mutant bird acquires a good territory
% assuming that all the others play the resident strategy
uz = calcu(N,z,p);
for K=1:N
    eG_kz(K)=phi(1:end,K)'*uz(1:end,K);
end

% Probability of rank of mutants and residents.

% Can take into account the influence of the mutant on the
% resident's rank. Closer to true value but inconsistent with 
% assumptions of AD
% [Pk_yy,Pk_yz] = probrank(y,z,p.v,N-1); 

% Or we can assume that the presence of the mutant does not
% influence the rank probability of the resident
[Pk_yy,Pk_yz] = probrank(y,z,p.v,N-1);
[Pk_yy] = probrank(y,y,p.v,N-1);

% Calc e_G's, proability of mutants and residents acquiring
% a good territory
eG_yy = eG_ky*Pk_yy;
eG_yz = eG_kz*Pk_yz;

% Calc e_0's, proability of mutants and residents acquiring
% no territory
if p.TG+p.TB >= N % Everyone gets a territory
    e0_yy = 0;
    e0_yz = 0;
else
    e0_yy = 1-(p.TB+p.TG)/N;
    e0_yz = sum(Pk_yz(p.TB+p.TG+1:end));
end

% Calc e_B's, proability of mutants and residents acquiring
% bad territory
eB_yy = 1- eG_yy - e0_yy;
eB_yz = 1- eG_yz - e0_yz;
