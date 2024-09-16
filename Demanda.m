
%%
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
Lbpu12 = Lbpu1_mod(indices1_mod);

% Asegurar que Lbpu12 tenga exactamente tiempo elementos
Lbpu12 = Lbpu12(1:timex);

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
