%% Grafica Estrategias Modificada 1 
% Crea ejes
figure;
axes1 = axes('Position', [0.13 0.22 0.85 0.75]);
hold(axes1, 'on');

% Establece los l�mites del eje X
xlim(axes1, [1 60]);

% Configura las propiedades del eje X
xTicks = [1 8 16 24 32 40 48 55 60];
xLabels = {'12', '15', '18', '21', '0', '3', '6', '9', '12'};
set(axes1, 'FontName', 'Times New Roman', 'FontSize', 12, ...
    'XColor', [0 0 0], 'XTick', xTicks, 'XTickLabel', xLabels, ...
    'XTickLabelRotation', 0, 'YColor', [0 0 0], 'ZColor', [0 0 0]);

% Comprueba y ajusta los datos para el ciclo horario
n = length(Lbt12_mod(hour1:hour2));
factor = 24 / n; % Ajuste del factor de escala si es necesario

% Ajustar la longitud de los datos
xData = linspace(1, 24, n);

% Crea Gr�fica
plot(xData, sum(PprefLimTrafo) + Lbt12_mod(hour1:hour2), 'MarkerFaceColor', [0 0 0], ...
    'LineWidth', 2, 'LineStyle', '-', 'Color', [0 0.44 0.73], ...
    'DisplayName', 'S_F_T_-_P_O_U');
hold on

% Grafico el perfil proporcionado
plot([3575.62 3404.27 3426.95 3397.70 3405.74 3564.12 4030.09 5053.38 5249.77 5185.41 5002.19 4659.28 ...
    4999.99 4999.99 4999.99 4999.41 4996.55 4993.72 4987.55 4394.53 3071.22 3357.65 3649.01 3693.27], ...
    'Parent', axes1, 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, 'LineStyle', '-.', 'Color', [0 0 0], ...
    'DisplayName', 'S_T_O_U');
hold on


plot(xData, Lbt12_mod(hour1:hour2), 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, ...
    'LineStyle', '--', 'Color', [0.92 0.68 0.13], 'DisplayName', 'BL');
ylabel('Potencia [kW]', 'FontWeight', 'bold')
xlabel('Tiempo [h]', 'FontWeight', 'bold')

plot(xData, PprefTrafo + Lbt12_mod(hour1:hour2), 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, ...
    'LineStyle', ':', 'Color', [0.5 0.18 0.55], 'DisplayName', 'S_P_D_T');
hold on

% Agregar leyenda
legend1 = legend(axes1, 'show');
set(legend1, 'Position', [0.155 0.79 0.135 0.093], 'FontSize', 9.5);


% %% Grafica Estrategias ORIGINAL
% % Crea ejes
% axes1 = axes('Parent', figure, 'Position', [0.13 0.22 0.85 0.75]);
% hold(axes1, 'on');
% 
% % Establece los l�mites del eje X
% xlim(axes1, [1 24]); % Ajustar a 24 si tus datos llegan hasta all�
% box(axes1, 'on');
% 
% % Modifica la ventana de la figura
% set(gcf, 'units', 'normalized');
% set(gcf, 'WindowStyle', 'normal');
% set(gcf, 'position', [0 0 0.25 0.215]);
% 
% % Configura las propiedades del eje X
% xTicks = [1 3 6 9 12 15 18 21 24];
% xLabels = {'12', '15', '18', '21', '0', '3', '6', '9', '12'};
% 
% set(axes1, 'FontName', 'Times New Roman', 'FontSize', 12, ...
%     'XColor', [0 0 0], 'XTick', xTicks, 'XTickLabel', xLabels, ...
%     'XTickLabelRotation', 0, 'YColor', [0 0 0], 'ZColor', [0 0 0]);
% 
% % Crea Gr�fica
% plot(sum(PprefLimTrafo) + Lbt12, 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, ...
%     'LineStyle', '-', 'Color', [0 0.44 0.73], 'DisplayName', 'S_F_T_-_P_O_U');
% hold on
% 
% % % Grafico el perfil proporcionado
% % plot([3575.62 3404.27 3426.95 3397.70 3405.74 3564.12 4030.09 5053.38 5249.77 5185.41 5002.19 4659.28 ...
% %     4999.99 4999.99 4999.99 4999.41 4996.55 4993.72 4987.55 4394.53 3071.22 3357.65 3649.01 3693.27], ...
% %     'Parent', axes1, 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, 'LineStyle', '-.', 'Color', [0 0 0], ...
% %     'DisplayName', 'S_T_O_U');
% % hold on
% 
% plot(Lbt12, 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, ...
%     'LineStyle', '--', 'Color', [0.92 0.68 0.13], 'DisplayName', 'BL');
% ylabel('Potencia [kW]', 'FontWeight', 'bold')
% xlabel('Tiempo [h]', 'FontWeight', 'bold')
% 
% plot(PprefTrafo + Lbt12, 'Parent', axes1, 'MarkerFaceColor', [0 0 0], 'LineWidth', 2, ...
%     'LineStyle', ':', 'Color', [0.5 0.18 0.55], 'DisplayName', 'S_P_D_T');
% hold on
% 
% legend1 = legend(axes1, 'show');
% set(legend1, 'Position', [0.155 0.79 0.135 0.093], 'FontSize', 9.5);
