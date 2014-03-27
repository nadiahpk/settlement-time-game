function phi = calcphi(N,y,p)

% -- phi = calcphi(N,y,p)
%
% The purpose of this function is to calculate phi, the
% probability of g territories remaining given a rank
% of k of the bird of interest and a settling time y of
% other residents. If you want it in terms of territories
% taken, use flipud(phi).
%
% INPUTS
%
% N: Number of individuals
%
% y: Settling time resident strategy
%
% p: Dictionary of parameters
%
% OUTPUTS
% 
% phi: Rows indices correspond to the possible number of
% good territories remaining, including 0. Column indices
% minus 1 correspond to the rank of the bird K. Entries are
% the probability that bird of rank K is faced with that
% many good territories remaining.

od = oddsratio(p,y);
phi = zeros(p.TG,N); 

% If the number of birds already settled exceeds the total number
% of territories, the probability of the kth bird finding any territory is 0
% hence we don't need to do the calcs for N > p.TG+p.TB
for K = 1:min(N,p.TG+p.TB)

    % G is the number of good territories left.
    % It is dependent upon the number already settled.
    s = K-1;

    % The minimum G value is when all settled took good territories,
    % so TG - no. already settled.
    gmin= max(0,p.TG - s);

    % The max G value is when all settled took bad territories, so
    %   if no. already settled < TB, it is TG
    %   else TB - number already settled + TG
    gmax = min(p.TG,p.TB-s+p.TG);

    for g=gmin:gmax
        phi(g+1,K)=wnhg8(p.TG-g,K-1,p.TG,p.TB,od);
        % +1 index because row 1 corresponds to g=0 
    end
end
