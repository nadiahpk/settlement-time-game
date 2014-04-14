p.sA=0.6; % Adult survival 
p.v=1;
p.R=2.25; % Reproduction rate 
p.lambdaG = 0.2;
p.lambdaB = 2.2;
p.fB = 0.35;
p.fG = 0.7;
p.sJ = .35;

% This part is scaled from 250:750
p.TG=4; 
p.TB=12;

% If only there was a way to define it always as the product
p.sB=p.fB*p.sJ; % Offspring survival bad territory
p.sG=p.fG*p.sJ; % 

% This parameter set has the following dynamics:
% y* = 0.82902
% N* = 7
