% CÁLCULO DE RESTRICCIONES DE ENERGÍA Y POTENCIA INDIVIDUALES

%Cálculo de Emin y Emáx para cada PEV

Eni_min=zeros(nPEV,tiempo);
Eni_max=zeros(nPEV,tiempo);
SOC_ARR=zeros(nPEV,tiempo);
Emin_evol=[];
Emax_evol=[];
ESOC_evol=[];

for k=1:nPEV;
 
Eni_min(k,Hc(k)-hinicial)=SOC_a(k); % Condicion inicial
Eni_max(k,Hc(k)-hinicial)=SOC_a(k); % Condicion inicial

 for n=Hp(k)+hinicial-1:tiempo;
    Eni_min(k,n)=SOC_Da(k); % Condicion final
    Eni_max(k,n)=SOC_Da(k); % Condicion final
 end

 for n=1:Hni(k)-1;
    Eni_min(k,(Hp(k)+hinicial-n))=max((Eni_min(k,(Hp(k)+hinicial-n+1))-(Pcarga/(1/delta_t))),SOC_a(k));
 end
 
 Evol_min=Eni_min(k,:); %Esta sentencia pone el valor del SOC_a de cada PEV donde Eni_min tiene el valor 0
 Evol_min(Eni_min(k,:)<=0)=SOC_a(1,k+1-1);
 Emin_evol=[Emin_evol;Evol_min];
  
 for n=1:Hni(k)-1
    Eni_max(k,(Hc(k)-hinicial+n))=min((Eni_max(k,(Hc(k)-hinicial+n-1))+(Pcarga/(1/delta_t))),SOC_Da(k));
 end
 
 Evol_max=Eni_max(k,:); %Esta sentencia pone el valor del SOC_a de cada PEV donde Eni_max tiene el valor 0
 Evol_max(Eni_max(k,:)<=0)=SOC_a(1,k+1-1);
 Emax_evol=[Emax_evol;Evol_max];
   
 %No sé realmente que hacen estas lineas de codigo 39-44
 SOC_ARR(k,Hc(k)-hinicial:end)=ones(1,tiempo+hinicial+1-Hc(k)).*SOC_a(k);
 
 Evol_SOC=SOC_ARR(k,:); %Esta sentencia pone el valor del SOC_a de cada PEV donde SOC_ARR tiene el valor 0
 Evol_SOC(SOC_ARR(k,:)<=0)=SOC_a(1,k+1-1);
 ESOC_evol=[ESOC_evol;Evol_SOC];
 
end
Emax_evol1=[Emax_evol(1:nPEV,2:tiempo),60*ones(nPEV,1)]; % El 60 es la capacidad total del PEV
Emin_evol1=[Emin_evol(1:nPEV,2:tiempo),60*ones(nPEV,1)]; % El 60 es la capacidad total del PEV