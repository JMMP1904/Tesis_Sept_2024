

%%
% Crear figura y ejes
axes1 = axes('Parent', figure, ...
    'Position', [0.1 0.2 0.87 0.75]);

% Establecer límites y propiedades de los ejes
xlim(axes1, [1 tiempo]);
box(axes1, 'on');
hold(axes1, 'on');
ylabel('Power (kW)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (h)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold');

% Modificar la ventana de la figura
set(gcf, 'units', 'normalized');
set(gcf, 'WindowStyle', 'normal');
set(gcf, 'position', [0 0 0.25 0.215]);

% Establecer propiedades de los ejes, ajustar etiquetas x
set(axes1, 'FontName', 'Times New Roman', 'FontSize', 12, ...
    'XColor', [0 0 0], 'XTick', [1 3 6 9 12 15 18 21 24], 'XTickLabel', ...
    {'12', '15', '18', '21', '0', '3', '6', '9', '12'}, ...
    'XTickLabelRotation', 0, ...
    'YColor', [0 0 0], 'ZColor', [0 0 0]);

% Preparar datos
Eopt_total = [];
Eoptevol1_total = Eoptevol_total';
for a = 1:MC
    Eopt_total = [Eopt_total; Eoptevol1_total(1+(a-1)*tiempo:tiempo+(a-1)*tiempo)];
end

% Graficar datos
for b = 1:MC
    plot(Emaxevol_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
        'LineStyle', '-.', 'Color', [0 0 1]);
    hold on
    plot(Eopt_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
        'LineStyle', '-', 'Color', [0 0 0.8]);
    plot(Eminevol_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
        'LineStyle', '--', 'Color', [0 0 0.6]);
    ylabel('Energía [MWh]');
    xlabel('Tiempo [h]');
end
