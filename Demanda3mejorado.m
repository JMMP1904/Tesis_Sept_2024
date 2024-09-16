delta_t2 = 0.05;
tiempo2 = round(24 / delta_t2); % Número de intervalos en 24 horas según delta_t2
hinicial2 = round(12 / delta_t2);

Ai2 = [100, 150, 100, 100, 100, 150, 200, 50, 100, 100, 100, 100, 200, 100, 100, 100, 150, 100, 100, 100, 150, 150, 600, 500, 100, 100, 100, 200, 200, 200, 200, 100]; % Vector Ai2

At2 = sum(Ai2) * 0.8757; % Capacidad máxima del PDT en kW

% Generación de Ctrafo2
Ctrafo2 = repmat(Ai2', 1, tiempo2);

Lbpu1_2 = 0.5 * [0.80419, 0.70429, 0.64678, 0.61235, 0.59004, 0.58142, 0.59063, 0.62614, 0.58502, 0.63958, 0.69508, 0.70351, 0.68110, 0.64846, 0.65278, 0.64721, 0.64874, 0.67891, 0.76767, 0.96259, 1, 0.98774, 0.95284, 0.88752];

% Ajuste de índices para Lbpu12_2
indices1 = mod(hinicial2 + 1 : tiempo2 + hinicial2, length(Lbpu1_2));
indices1(indices1 == 0) = length(Lbpu1_2);

% Cambio de referencia a la hora inicial
Lbpu12_2 = Lbpu1_2(indices1);

% Asegurar que Lbpu12_2 tenga exactamente tiempo2 elementos
Lbpu12_2 = Lbpu12_2(1:tiempo2);

% Interpolación para ajustar a cualquier delta_t2
new_time_indices2 = linspace(1, 24, tiempo2);  % Índices de tiempo ajustados
Lbpu12_2 = interp1(1:length(Lbpu12_2), Lbpu12_2, new_time_indices2, 'linear');

% Matriz de demandas de cada nag en cada intervalo de tiempo
Lbi12_2 = Ai2' .* Lbpu12_2;

% Suma total de la demanda del sistema
Lbt12_2 = sum(Lbi12_2); 

AT_2 = ones(1, tiempo2) * At2; % Capacidad máximo del PDT en cada hora

Pdisp2 = max(Ctrafo2 - Lbi12_2, 0);
Pdisp_total2 = max(AT_2 - Lbt12_2, 0);