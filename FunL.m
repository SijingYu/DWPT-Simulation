function L = FunL( R,r,N )
%螺线管自感系数计算
%   R   线圈半径
%   r   导线半径
%   N   匝数
 K = [0.1 0.2 0.3 0.4 0.6 0.8 1.0 1.5 2.0 3.0 4.0 5.0 10 20;...
     .96 .92 .88 .85 .79 .74 .69 .60 .52 .43 .37 .32 .20 .12]';
 mu_0 = 4*pi*1e-7;  %空气磁导率
 LT = 2*r;  %螺线管长度（单层）
 D0 = 2*R;  %螺线管内径
 Dw = 2*R + (2*r)*N;    %螺线管外径
 Dz = (Dw - D0)/log(Dw/D0); %等效直径
 [~,Idx] = min(abs(Dz/LT - K(:,1)));
 k = K(Idx,2);
 L = k*mu_0*N^2*pi*Dz^2/4/LT;
 


end

