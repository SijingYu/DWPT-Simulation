function [CF,Lp,Ls] = CalcCouplingFactor( R_p,R_s,r_p,r_s,Np,Ns,h )
%耦合系数计算
%   Detailed explanation goes here
%   R_p     初级线圈半径，m
%   R_s     次级线圈半径，m
%   r_p     初级线圈半径（粗细），m
%   r_s     次级线圈半径（粗细），m
%   N_p     初级线圈匝数
%   N_s     次级线圈匝数
%   h       线圈间距离
%
%   Lp      初级线圈电感
%   Ls      次级线圈电感 
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

