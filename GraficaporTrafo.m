for b = 1:nag
    % Crear figura y ejes
    figure;
    axes1 = axes('Parent', gcf, 'Position', [0.13 0.22 0.85 0.75]);
    hold(axes1, 'on');
    
    % Configurar límites del eje X
    xlim(axes1, [1 24]);  % Limitar el rango del eje X de 1 a 24
    
    % Configurar propiedades de los ejes
    box(axes1, 'on');
    ylabel('Power (kW)');
    xlabel('Time (h)');
    
    % Configurar la ventana de la figura
    set(gcf, 'units', 'normalized');
    set(gcf, 'WindowStyle', 'normal');
    set(gcf, 'position', [0 0 0.25 0.215]);
    
    % Configurar las etiquetas del eje X
    xTicks = [1 4 7 10 13 16 19 22];  % Posiciones de ticks para 8 intervalos
    xLabels = {'12', '15', '18', '21', '0', '3', '6', '9'};  % Etiquetas correspondientes
    set(axes1, 'XTick', xTicks, 'XTickLabel', xLabels);
    
    % Ajustar los datos para el ciclo horario
    nDataPoints = size(PprefLimTrafo, 2);
    xData = linspace(1, 24, nDataPoints);  % Generar datos x para alinear con los ticks

    % Graficar los datos
    plot(xData, PprefLimTrafo(b, :) + Lbi12(b, :), 'Color', [0.5 0.5 0.5]);
    plot(xData, Lbi12(b, :), 'Color', [0.5 0.5 0.5]);
end



%% Código Original
% for b=1:nag;
% axes1=axes('Parent',figure,'Position',[0.13 0.22 0.85 0.75]);
% xlim(axes1,[1 tiempo]);
% box(axes1,'on');
% ylabel('Power (kW)')
% xlabel('Time (h)')
% set(gcf,'units','normalized');
% set(gcf,'WindowStyle','normal');
% set(gcf,'position',[0 0 0.25 0.215]);
% plot(PprefLimTrafo(b,:)+Lbi12(b,:),'Color',[0.5 0.5 0.5]);
% hold on
% plot(Lbi12(b,:),'Color',[0.5 0.5 0.5]);
% end