  
A1=[];
A2=[];
A=[];

Atrafo=[];
A1=[tril(ones(tiempo_minute,tiempo_minute),0),zeros(tiempo_minute,1)]; %crea una matriz inferior diagonal de 1
A2=[tril(-ones(tiempo_minute,tiempo_minute),0),zeros(tiempo_minute,1)]; %crea una matriz inferior diagonal de -1

%como opticoordinada 1

Atrafo=[eye(tiempo_minute),-ones(tiempo_minute,1)];
PprefLimTrafo=[];
%Prueba=[];
%PruebaLb=[];
%resultados=[];
Lbi12_mod2=Lbi12_mod(hour1:hour2);
Lbi12_mod2_rep = repmat(Lbi12_mod2, nag, 1); % Repite Lbi12_mod2 para que tenga 32 filas.
% con el siguiente bucle, realiza la coordinación por cada trafo 32
for a=1:nag; 
ub=[];
SumPmax_total=min(SumPmax1(a,:),ones(1,tiempo_minute)*Ai_mod(a)-(Lbi12_mod2_rep(a,:)));
%SumPmax_total=(SumPmax1(a,:));
ub=SumPmax_total';
ub=[ub;Ai_mod(a)]; %Le agrego la restricción de máximo del transformador para que tenga la misma dimensión que x0    
lb=zeros(tiempo_minute+1,1); % Le sumo 1, para que tenga la misma dimensión que x0  
 
B1=(SumEmax(a,:)-SumSOC_A(a,:)).*(1/delta_t_minute);
B2=-(SumEmin(a,:)-SumSOC_A(a,:)).*(1/delta_t_minute);

A=[A1;A2];
B=[B1';B2'];
Aeq=[-Atrafo];
Beq=Lbi12_mod2_rep(a,:)';

x0=zeros(1,tiempo_minute+1);

fun = @(x)((x(tiempo_minute+1)*tiempo_minute)-sum(x(1:tiempo_minute)));

options = optimoptions('fmincon', 'Display','iter','Algorithm','sqp', 'MaxFunEvals', 1000000, 'MaxIter', 5000, 'Display', 'off');
solLimTrafo=fmincon(fun,x0,A,B,Aeq,Beq,lb,ub,[],options); %quité aeq y Beq

PprefLimTrafo(a,:)=solLimTrafo(1:tiempo_minute);
lim_opt(a)=solLimTrafo(tiempo_minute+1);

end

%for a=1:nag
%Prueba1=PprefLimTrafo(a,:); 
%Prueba2=Lbi12(a,:); 
%Prueba=[Prueba;Prueba1([hinicial/(1/delta_t)+1:tiempo/(1/delta_t)]),Prueba1([1:hinicial/(1/delta_t)])];
%PruebaLb=[PruebaLb;[Prueba2([hinicial/(1/delta_t)+1:tiempo/(1/delta_t)]),Prueba2([1:hinicial/(1/delta_t)])]]
%end

%resultados=Prueba+PruebaLb;