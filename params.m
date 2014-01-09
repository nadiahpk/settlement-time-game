% From Ken's email
p.sA=0.6; % Adult survival (male, has refs)
p.v=1;
p.R=2.25; % Reproduction rate (has refs)
p.TG=5;
p.TB=10;
p.lambdaG = 0.2;
p.lambdaB = 2.2;
p.fB = 0.35;
p.fG = 0.7;
p.sJ = .35;

%p.lambdaB = 100; % Make it massive

% NOTE THIS MAY NEED TO BE RECALCULATED so use update_sBsG.m
% If only there was a way to define it always as the product
p.sB=p.fB*p.sJ; % Offspring survival bad territory
p.sG=p.fG*p.sJ;

% Info about default params:
% mu = 0.58899
% N = 10
