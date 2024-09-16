% Crear ejes
axes1 = axes('Parent', figure, 'Position', [0.13 0.22 0.85 0.75]);
xlim(axes1, [1 60]); % Ajustar el límite del eje X
ylim(axes1, [0.95 1.05]); % Ajustar el límite del eje Y
box(axes1, 'on');
hold(axes1, 'on');
ylabel('Power (kW)', 'FontWeight', 'bold')
xlabel('Time (h)', 'FontWeight', 'bold')

% Modificar la ventana de la figura
set(gcf, 'units', 'normalized');
set(gcf, 'WindowStyle', 'normal');
set(gcf, 'position', [0 0 0.25 0.215]);

% Configurar etiquetas y posiciones del eje X
xTicks = [1 8 16 24 32 40 48 56 60];
xLabels = {'12', '15', '18', '21', '0', '3', '6', '9', '12'};

set(axes1, 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold', ...
    'XColor', [0 0 0], 'XTick', xTicks, 'XTickLabel', xLabels, ...
    'XTickLabelRotation', 0, 'YColor', [0 0 0], 'ZColor', [0 0 0]);

% Ajustar el rango de datos para el gráfico
% Crear un vector de tiempo que mapea los valores de tus datos al rango del eje X
% Aquí se asume que tus datos están en el rango 1 a 24 y deben ajustarse a las etiquetas

% Suponiendo que tus datos están en PDT_total con dimensiones (MC, N)
% Asegúrate de que cada fila de PDT_total se ajuste a los valores del eje X
numPoints = size(PDT_total, 2); % Número de puntos de datos en cada serie

% Graficar los datos
for b = 1:MC
    plot(linspace(1, 24, numPoints), PDT_total(b, :), 'Color', [0.5 0.5 0.5]); % Ajusta x a 1:24
    hold on
end

% Crear el diagrama de caja y bigotes
boxplot(PDT_total', 'Color', [0 0 0], 'BoxStyle', 'filled', 'Symbol', 'w'); % Transponer PDT_total para boxplot
set(gca, 'XTick', xTicks, 'XTickLabel', xLabels); % Asegurarse de que las etiquetas se muestren correctamente

% Ajustar límites del eje Y (si es necesario)
ylim(axes1, [0 max(max(PDT_total)) + 400]);
