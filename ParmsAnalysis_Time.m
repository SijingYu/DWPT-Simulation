function [ Is,t] = ParmsAnalysis_Time( V_in,I_p,f_in,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h )
%ʱ��ģ�Ͳ�������/�����ѹ�����ֻ��һ����Ч��ͬʱ����ʱȡ��ѹΪ��Ч����
 %  V_in    ����˵�ѹ��V
 %  I_p     ����˵�����A
 %  f_in    �����ź�Ƶ��
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
 
 %  t       ��Ӧ�źŵ�ʱ���,s
 %  Is      �μ�������Ӧ�ź�
 %% ��в�������
 %  CF      coupling factor
 %  Lp      �������
 %  Ls      �μ����
 [CF,Lp,Ls] = CalcCouplingFactor( D_p/2,D_s/2,d_p/2,d_s/2,N_p,N_s,h );
 %% ���ݺ�������
 %  tf_Is_Ip        �������������ص����Ĵ��ݺ�������Is/Ip
 %  tf_Is_Vp        ������ѹ�����ص����Ĵ��ݺ�������Is/Vp
 [ tf_Is_Ip,tf_Is_Vp] = TransferFunction( C_p,Lp,R_p,C_s,Ls,R_s,Z_L,CF );
 %% ʱ����Ӧ����
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