function u = calcu(N,y,p);

% -- u = calcu(N,y,p);
%
% The purpose of this function is to calculate u, a matrix
% of u_{g,k} values, which is the probability of choosing a
% good territory given the rank k of the bird of interest, g
% territories remaining, and a settling time of y for THIS
% bird.
%
% INPUTS
%
% N: Number of individuals
%
% y: Settling time strategy
%
% p: Dictionary of parameters
%
% OUTPUTS
% 
% phi: Rows indices correspond to the possible number of
% good territories taken, including 0. Column indices
% minus 1 correspond to the rank of the bird K. Entries are
% the probability that bird of rank K faced with that
% many good territories taken will itself choose a good
% territory.

[od,WG,WB] = oddsratio(p,y);
u=zeros(p.TG,N);
for K = 1:min(N,p.TG+p.TB)

    % Reasoning the same as previous loop
    s = K-1;
    gmin= max(0,p.TG - s);
    gmax = min(p.TG,p.TB-s+p.TG);

    for gfree = gmin:gmax;

        % Work backwards from the assumed number of good territories
        % free and the number of birds already settled to the number
        % of bad territories free
        gtaken = p.TG-gfree;
        btaken = s-gtaken;
        bfree = p.TB-btaken;

        g_ind = gfree+1; % Remember first row is for gfree = 0
        u(g_ind,K)=WG*gfree/(WG*gfree+WB*bfree);
    end
end
u = flipud(u); % Changes indices from free to taken
