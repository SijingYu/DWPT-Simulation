function [ freq,Is_Ip_Mag,Is_Ip_Phase,Is_Vp_Mag,Is_Vp_Phase ] = ...
    ParmsAnalysis_Freq( f_min,f_max,Points,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h )
%Ƶ��ģ�Ͳ�������
 %  f_min   ����Ƶ�����ޣ�Hz
 %  f_max   ����Ƶ�����ޣ�Hz
 %  Points  ����Ƶ�ε�����������
 %  C_p     ��������
 %  R_p 	��������
 %  C_s 	�μ�����
 %  R_s 	�μ�����
 %  Z_L 	�����迹
 %  D_p     ������Ȧֱ����m
 %  D_s     �μ���Ȧֱ����m
 %  d_p     ������Ȧֱ������ϸ����m
 %  d_s     �μ���Ȧֱ������ϸ����m
 %  N_p     ������Ȧ����
 %  N_s     �μ���Ȧ����
 %  h       ��Ȧ����룬m
 
 %  freq    Ƶ�ʵ���ʸ����Hz
 %  Is_Ip_Mag   �����������μ������Ĵ��ݺ�����ֵ
 %  Is_Ip_Phase �����������μ������Ĵ��ݺ�����λ
 %  Is_Vp_Mag   ������ѹ���μ������Ĵ��ݺ�����ֵ
 %  Is_Vp_Phase ������ѹ���μ������Ĵ��ݺ�����λ
 %% ��в�������
 %  CF      coupling factor
 %  Lp      �������
 %  Ls      �μ����
 [CF,Lp,Ls] = CalcCouplingFactor( D_p/2,D_s/2,d_p/2,d_s/2,N_p,N_s,h );
 %% ���ݺ�������
 %  tf_Is_Ip        �������������ص����Ĵ��ݺ�������Is/Ip
 %  tf_Is_Vp        ������ѹ�����ص����Ĵ��ݺ�������Is/Vp
 [ tf_Is_Ip,tf_Is_Vp] = TransferFunction( C_p,Lp,R_p,C_s,Ls,R_s,Z_L,CF );
 %% Ƶ����Ӧ����
 freq = linspace(f_min,f_max,Points);
 [Is_Ip_Mag,Is_Ip_Phase] = FreqResp( tf_Is_Ip.num,tf_Is_Ip.den,freq );
 [Is_Vp_Mag,Is_Vp_Phase] = FreqResp( tf_Is_Vp.num,tf_Is_Vp.den,freq );
end

