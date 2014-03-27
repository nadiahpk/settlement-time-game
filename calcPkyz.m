function Pkyz = calcPkyz(y,z,v,n);

% -- Pkyz = calcPkyz(y,z,v,n)
%
% The purpose of this function is to calculate Pkyz the probability
% that a mutant will be preceded by k residents. Pkyz is
% returned as a column vector, with entries equal to the
% probability and indices equal to -1 plus the number of
% residents that preceded the mutant.
%
% The calculation method is a little different to that
% presented in the appendix of the paper, in that the
% arrival distribution and the integral is taken from 
% e.g. y -> y+v, rather than y-v/2 -> y+v/2. However the two
% are equivalent.
%
% INPUTS
% 
% y: The resident strategy settling time
%
% z: The mutant strategy settling time
%
% v: Width of the arrival distribution
%
% n: The number of OTHER residents, not counting the mutant (i.e. N-1)
%
% OUTPUTS
%
% Pkyz: A column vector of probabilities that the mutant will be preceded by k residents.


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
        for k = 0:n; % Note that "k" here is the number of residents that have arrived before, not the rank of our target bird arriving at xi
            ind = k+1;
            nCk = bincoeff(n,k);
            psixV = [];
            for x = xV;
                % Find probability that k residents have arrived before x
                psix = nCk*((x-y)/v)^k*(1-(x-y)/v)^(n-k);
                psixV = [psixV;psix];
            end
            Pkyz(ind) = Pkyz(ind)+(deltax/v)*sum(psixV);
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
            psixV = [];
            for x = xV;
                % Find probability that k residents have arrived before x
                psix = nCk*((x-y)/v)^k*(1-(x-y)/v)^(n-k);
                psixV = [psixV;psix];
            end
            Pkyz(ind) = Pkyz(ind)+(deltax/v)*sum(psixV);
        end
    end
else % Mutant has the same strategy as resident
    Pkyz = (1/(n+1))*ones(n+1,1);
end

if sum(Pkyz)-1 > 1e-10;
    keyboard
    error('Sum of rank probabilities not 1')
end
