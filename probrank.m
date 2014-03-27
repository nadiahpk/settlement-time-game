function [Pky,Pkyz] = probrank(y,z,v,n);

% Finds residents' and mutant's rank probability vector.
% Use the probability of each rank for the mutant to find the
% probability of each rank for the resident, as the resident's rank
% will depend upon the mutant's rank for small n

% Pky is $P_k(y)$
% Pkyz is $P_k(y,z)$

if n == 0;
    Pky = 1; % $P_k(y)$
    Pkyz = 1; % $P_k(y,z)$
else
    % Note that n is the number of residents, not counting the mutant
    Pkyz = calcPkyz(y,z,v,n); 
    Pky = zeros(n+1,1); % Store values here
    for K = 1:n+1
        % The probability of a resident having any of the other n
        % positions is equal, and the likelihood of being given that
        % choice of the n other positions is equal to the probability that
        % the mutant will have that rank K
        pnew = ones(n+1,1)*Pkyz(K);
        pnew(K)=0;
        Pky = Pky + pnew;
    end
    Pky = Pky/sum(Pky);
end
