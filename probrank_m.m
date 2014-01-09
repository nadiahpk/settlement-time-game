function Pkyz = probrank_m(y,z,v,n);

% Calculate the probability that the mutant will be preceded by k
% residents. Note that n is the number of OTHER residents (i.e. N-1)

% Pky is $P_k(y)$
% Pkyz is $P_k(y,z)$
% Pkyx is $P_k(y,x_i)$

% DEBUGGING
%v = 1;
%n = 5;
%z = 0.3;
%y = 0;
% /DEBUGGING

resol = 100;
if z < y
    % k is the number of residents already settled
    Pkyz = zeros(n+1,1); % Store the probability of each number preceding here
    % Calculate the edge bit
    overlap = (z+v-y);
    if overlap <= 0;
        Pkyz(1) = 1;
    else
        Pkyz(1) = (y-z)/v; % Probability that mutant settles before mu
        deltax = overlap/(resol);
        xV = y+deltax/2:deltax:z+v-deltax/2; % Use midpoints as values right on y and y+v are 0
        deltax=xV(2)-xV(1);
        for k = 0:n; 
            ind = k+1;
            nCk = bincoeff(n,k);
            PkyxV = [];
            for x = xV;
                % Find probability that k residents have arrived before x
                Pkyx = nCk*((x-y)/v)^k*(1-(x-y)/v)^(n-k);
                PkyxV = [PkyxV;Pkyx];
            end
            Pkyz(ind) = Pkyz(ind)+(deltax/v)*sum(PkyxV);
        end
    end
elseif z > y
    Pkyz = zeros(n+1,1); % Store the probability of each number preceding here
    % Calculate the edge bit
    % Use midpoints as values right on y and y+v are 0
    overlap = (y+v-z);
    if overlap <= 0
        Pkyz(n+1) = 1;
    else
        Pkyz(n+1) = (z-y)/v; % Probability that mutant settles after y+v
        deltax = overlap/(resol);
        xV = z+deltax/2:deltax:y+v-deltax/2; 
        deltax=xV(2)-xV(1);
        for k = 0:n; 
            ind = k+1;
            nCk = bincoeff(n,k);
            PkyxV = [];
            for x = xV;
                % Find probability that k residents have arrived before x
                Pkyx = nCk*((x-y)/v)^k*(1-(x-y)/v)^(n-k);
                PkyxV = [PkyxV;Pkyx];
            end
            Pkyz(ind) = Pkyz(ind)+(deltax/v)*sum(PkyxV);
        end
    end
else % Mutant has the same strategy as resident
    Pkyz = (1/(n+1))*ones(n+1,1);
end

if sum(Pkyz)-1 > 1e-10;
    keyboard
    error('Sum of rank probabilities not 1')
end
