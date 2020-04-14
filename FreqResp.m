function [Mag,Phase] = FreqResp( Num,Den,f )
 if isrow(f);f = f';end
 if iscell(Num);Num = Num{:};end
 if iscell(Den);Den = Den{:};end
 w = 2*pi*f;
 W_num = zeros(numel(f),numel(Num));
 W_den = zeros(numel(f),numel(Den));
 for iter = 1:numel(Num)
     W_num(:,end - iter + 1) = (1i*w).^(iter - 1);
 end
 for iter = 1:numel(Den)
     W_den(:,end - iter + 1) = (1i*w).^(iter - 1);
 end
 rsp = (Num*W_num')./(Den*W_den');
 Mag = abs(rsp);
 Phase = phase(rsp);
end

