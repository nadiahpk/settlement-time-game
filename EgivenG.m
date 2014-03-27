function PG_gk = EgivenG(N,y,p);

[od,WG,WB] = oddsratio(p,y);

PG_gk=zeros(p.TG,N);
% Rows correspond to the possible number of good territories remaining
% Columns correspond to the rank of the bird K, and to the number
% of birds already settled K-1
% Entries are the probability that bird of rank K will pick
% one good territory from the
% urn GIVEN THAT there are that many good territories left
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

        % Debugging lines
        %str = [num2str(K),':',num2str(gfree),',',num2str(bfree)];
        %disp(str)

        g_ind = gfree+1; % Remember first row is for gfree = 0
        PG_gk(g_ind,K)=WG*gfree/(WG*gfree+WB*bfree);
    end
end
