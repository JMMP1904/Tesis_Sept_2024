delta_t2=1;      
tiempo2=24*(1/delta_t2);
hinicial2=12*(1/delta_t2);

Ai2=[100,150,100,100,100,150,200,50,100,100,100,100,200,100,100,100,150,100,100,100,150,150,600,500,100,100,100,200,200,200,200,100]; %-50MW
At2=sum(Ai2)*0.8757;  
Ctrafo2=Ai2';
for a2=1:tiempo2-1
Ctrafo2=[Ctrafo2,Ai2'];
end

nag2=32;

Lbpu1_2=0.5*[0.80419,0.70429,0.64678,0.61235,0.59004,0.58142,0.59063,0.62614,0.58502,0.63958,0.69508,0.70351,0.68110,0.64846,0.65278,0.64721,0.64874,0.67891,0.76767,0.96259,1,0.98774,0.95284,0.88752];

Lbpu12_2=[Lbpu1_2([hinicial2/(1/delta_t2)+1:tiempo2/(1/delta_t2)]),Lbpu1_2([1:hinicial2/(1/delta_t2)])]; % Cambio de referencia a la la hora inicial
Lbpu12_2=interp1([1:24],[Lbpu12_2],[(((1:tiempo2)-1)*23/(tiempo2-1))+1]);%,'spline';% Interpola para el caso de otros periodos de tiempo

Lbi12_2=zeros(nag2,tiempo2);

for a2=1:nag2
for b2=1:tiempo2
Lbi12_2(a2,b2)=(Ai2(a2)*Lbpu12_2(b2));%-Pfvi12(a,b); % Demandas de cada trafo en kW por hora, considerando generación FV 

end
end

Lbt12_2=sum(Lbi12_2); % Demanda total del sistema


AT_2=ones(1,tiempo2).*At2; % Capacidad máximo del PDT en cada hora

Pdisp2=max(Ctrafo2-Lbi12_2,0);
Pdisp_total2=max(AT_2-Lbt12_2,0);