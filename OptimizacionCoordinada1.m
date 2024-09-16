
C2=C_mod(hour1,hour2)+(0.58/(tiempo_minute)/10)*(1:(tiempo_minute)); % Para carga temprana 

A1=[];
A2=[];
A=[];
%(1/delta_t)
Atrafo=[];
% En comparación con Optcoordinada solo se cambia A3 por A1 y A4 por A2
A1=[tril(ones(tiempo_minute,tiempo_minute),0),zeros(tiempo_minute,tiempo_minute)]; %crea una matriz inferior diagonal de 1
A2=[tril(-ones(tiempo_minute,tiempo_minute),0),zeros(tiempo_minute,tiempo_minute)]; %crea una matriz inferior diagonal de -1

Atrafo=[eye(tiempo_minute),-eye(tiempo_minute)]; %De 24x792 a 24x48
Ppref1=[];
ub=[];

%SumPmax_total=min(SumPmax1(a,:),(ones(1,tiempo)*Ai(a)-Lbi12(a,:)));
%%Cuando está FV
SumPmax_total=(sum(SumPmax1)); %suma por columnas lo obtenido en SumPmax1

ub=SumPmax_total'; %Cambia de 792x1 a 24x1
ub=[ub;At_mod*ones(tiempo_minute,1)]; %Le agrega la restricción de máximo del transformador para que tenga la misma dimensión que x0 (48x1)   
lb=zeros(tiempo_minute+tiempo_minute,1); % Le sumo 1, para que tenga la misma dimensión que x0  (Cambia de 792x1 a 

%%
B1=(SumEmax_total).*(1/delta_t_minute);%%%si incluye delta t, multiplicar por ro
B2=(-SumEmin_total).*(1/delta_t_minute);%%%si incluye delta t, multiplicar por ro
Btrafo=max(At_mod*ones(tiempo_minute,1)-Lbt12_mod(hour1:hour2)',0);

A=[A1;A2;Atrafo];
B=[B1';B2';Btrafo];

CTotal=[];
CTotal=[CTotal,C2];

CTotal=[CTotal,1000*ones(1,tiempo_minute)];

x0=zeros(1,tiempo_minute+tiempo_minute);

%Crea un identificador de una función: es un tipo de dato de MATLAB® que almacena una asociación con una función
%Funtion_handle Un identificador de función es un tipo de dato de MATLAB® que representa una función. 
fun = @(x)x*CTotal';%función anonima @(x) que es x*CTotal'

options = optimoptions('fmincon', 'Display','iter','Algorithm','sqp', 'MaxFunEvals', 100000, 'MaxIter', 5000, 'Display', 'off');
%optimoptions=Crea opciones de optimización --- Display = Nivel de visualización 
%'iter' muestra la salida en cada iteración y emite el mensaje de salida predeterminado.
%Algorithm=Permite escoger el algoritmo de optimización --- SQP = Algoritmo
%de optimización
%MaxFunEvals = Número máximo de evaluaciones de función permitidas, un entero positivo. 
%MaxIter = Número máximo de iteraciones permitidas, un entero positivo. 
%'off' o 'none' no muestran salida alguna.

sol1=fmincon(fun,x0,A,B,[],[],lb,ub,[],options);
%minimiza con las opciones de optimización especificadas en options. 
%Utilice optimoptions para configurar estas opciones. 
%Si no hay restricciones de igualdad o desigualdad no lineales, establezca nonlcon = [].

Ppref1=[Ppref1;sol1(1:tiempo_minute)];
 