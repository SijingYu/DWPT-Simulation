function [ tf_Is_Ip,tf_Is_Vp] = TransferFunction( C_p,L_p,R_p,C_s,L_s,R_s,Z_L,k )
%WPT system
 %  C_p = 0.486e-6; transmitting capacitence
 %  L_p = 5.14e-6;  transmitting inductance
 %  R_p = 0.0391;   transmitting resistance
 %  C_s = 0.491e-6; receiving capacitence
 %  L_s = 5.10e-6;  receiving inductance
 %  R_s = 0.0396;   receiving resistance
 %  Z_L = 10.5;     Load Impedance
 %  k = 0.656;      Coupling factor
 %  tf_Is_Ip        Transferring function for current£¬Is/Ip
 %  tf_Is_Vp        Transferring function for voltage£¬Is/Vp
 n = sqrt(L_s/L_p); L3 = k*L_p; L1 = L_p*(1 - k); L_Ls = L_s*(1 - k);
 L2 = L_Ls/n^2; C2 = C_s/n^2; R2 = R_s/n^2; ZL = Z_L/n^2;
 C1 = C_p;R1 = R_p;
 syms I1 I2 I3 V1 s
 [solI1, solI2,solI3] = solve([I1 == I2 + I3,V1 == I1/(s*C1) + I1*L1*s + ...
     I3*L3*s + R1*I1, I3*L3*s == I2*L2*s + I2/s/C2 + ZL*I2 + R2*I2], [I1,I2,I3]);
 [N,D] = numden(solI3/solI1);
 Num = sym2poly(N);
 Den = sym2poly(D);
 tf_Is_Ip = tf(Num,Den);
 
 [N,D] = numden(solI3/V1);
 Num = sym2poly(N);
 Den = sym2poly(D);
 tf_Is_Vp = tf(Num,Den);
 

end

