function [CF,Lp,Ls] = CalcCouplingFactor( R_p,R_s,r_p,r_s,Np,Ns,h )
%	Calculate coupling factor 
%   Detailed explanation goes here
%   R_p     transimitting coil radius£¬m
%   R_s     receiving coil radius£¬m£¬m
%   r_p     transimitting coil size -- radius£¬m
%   r_s     receiving coil size -- radius£¬m
%   N_p     transimitting turns
%   N_s     receiving turns
%   h       distance
%
%   Lp      transimitting inductance
%   Ls      receiving inductance
 mu_0 = 4*pi*1e-7;
%  Kc = @(phi) 1./sqrt(1 - (sin(phi)*c).^2);
%  Ec = @(phi) sqrt(1 - (sin(phi)*c).^2);
 M = 0;
 for iter = 1:Np
     Rp1 = R_p + (iter - 1)*2*r_p;
     for iter1 = 1:Ns
         Rs1 = R_s + (iter1 - 1)*2*r_s;
         c = sqrt(4*Rp1*Rs1/((Rp1 + Rs1)^2 + h^2));
         M = M + mu_0*sqrt(Rp1*Rs1)*((2/c - c)*ellipticK(c) - 2/c*ellipticE(c))*4*pi;
     end
 end
 Lp = FunL( R_p,r_p,Np );
 Ls = FunL( R_s,r_s,Ns );
 CF = M/sqrt(Lp*Ls);
end

