%% Parámetros 24 horas
% delta_t=1;
% % inv_delta_t =floor(1/delta_t);
% % inv_delta_t2 =1/delta_t;
% % tiempo=24*(1/delta_t);
% % hinicial=12*(1/delta_t);
% delta_t_inv=round(1/delta_t);
% tiempo = round( 24 / delta_t); % Número de intervalos en 24 horas según delta_t2
% hinicial = round(12 / delta_t);
%% Parámetros 1 hora
minute=60;
hour=1;
delta_t_minute=1;
tiempo_minute=round(60/delta_t_minute);
hinicial_minute=round(30/delta_t_minute);

%% Costos
% Definición de los costos por unidad de tiempo
Pp = 0.138; 
Pv = 0.109; 
Pr = 0.058; 

% Número de intervalos en 24 horas según delta_t
num_intervals = tiempo; 
% Inicialización del vector C
C = zeros(1, num_intervals);

% Definición de los segmentos de tiempo y sus costos respectivos
time_segments = [5, 4, 3, 8, 4] * (1 / delta_t);
costos = [Pv, Pp, Pv, Pr, Pp];

% Construcción del vector C
startIndex = 1;
for i = 1:length(time_segments)
    segment_length = round(time_segments(i));
    C(startIndex:startIndex+segment_length-1) = costos(i);
    startIndex = startIndex + segment_length;
end

% Inicializa el vector C_mod de tamaño 1x1440
C_mod = zeros(1, 24*60);

% Llena los elementos de C_mod correspondientes a cada 60 posiciones
for i = 1:24
    C_mod((i-1)*60 + 1) = C(i);
end

% linspace para interpolar los valores entre los puntos asignados
for i = 1:23
    C_mod((i-1)*60 + 1 : i*60) = linspace(C(i), C(i+1), 60);
end

% Interpolación del último segmento para mantener el último valor de C
C_mod(1381:end) = linspace(C(24), C(24), 60);

% Interpola los primeros 60 valores entre el último y el primer término de C
C_mod(1:60) = linspace(C(end), C(1), 60); 

% %para graficar y ver como están los vectores
% subplot(2, 1, 1); % Crea la primera subgráfica en una ventana de 2 filas y 1 columna
% stem(1:24, C, 'ro-', 'LineWidth', 1.5, 'MarkerFaceColor', 'r'); % Usa stem para resaltar los puntos de C
% xlabel('Índice');
% ylabel('Valor de C');
% title('Gráfica del vector C');
% grid on;
% 
% %Segunda gráfica: vector C_mod
% subplot(2, 1, 2); % Crea la segunda subgráfica
% plot(1:1440, C_mod, 'b-', 'LineWidth', 1.5); % Grafica C_mod como una línea continua
% xlabel('Índice');
% ylabel('Valor de C\_mod');
% title('Gráfica del vector C\_mod');
% grid on;


%% TRAFOS
%Original Ai=[150,150,200,100,100,250,250,100,100,100,100,100,200,100,100,100,150,150,150,150,150,150,630,630,100,100,100,200,250,250,250,100];
Ai_mod=[100,150,100,100,100,150,200,50,100,100,100,100,200,100,100,100,150,100,100,100,150,150,600,500,100,100,100,200,200,200,200,100]; %-50MW
At_mod=sum(Ai_mod)*0.8757;  

%Se puede usar este codigo original
Ctrafo_minute=Ai_mod';
for a=1:tiempo_minute*24-1
Ctrafo_minute=[Ctrafo_minute,Ai_mod'];
end

%% DEMANDA 
Lbpu1 = 0.5 * [0.80419, 0.70429, 0.64678, 0.61235, 0.59004, 0.58142, 0.59063, 0.62614, 0.58502, 0.63958, 0.69508, 0.70351, 0.68110, 0.64846, 0.65278, 0.64721, 0.64874, 0.67891, 0.76767, 0.96259, 1, 0.98774, 0.95284, 0.88752];
Lbpu1_mod = zeros(1, 24*60);
% Llena los valores de Lbpu1 en las posiciones deseadas de Lbpu1_mod
for i = 1:24
    Lbpu1_mod((i-1)*60 + 1) = Lbpu1(i);
end
% Interpola los valores entre los puntos definidos usando linspace
for i = 1:23
    Lbpu1_mod((i-1)*60 + 1 : i*60) = linspace(Lbpu1(i), Lbpu1(i+1), 60);
end

% Ajuste de índices para Lbpu12
indices1_mod = mod(hinicial_minute + 1 : tiempo_minute + hinicial_minute, length(Lbpu1_mod));
indices1_mod(indices1_mod == 0) = length(Lbpu1_mod);

%Cambio de referencia a la hora inicial
Lbpu12 = Lbpu1(indices1);

% Asegurar que Lbpu12 tenga exactamente tiempo elementos
Lbpu12 = Lbpu12(1:tiempo);


Lbpu1_mod = circshift(Lbpu1_mod, 60);

% % Interpola los primeros 60 valores entre el último y el primer término de Lbpu1
Lbpu1_mod(1:60) = linspace(Lbpu1(end), Lbpu1(1), 60);

% Matriz de demandas de cada nag en cada intervalo de tiempo
Lbi12_mod = Ai_mod' .* Lbpu1_mod;

% Suma total de la demanda del sistema
Lbt12_mod = sum(Lbi12_mod); 
AT_mod = ones(1, tiempo_minute*24) * At_mod; % Capacidad máximo del PDT en cada hora (minuto a minuto por hora)

%Potencia Disponible en el trafo
Pdisp_mod = max(Ctrafo_minute - Lbi12_mod, 0);
Pdisp_total_mod = max(AT_mod - Lbt12_mod, 0);

% Gráfica del vector Lbpu1
subplot(2, 1, 1); % Crea la primera subgráfica en una ventana de 2 filas y 1 columna
stem(1:24, Lbpu1, 'ro-', 'LineWidth', 1.5, 'MarkerFaceColor', 'r'); % Usa stem para resaltar los puntos de Lbpu1
xlabel('Índice');
ylabel('Valor de Lbpu1');
title('Gráfica del vector Lbpu1');
grid on;

% Gráfica del vector Lbpu1_mod
subplot(2, 1, 2); % Crea la segunda subgráfica
plot(1:1440, Lbpu1_mod, 'b-', 'LineWidth', 1.5); % Grafica Lbpu1_mod como una línea continua
xlabel('Índice');
ylabel('Valor de Lbpu1\_mod');
title('Gráfica del vector Lbpu1\_mod\_shifted');
grid on;

%% CICLO FINAL 
time=60;
for tiempo_ciclo=1:time;
    
end
