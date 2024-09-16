A1=[];
A2=[];
A=[];

Atrafo=[];
A1=[tril(ones(tiempo_minute,tiempo_minute),0),zeros(tiempo_minute,tiempo_minute)];
A2=[tril(-ones(tiempo_minute,tiempo_minute),0),zeros(tiempo_minute,tiempo_minute)];

Atrafo=[eye(tiempo_minute),-ones(tiempo_minute)];

ub=[];
%SumPmax_total=min(sum(SumPmax1),(ones(1,tiempo)*At-Lbt12));
SumPmax_total=(sum(SumPmax1));

ub=SumPmax_total';
ub=[ub;At_mod*ones(tiempo_minute,1)]; %Le agrego la restricción de máximo del transformador para que tenga la misma dimensión que x0    
lb=zeros(tiempo_minute+tiempo_minute,1); % Le sumo 1, para que tenga la misma dimensión que x0  

B1=SumEmax_total.*(1/delta_t_minute);%%%si incluye delta t, multiplicar por ro
B2=-SumEmin_total.*(1/delta_t_minute);%%%si incluye delta t, multiplicar por ro

A=[A1;A2];
B=[B1';B2'];
Aeq=[-Atrafo];
Beq=Lbt12_mod(hour1:hour2)';
x0=zeros(1,tiempo_minute+tiempo_minute);

%fun = @(x)(sum(x((tiempo+1):end)*tiempo)-sum(x(1:tiempo)));
fun = @(x)(sum(x(1:tiempo_minute)));

options = optimoptions('fmincon', 'Display','iter','Algorithm','sqp', 'MaxFunEvals', 1000000, 'MaxIter', 5000, 'Display', 'off');
solTrafo=fmincon(fun,x0,A,B,Aeq,Beq,lb,ub,[],options);

LimTrafo=solTrafo(1,(tiempo_minute+1:end));
LimTrafoPorcentaje=((solTrafo(1,tiempo_minute+1:end))./sum(Ai_mod))*100;

PprefTrafo=[];
PprefTrafo=[PprefTrafo;solTrafo(1:tiempo_minute)];

