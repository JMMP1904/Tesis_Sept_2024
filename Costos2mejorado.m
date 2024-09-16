% Definición de los costos por unidad de tiempo
Pp = 0.138; 
Pv = 0.109; 
Pr = 0.058; 

% Valor de delta_t (ejemplo: cada 6 minutos que se colgaba)
delta_t = 0.16667;

% Número de intervalos en 24 horas según delta_t
num_intervals = round(24 / delta_t);

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

% % Verificación de la longitud de C
% disp(['Longitud de C: ', num2str(length(C))]);
% 
% % Verificación visual del vector C
% disp('Vector C:');
% disp(C);