function [ freq,Is_Ip_Mag,Is_Ip_Phase,Is_Vp_Mag,Is_Vp_Phase ] = ...
    ParmsAnalysis_Freq( f_min,f_max,Points,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h )
%Parameters
 %  f_min   min frequency£¬Hz
 %  f_max   max frequency£¬Hz
 %  Points  
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
 
 %  freq    Hz
 %  Is_Ip_Mag   transmitting current amptitude
 %  Is_Ip_Phase transmitting current phase
 %  Is_Vp_Mag   transmitting voltage amptitude
 %  Is_Vp_Phase transmitting voltage phase
 %% Inductance
 %  CF      coupling factor
 %  Lp      transmitting coil inductance
 %  Ls      receiving coil inductance
 [CF,Lp,Ls] = CalcCouplingFactor( D_p/2,D_s/2,d_p/2,d_s/2,N_p,N_s,h );
 %% Tranmitting
 %  tf_Is_Ip        current transmitting function£¬Is/Ip
 %  tf_Is_Vp       	voltage transmitting function£¬Is/Vp
 [ tf_Is_Ip,tf_Is_Vp] = TransferFunction( C_p,Lp,R_p,C_s,Ls,R_s,Z_L,CF );
 %% Frequency
 freq = linspace(f_min,f_max,Points);
 [Is_Ip_Mag,Is_Ip_Phase] = FreqResp( tf_Is_Ip.num,tf_Is_Ip.den,freq );
 [Is_Vp_Mag,Is_Vp_Phase] = FreqResp( tf_Is_Vp.num,tf_Is_Vp.den,freq );
end

