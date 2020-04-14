 clear,clc,close all
 %% Parameters
 f_min = 5;
 f_max = 150e3;
 Points = 10000;
 C_p = 0.486e-6;
%  L_p = 5.14e-6;
 R_p = 0.0391;
 C_s = 0.491e-6;
%  L_s = 5.10e-6;
 R_s = 0.0396;
 Z_L = 10.5;
 %Coil parameters
 D_p = .1;  d_p = 2e-4; N_p = 1;
 D_s = .1;  d_s = 2e-4; N_s = 1;
 h = 2e-3;
 %Frequency Domain Analysis
 [ freq,Is_Ip_Mag,Is_Ip_Phase,Is_Vp_Mag,Is_Vp_Phase ] = ...
    ParmsAnalysis_Freq( f_min,f_max,Points,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h );
 ax = plotyy(freq,Is_Ip_Mag,freq,Is_Vp_Mag);
 xlabel('Frequency/Hz')
 %ylabel(ax(1),'I_s/I_p')
 %ylabel(ax(2),'I_s/V_p')
 %Time Domain Analysis
 [ Is,t] = ParmsAnalysis_Time( [],3,10000,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h );
 figure;plot(t,Is);xlabel('Time/s');%ylabel('I_s/A')