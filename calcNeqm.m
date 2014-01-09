function Ns = calcNeqm(y,p);

% This function calculates the equilibrium N.
% It does so using a bisection method, but it also rounds the 
% value to the nearest whole number of birds.

% The highest Ns scenario is Ns > p.TB + p.TG, in which case
Nsh = ceil(p.R*(p.TG*p.sG + p.TB*p.sB)/(1-p.sA));
% The lowest Ns scenario is Ns < TG, TB, but that can't be solved for
% Ns, so we'll just go with 1
Nsl = 1;
% Grab the midpoint between our high and low estimates, floor it
Nsm = floor((Nsl+Nsh)/2);

% Calculate the population size for each at time 1
Nsl1 = floor(calcN1(Nsl,y,p));
Nsh1 = (calcN1(Nsh,y,p));
Nsm1 = floor(calcN1(Nsm,y,p));

% Check initial guesses 
flag_done = 0;

% Coding like a gumby for now - tidy later ***
if (Nsl1 < Nsl);
    % Verify that the system can sustain at least one
    % bird, so if N0 = Nsl, N1 > N0 
    %disp('Cannot sustain 1 bird');
    flag_done = 1;
    Ns = 0;
else
    % Verify that we haven't already found the transition point
    if (Nsh - Nsl <= 1)
        %disp('Well that was easy');
        flag_done = 1;
        if Nsl1-Nsl < Nsh-Nsh1
            Ns = Nsl;
        else
            Ns = Nsh;
        end
    end
end
if (round(Nsh1) > Nsh);
    % Verify that the system cannot sustain more than Nsh
    keyboard
    error("How did you manage that?")
end

if flag_done == 0
    while Nsl < Nsm && Nsh > Nsm; 
        if Nsm1 >= Nsm;
            Nsl = Nsm;
            Nsl1 = Nsm1;
            Nsm = floor((Nsl+Nsh)/2);
            Nsm1 = (calcN1(Nsm,y,p));
        else % if Nsm1 < Nsm
            Nsh = Nsm;
            Nsh1 = Nsm1;
            Nsm = floor((Nsl+Nsh)/2);
            Nsm1 = (calcN1(Nsm,y,p));
        end
    end

    % Pick the one that's closest
    if Nsl1-Nsl < Nsh-Nsh1
        Ns = Nsl;
    else
        Ns = Nsh;
    end
end
