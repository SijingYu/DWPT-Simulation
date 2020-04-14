function L = FunL( R,r,N )
% Self-inductance coefficient
%   R   Coil radius
%   r   Wire radius
%   N   # of turns
 K = [0.1 0.2 0.3 0.4 0.6 0.8 1.0 1.5 2.0 3.0 4.0 5.0 10 20;...
     .96 .92 .88 .85 .79 .74 .69 .60 .52 .43 .37 .32 .20 .12]';
 mu_0 = 4*pi*1e-7;  %Air permeability
 LT = 2*r;  %Length of a level
 D0 = 2*R;  %Inner radius
 Dw = 2*R + (2*r)*N;    %Outer radius
 Dz = (Dw - D0)/log(Dw/D0); %Equivalent Diameter
 [~,Idx] = min(abs(Dz/LT - K(:,1)));
 k = K(Idx,2);
 L = k*mu_0*N^2*pi*Dz^2/4/LT;
 


end

