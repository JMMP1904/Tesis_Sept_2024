% C�LCULO DE RESTRICCIONES DE ENERG�A Y POTENCIA INDIVIDUALES

Eni_min=zeros(nPEV,tiempo_minute);
Eni_max=zeros(nPEV,tiempo_minute);
SOC_ARR=zeros(nPEV,tiempo_minute);
Emin_evol=[];
Emax_evol=[];
ESOC_evol=[];
for k=1:nPEV
Eni_min(k,Hc(k)-hinicial_minute)=SOC_a(k); % Condicion inicial
Eni_max(k,Hc(k)-hinicial_minute)=SOC_a(k); % Condicion inicial
 for n=Hp(k)+hinicial_minute-1:tiempo_minute
    Eni_min(k,n)=SOC_Da(k); % Condicion final
    Eni_max(k,n)=SOC_Da(k); % Condicion final
 end
 for n=1:Hni(k)-1
    Eni_min(k,(Hp(k)+hinicial_minute-n))=max((Eni_min(k,(Hp(k)+hinicial_minute-n+1))-(Pcarga/(1/delta_t_minute))),SOC_a(k));
 end
 
 Evol_min=Eni_min(k,:);
 Evol_min(Eni_min(k,:)<=0)=SOC_a(1,k+1-1);
 Emin_evol=[Emin_evol;Evol_min];
  
 for n=1:Hni(k)-1
    Eni_max(k,(Hc(k)-hinicial_minute+n))=min((Eni_max(k,(Hc(k)-hinicial_minute+n-1))+(Pcarga/(1/delta_t_minute))),SOC_Da(k));
 end
 
 Evol_max=Eni_max(k,:); 
 Evol_max(Eni_max(k,:)<=0)=SOC_a(1,k+1-1);
 Emax_evol=[Emax_evol;Evol_max];
   
 SOC_ARR(k,Hc(k)-hinicial_minute:end)=ones(1,tiempo_minute+hinicial_minute+1-Hc(k)).*SOC_a(k);
 
 Evol_SOC=SOC_ARR(k,:);
 Evol_SOC(SOC_ARR(k,:)<=0)=SOC_a(1,k+1-1);
 ESOC_evol=[ESOC_evol;Evol_SOC];
 
end
Emax_evol1=[Emax_evol(1:nPEV,2:tiempo_minute),60*ones(nPEV,1)];
Emin_evol1=[Emin_evol(1:nPEV,2:tiempo_minute),60*ones(nPEV,1)]; 

Pmax=zeros(nPEV,tiempo_minute);
for k=1:nPEV;
     for n=Hc(k)-hinicial_minute:Hp(k)+hinicial_minute
     	Pmax(k,n)=Pcarga;
     end
end
% C�LCULO DE RESTRICCIONES DE ENERG�A y POTENCIA POR AGREGADOR
for a=1:nag
SumEmin([a],[1:tiempo_minute])=sum(Eni_min([cPEV(a)+1:cPEV(a+1)],[1:tiempo_minute]));
end
for a=1:nag
SumEmax([a],[1:tiempo_minute])=sum(Eni_max([cPEV(a)+1:cPEV(a+1)],[1:tiempo_minute]));
end
for a=1:nag
SumSOC_A([a],[1:tiempo_minute])=sum(SOC_ARR([cPEV(a)+1:cPEV(a+1)],[1:tiempo_minute]));
end
SumSOC_total=sum(SumSOC_A);
SumEmin_total=sum(SumEmin)-SumSOC_total;
SumEmax_total=sum(SumEmax)-SumSOC_total;
SumPmax1=zeros(nag,tiempo_minute);
for a=1:nag
SumPmax1([a],[1:tiempo_minute])=sum(Pmax([cPEV(a)+1:cPEV(a+1)],[1:tiempo_minute]));
end
hour1=1;
hour2=60;
SumPmax=min(SumPmax1,Pdisp_mod(hour1,hour2));
