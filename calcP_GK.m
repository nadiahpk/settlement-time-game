function Pg_ky = calcP_GK(N,y,p)

% Calculate the probability that G territories remain given a rank of
% K and a y of OTHER residents

od = oddsratio(p,y);
%WG=oddsratio(p,mu)/(oddsratio(p,mu)+1);
%WB=1-WG;

Pg_ky = zeros(p.TG,N); 
% Rows correspond to the possible number of good territories
% remaining, including 0
% Columns correspond to the rank of the bird K, and to the number
% of birds already settled K-1
% Entries are the probability that bird of rank K is faced with that
% many good territories remaining

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

    % Debugging lines
    %str = [num2str(K),':',num2str(gmin),',',num2str(gmax)];
    %disp(str);
    for g=gmin:gmax
        Pg_ky(g+1,K)=wnhg8(p.TG-g,K-1,p.TG,p.TB,od);
        % +1 index because row 1 corresponds to g=0 
    end
end
