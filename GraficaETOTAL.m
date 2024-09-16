%% 

% Definir el eje y la figura
axes1 = axes('Parent', figure, 'Position', [0.1 0.2 0.87 0.75]);

% Definir límites del eje X
xlim(axes1, [1, 60]);
box(axes1, 'on');
hold(axes1, 'on');
ylabel('Power (kW)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold')
xlabel('Time (h)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold')

% Modifica la ventana de la figura
set(gcf, 'units', 'normalized');
set(gcf, 'WindowStyle', 'normal');
set(gcf, 'position', [0 0 0.25 0.215]);

% Configurar etiquetas y posiciones del eje X
xTicks = [0, 8, 16, 24, 32, 40, 48, 54, 60];
xLabels = {'12', '15', '18', '21', '0', '3', '6', '9', '12'};

% Configurar propiedades del eje X
set(axes1, 'FontName', 'Times New Roman', 'FontSize', 12, ...
    'XColor', [0 0 0], 'XTick', xTicks, 'XTickLabel', xLabels, ...
    'XTickLabelRotation', 0, 'YColor', [0 0 0], 'ZColor', [0 0 0]);

Eopt_total = [];
Eoptevol1_total = Eoptevol_total';
for a = 1:MC
    Eopt_total = [Eopt_total; Eoptevol1_total(1 + (a-1) * tiempo_minute:tiempo_minute + (a-1) * tiempo_minute)];
end

% Se ajustan los datos para que se grafiquen dentro del rango deseado
% Suponiendo que el tiempo es un número entero y que los datos tienen la misma cantidad de puntos
time_indices = linspace(1, 24, size(Emaxevol_total, 2));

for b = 1:MC
    plot(time_indices, Emaxevol_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
        'LineStyle', '-.', 'Color', [0 0 1]);
    hold on
    plot(time_indices, Eopt_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
        'LineStyle', '-', 'Color', [0 0 0.8]);
    plot(time_indices, Eminevol_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
        'LineStyle', '--', 'Color', [0 0 0.6]);
    ylabel('Energía [MWh]')
    xlabel('Tiempo [h]')
end

% Crear las cajas de texto
annotation('textbox', [0.23 0.61 0.1 0.12], ...
    'String', {'E_M_A_X'}, 'LineWidth', 1, 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FitBoxToText', 'off');
annotation('textbox', [0.70 0.32 0.09 0.12], ...
    'String', 'E_M_I_N', 'LineWidth', 1, 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FitBoxToText', 'off');
annotation('textbox', [0.46 0.57 0.09 0.12], ...
    'String', {'E_P_O_U'}, 'LineWidth', 1, 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FitBoxToText', 'off');



%% Sirve pero no es el mejor
% % Definir el eje y la figura
% axes1 = axes('Parent', figure, 'Position', [0.1 0.2 0.87 0.75]);
% 
% % Definir límites del eje X
% xlim(axes1, [1 tiempo]);
% box(axes1, 'on');
% hold(axes1, 'on');
% ylabel('Power (kW)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold')
% xlabel('Time (h)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold')
% 
% % Modifica la ventana de la figura
% set(gcf, 'units', 'normalized');
% set(gcf, 'WindowStyle', 'normal');
% set(gcf, 'position', [0 0 0.25 0.215]);
% 
% % Calcular las etiquetas del eje X basadas en 'tiempo'
% xTicks = linspace(1, tiempo, min(tiempo, 9));
% xLabels = mod(xTicks + 11, 24); % Ajustar las etiquetas para el formato deseado
% 
% % Configurar propiedades del eje X
% set(axes1, 'FontName', 'Times New Roman', 'FontSize', 12, ...
%     'XColor', [0 0 0], 'XTick', xTicks, 'XTickLabel', cellstr(num2str(xLabels')), ...
%     'XTickLabelRotation', 0, 'YColor', [0 0 0], 'ZColor', [0 0 0]);
% 
% Eopt_total = [];
% Eoptevol1_total = Eoptevol_total';
% for a = 1:MC
%     Eopt_total = [Eopt_total; Eoptevol1_total(1 + (a-1) * tiempo:tiempo + (a-1) * tiempo)];
% end
% 
% for b = 1:MC
%     plot(Emaxevol_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
%         'LineStyle', '-.', 'Color', [0 0 1]);
%     hold on
%     plot(Eopt_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
%         'LineStyle', '-', 'Color', [0 0 0.8]);
%     plot(Eminevol_total(b, :), 'MarkerFaceColor', [0 0 0], 'LineWidth', 1, ...
%         'LineStyle', '--', 'Color', [0 0 0.6]);
%     ylabel('Energía [MWh]')
%     xlabel('Tiempo [h]')
% end
% 
% % Crear las cajas de texto
% annotation('textbox', [0.23 0.61 0.1 0.12], ...
%     'String', {'E_M_A_X'}, 'LineWidth', 1, 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FitBoxToText', 'off');
% annotation('textbox', [0.70 0.32 0.09 0.12], ...
%     'String', 'E_M_I_N', 'LineWidth', 1, 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FitBoxToText', 'off');
% annotation('textbox', [0.46 0.57 0.09 0.12], ...
%     'String', {'E_P_O_U'}, 'LineWidth', 1, 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FitBoxToText', 'off');
% 
% 


%% CODIGO ORIGINAL
% %
% axes1=axes('Parent',figure,...
% 'Position',[0.1 0.2 0.87 0.75]);
% 
% xlim(axes1,[1 tiempo]);
% box(axes1,'on');
% hold(axes1,'on');
% ylabel('Power (kW)','FontName','Times New Roman','FontSize',12,'FontWeight','bold')
% xlabel('Time (h)','FontName','Times New Roman','FontSize',12,'FontWeight','bold')
% 
% % Modifica la ventana de la figura
% set(gcf,'units','normalized');
% set(gcf,'WindowStyle','normal');
% set(gcf,'position',[0 0 0.25 0.215]);
% set(axes1,'FontName','Times New Roman','FontSize',12,...
% 'XColor',[0 0 0],'XTick',[1 3 6 9 12 15 18 21 24],'XTickLabel',...
% {'12','15','18','21','0','3','6','9','12'},'XTickLabelRotation',0,...
% 'YColor',[0 0 0],'ZColor',[0 0 0]);
% 
% Eopt_total=[];
% Eoptevol1_total=Eoptevol_total';
% for a=1:MC
% Eopt_total=[Eopt_total;Eoptevol1_total(1+(a-1)*tiempo:tiempo+(a-1)*tiempo)];
% end
% 
% 
% for b=1:MC;
% plot(Emaxevol_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
% 'LineStyle','-.','Color',[0 0 1]);
% hold on
% plot(Eopt_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
% 'LineStyle','-','Color',[0 0 0.8]);
% plot(Eminevol_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
% 'LineStyle','--','Color',[0 0 0.6]);
% ylabel('Energía [MWh]')
% xlabel('Tiempo [h]')
% end
%  %Crea la caja de texto
%  annotation('textbox',[0.23 0.61 0.1 0.12],...
%  'String',{'E_M_A_X'},'LineWidth',1,'FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
%  annotation('textbox',[0.70 0.32 0.09 0.12],...
%  'String','E_M_I_N','LineWidth',1,'FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
%  annotation('textbox',[0.46 0.57 0.09 0.12],...
%  'String',{'E_P_O_U'},'LineWidth',1,'FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
% %