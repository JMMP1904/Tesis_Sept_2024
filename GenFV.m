
Radiacion=(xlsread('C:\Users\Usuario\Dropbox\TESIS DOCTORAL\Fotovoltaico\Resultados.xls','B2:B25'))';
TempAmb=(xlsread('C:\Users\Usuario\Dropbox\TESIS DOCTORAL\Fotovoltaico\Resultados.xls','C2:C25'))';

% Cambia referencia a la hora 12 del medio d�a
Radiacion12=[Radiacion([hinicial/(1/delta_t)+1:tiempo/(1/delta_t)]),Radiacion([1:hinicial/(1/delta_t)])];
TempAmb12=[TempAmb([hinicial/(1/delta_t)+1:tiempo/(1/delta_t)]),TempAmb([1:hinicial/(1/delta_t)])];

% Se utilizan paneles policristalinos de 235 Wp 
Isc=8.30;     % Corriente de cortocircuito de una celda en condiciones est�ndar 
Voc=37.08;    % Tensi�n de circuito abierto de una celda en condiciones est�ndar 
TONC=47;      % Temperatura de operaci�n nominal de la celda 
alfa=0.0004;  % Factor de reducci�n t�rmica de la corriente 
beta=-0.0038; % Factor de reducci�n t�rmica de la tensi�n 
rendinv=0.96; % Rendimiento del inversor 

% C�lculo de la temperatura de la celda
Tcell=TempAmb12+((TONC-20)/800)*Radiacion12;

% C�lculo de la potencia FV generada aguas abajo de cada trafo, en kW
PorPenet=30; % Porcentaje de penetraci�n FV

Pfvi12=zeros(nag,tiempo);
for a=1:nag
for b=1:tiempo
Pfvi12(a,b)=(((PorPenet/100)*Ai(a))*rendinv*((Radiacion12(b)/1000)*(1+((alfa/Isc)+(beta/Voc))*(Tcell(b)-25))));
end
end

Pfv12=sum(Pfvi12);