function [ freq,Is_Ip_Mag,Is_Ip_Phase,Is_Vp_Mag,Is_Vp_Phase ] = ...
    ParmsAnalysis_Freq( f_min,f_max,Points,C_p,R_p,C_s,R_s,Z_L,...
    D_p,D_s,d_p,d_s,N_p,N_s,h )
%频域模型参数分析
 %  f_min   分析频率下限，Hz
 %  f_max   分析频率上限，Hz
 %  Points  分析频段点数，正整数
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
 
 %  freq    频率点列矢量，Hz
 %  Is_Ip_Mag   初级电流到次级电流的传递函数幅值
 %  Is_Ip_Phase 初级电流到次级电流的传递函数相位
 %  Is_Vp_Mag   初级电压到次级电流的传递函数幅值
 %  Is_Vp_Phase 初级电压到次级电流的传递函数相位
 %% 电感参数计算
 %  CF      coupling factor
 %  Lp      初级电感
 %  Ls      次级电感
 [CF,Lp,Ls] = CalcCouplingFactor( D_p/2,D_s/2,d_p/2,d_s/2,N_p,N_s,h );
 %% 传递函数计算
 %  tf_Is_Ip        初级电流到负载电流的传递函数，即Is/Ip
 %  tf_Is_Vp        初级电压到负载电流的传递函数，即Is/Vp
 [ tf_Is_Ip,tf_Is_Vp] = TransferFunction( C_p,Lp,R_p,C_s,Ls,R_s,Z_L,CF );
 %% 频率响应计算
 freq = linspace(f_min,f_max,Points);
 [Is_Ip_Mag,Is_Ip_Phase] = FreqResp( tf_Is_Ip.num,tf_Is_Ip.den,freq );
 [Is_Vp_Mag,Is_Vp_Phase] = FreqResp( tf_Is_Vp.num,tf_Is_Vp.den,freq );
end

