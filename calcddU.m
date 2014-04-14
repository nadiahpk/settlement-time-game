function ddU = calcddU(y,p,flagNumeric);

% -- ddU = calcddu(y,p);
% -- ddU = calcddu(y,p,flagNumeric);
%
% The purpose of this function is to calculate the
% derivative of the selection gradient. It is used to assess
% the ESS-stability of a singular strategy, which has the
% criterion that this derivative be less than zero so that
% we are at a 'peak' in the fitness landscape.
%
% INPUTS
%
% y: Singular strategy settling time. Note that you'll need to
% make sure that this is indeed the singular time (i.e.
% output from calcanalyticdU ~ 0) or else it will give you
% nonsense results so far as evolutionary stability is
% concerned. See the Figure A3 of the Appendix for
% an example.
%
% p: Dictionary of parameter values
%
% flagNumeric: Set to 1 if you'd like to verify the result
% with a numerical approximation
%
% OUTPUTS
%
% ddU: The derivative of the selection gradient at y. 

if nargin < 3
    flagNumeric = 0;
end

if flagNumeric == 0
    % Numerical description - see appendix
    N=calcNeqm(y,p);
    phi = calcphi(N,y,p);
    u = calcu(N,y,p);

    A =  ((2*(p.lambdaB-p.lambdaG)*(p.fG-p.fB))/p.v)*( ...
        sum(phi(:,N).*u(:,N).*(1-u(:,N))) - u(1,1)*(1-u(1,1))  );

    B =  ((p.lambdaB-p.lambdaG)^2*(p.fG-p.fB)/N)*( ...
        sum(sum(phi.*u.*(1-u).*(1-2*u)))  );

    C =  (p.fG-p.fB)*((N-1)/p.v^2)*( ...
         u(1,1)+sum(phi(:,N).*u(:,N))  );

    D = -((p.fG-p.fB)*(N-1)/(p.v^2))*sum(phi(:,2).*u(:,2));

    E = -((p.fG-p.fB)*(N-1)/(p.v^2))*sum(phi(:,N-1).*u(:,N-1));

    if N > p.TB+p.TG
        F = -p.fB*((N-1)/p.v^2);
        if N > p.TB+p.TG+1;
            F = F - p.fB*(N-1)/p.v^2;
        end
    else
        F = 0;
    end
        
    ddU = p.sJ*p.R*(A+B+C+D+E+F);
else
    % A naive numerical solution, for checking that the
    % analytic result is correct
    del = 1e-10;
    y_hi = y+del/2;
    y_lo = y-del/2;
    dU_hi = calcanalyticdU(y_hi,p);
    dU_lo = calcanalyticdU(y_lo,p);
    ddU = (dU_hi-dU_lo)/del;
end
    
