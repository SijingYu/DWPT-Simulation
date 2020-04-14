function [ Is,t] = ParmsAnalysis_Time( V_in,I_p,f_in,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h )
%时域模型参数分析/输入电压与电流只有一个有效，同时输入时取电压为有效输入
 %  V_in    输入端电压，V
 %  I_p     输入端电流，A
 %  f_in    输入信号频率
 %  C_p     初级电容
 %  R_p 	初级电阻
 %  C_s 	次级电容
 %  R_s 	次级电阻
 %  Z_L 	负载阻抗
 %  D_p     初级线圈直径，m
 %  D_s     次级线圈直径，m
 %  d_p     初级线圈直径（粗细），m
 %  d_s     次级线圈直径（粗细），m
 %  N_p     初级线圈匝数
 %  N_s     次级线圈匝数
 %  h       线圈间距离，m
 
 %  t       响应信号的时间点,s
 %  Is      次级电流响应信号
 %% 电感参数计算
 %  CF      coupling factor
 %  Lp      初级电感
 %  Ls      次级电感
 [CF,Lp,Ls] = CalcCouplingFactor( D_p/2,D_s/2,d_p/2,d_s/2,N_p,N_s,h );
 %% 传递函数计算
 %  tf_Is_Ip        初级电流到负载电流的传递函数，即Is/Ip
 %  tf_Is_Vp        初级电压到负载电流的传递函数，即Is/Vp
 [ tf_Is_Ip,tf_Is_Vp] = TransferFunction( C_p,Lp,R_p,C_s,Ls,R_s,Z_L,CF );
 %% 时域响应计算
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