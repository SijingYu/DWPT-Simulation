function [ Is,t] = ParmsAnalysis_Time( V_in,I_p,f_in,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h )
 % time domain analysis, only one of current or voltage is valid
 %  V_in    Input voltage, V
 %  I_p     Input current£¬A
 %  f_in    Input frequency
 %  C_p     transmitting capacitance
 %  R_p 	transmitting resistance
 %  C_s 	receiving capacitance
 %  R_s 	receiving resistance
 %  Z_L 	Load Impedance
 %  D_p     transmitting coil diameter£¬m
 %  D_s     receiving coil diameter£¬m
 %  d_p     transmitting coil size -- diameter£¬m
 %  d_s     receiving coil size -- diameter£¬m
 %  N_p     transmitting coil turns
 %  N_s     receiving coil turns
 %  h       distance
 %  t       time points,s
 %  Is      receiving coil responding signal
 %% Inductance
 %  CF      coupling factor
 %  Lp      transmitting coil inductance
 %  Ls      receiving coil inductance
 [CF,Lp,Ls] = CalcCouplingFactor( D_p/2,D_s/2,d_p/2,d_s/2,N_p,N_s,h );
 %% Transmitting 
 %  tf_Is_Ip        current transmitting function£¬Is/Ip
 %  tf_Is_Vp       	voltage transmitting function£¬Is/Vp
 [ tf_Is_Ip,tf_Is_Vp] = TransferFunction( C_p,Lp,R_p,C_s,Ls,R_s,Z_L,CF );
 %% time domain analysis
 [u,t] = gensig('sin',1/f_in,5/f_in);
 if ~isempty(V_in)
     if V_in ~= 0
         u = u*V_in;
         Is = lsim(tf_Is_Vp,u,t);
     end
 else
     u = u*I_p;
     Is = lsim(tf_Is_Ip,u,t);
 end