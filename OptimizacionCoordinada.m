hour1=1;
hour2=60;
C2=C_mod(hour1,hour2)+(0.58/(tiempo_minute)/10)*(1:(tiempo_minute));    
    
A3=[]; 
A4=[];
A=[];
Atrafo=[];
A3i=-ones(1,tiempo_minute);
A4i=ones(1,tiempo_minute);

for a=1:nag 
A3=blkdiag(A3,A3i); 
A4=blkdiag(A4,A4i); 
Atrafo=[Atrafo,eye(tiempo_minute)]; 
end

A3=[A3,zeros(nag,tiempo_minute)+1]; 
A4=[A4,zeros(nag,tiempo_minute)]; 
Atrafo=[Atrafo,-eye(tiempo_minute)]; 

ub=[];
for a=1:nag
ub=[ub,SumPmax(a,1:tiempo_minute)]; 
end
ub=ub'; 
ub(tiempo_minute*(nag+1),1)=0;  
lb=zeros(nag*tiempo_minute+tiempo_minute,1); 

for a=1:nag
SOC_aAG(a)=sum(SOC_a(cPEV(a)+1:cPEV(a+1))); 
end

for a=1:nag
SOC_DaAG(a)=sum(SOC_Da(cPEV(a)+1:cPEV(a+1))); 
end

B3=[];
for a=1:nag
B3(a)=(sum(SOC_DaAG(a))-sum(SOC_aAG(a)));  
end
B3=B3';
B4=-B3;  

Btrafo=max(At_mod*ones(tiempo_minute,1)-Lbt12_mod(hour1:hour2)',0);
A=[A3;A4;Atrafo];
B=[B3;B4;Btrafo]; 

x0=zeros(1,tiempo_minute*(nag+1));

CTotal=[];
for a=1:nag
CTotal=[CTotal,C2]; 
end

CTotal=[CTotal,1000*ones(1,tiempo_minute)]; 
fun = @(x)x*CTotal'; 

options = optimoptions('fmincon', 'Display','iter','Algorithm','sqp', 'MaxFunEvals', 1000000, 'MaxIter', 5000, 'Display', 'off');
sol=fmincon(fun,x0,A,B,[],[],lb,ub,[],options);

Ppref=[];
Prueba=[];
PruebaLb=[];
resultadoscoord=[];

for a=1:nag
Ppref=[Ppref;sol(1+(a-1)*tiempo_minute:tiempo_minute+(a-1)*tiempo_minute)];
end

for a=1:nag
Prueba1=Ppref(a,:); 
Prueba2=Lbi12_mod(a,:); 
Prueba=[Prueba;Prueba1([hinicial_minute/(delta_t_inv_minute)+1:tiempo_minute/(delta_t_inv_minute)]),Prueba1([1:hinicial_minute/(delta_t_inv_minute)])];
PruebaLb=[PruebaLb;[Prueba2([hinicial_minute/(delta_t_inv_minute)+1:tiempo_minute/(delta_t_inv_minute)]),Prueba2([1:hinicial_minute/(delta_t_inv_minute)])]];
end

resultadosCoord=Prueba+PruebaLb; 