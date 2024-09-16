% Definición de los costos por unidad de tiempo
Pp = 0.138; 
Pv = 0.109; 
Pr = 0.058; 
timex=24;
% Número de intervalos en 24 horas según delta_t
num_intervals = timex; 
% Inicialización del vector C
C = zeros(1, num_intervals);

% Definición de los segmentos de tiempo y sus costos respectivos
time_segments = [5, 4, 3, 8, 4] * (1 / delta_t_minute);
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

