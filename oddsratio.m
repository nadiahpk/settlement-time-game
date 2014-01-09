function [od,WG,WB] = oddsratio(p,y)

%oddsratio defined as WG/WB

WG = exp(-p.lambdaG*y);
WB = exp(-p.lambdaB*y);

%od=exp( p.v*(p.lambdaG-p.lambdaB)*y );
od = WG./WB;

