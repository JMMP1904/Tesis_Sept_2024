        Hc=zeros(1,nPEV); 
        Hp=Hc;            
        Hni=Hc;           
        km_c=Hc;         
        Cap_auto=Hc;     
        SOC_a=Hc;        
        SOC_Da=Hc;             
for k=1:nPEV; 
        Hc(k)=max(round(hllegada+((-1+(1+1)*rand)*Cllegada)),(hinicial_minute+1)); 
        Hp(k)=min(round(hpartida+((-1+(1+1)*rand)*Cpartida)),(timex-hinicial_minute+1)); 
        Hni(k)=(Hp(k)+timex)-Hc(k); 
        km_c=max(0,km_media+(Ckm*randn)); 

	    Cap_auto(k)=(Cap(round(rand*14+1))); 
        SOC_a(k)=Cap_auto(k)*(SOCini+(randn*CSOC));
        SOC_Da(k)=min(SOC_a(k)+(Hni(k)*(Pcarga*(1/delta_t_minute))),Cap_auto(k)); 
end