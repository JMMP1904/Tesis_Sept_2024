delta_t=0.1;      
inv_delta_t =floor(1/delta_t);
inv_delta_t2 =1/delta_t;
tiempo=24*(1/delta_t);
hinicial=12*(1/delta_t);

nag=32;

Ai=[100,150,100,100,100,150,200,50,100,100,100,100,200,100,100,100,150,100,100,100,150,150,600,500,100,100,100,200,200,200,200,100]; %-50MW
At=sum(Ai)*0.8757;  
Ctrafo=Ai';
for a=1:tiempo-1
Ctrafo=[Ctrafo,Ai'];
end


Lbpu1=0.5*[0.80419,0.70429,0.64678,0.61235,0.59004,0.58142,0.59063,0.62614,0.58502,0.63958,0.69508,0.70351,0.68110,0.64846,0.65278,0.64721,0.64874,0.67891,0.76767,0.96259,1,0.98774,0.95284,0.88752];

Lbpu12=[Lbpu1([hinicial/(1/delta_t)+1:tiempo/(1/delta_t)]),Lbpu1([1:hinicial/(1/delta_t)])]; % Cambio de referencia a la la hora inicial
Lbpu12=interp1([1:24],[Lbpu12],[(((1:tiempo)-1)*23/(tiempo-1))+1]);%,'spline';% Interpola para el caso de otros periodos de tiempo

Lbi12=zeros(nag,tiempo);

for a=1:nag
for b=1:tiempo
Lbi12(a,b)=(Ai(a)*Lbpu12(b));%-Pfvi12(a,b); % Demandas de cada trafo en kW por hora, considerando generación FV 
end
end

Lbt12=sum(Lbi12); % Demanda total del sistema
Pdisp=max(Ctrafo-Lbi12,0);

AT=ones(1,tiempo).*At; % Capacidad máximo del PDT en cada hora
Pdisp_total=max(AT-Lbt12,0);

