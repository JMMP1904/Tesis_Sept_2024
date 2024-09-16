



%%


axes1 = axes('Parent', figure, ...
    'Position', [0.1 0.2 0.87 0.75]);
xlim(axes1, [1 tiempo]);
box(axes1, 'on');
hold(axes1, 'on');
ylabel('Power (kW)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Time (h)', 'FontName', 'Times New Roman', 'FontSize', 12, 'FontWeight', 'bold');

% Modifica la ventana de la figura
set(gcf, 'units', 'normalized');
set(gcf, 'WindowStyle', 'normal');
set(gcf, 'position', [0 0 0.25 0.215]);
set(axes1, 'FontName', 'Times New Roman', 'FontSize', 12, ...
    'XColor', [0 0 0], 'XTick', linspace(1, tiempo, 10), 'XTickLabel', ...
    arrayfun(@num2str, linspace(0, 24, 10), 'UniformOutput', false), ...
    'XTickLabelRotation', 0, ...
    'YColor', [0 0 0], 'ZColor', [0 0 0]);

% Resto del código...

Eopt_total=[];
Eoptevol1_total=Eoptevol_total';
for a=1:MC
Eopt_total=[Eopt_total;Eoptevol1_total(1+(a-1)*tiempo:tiempo+(a-1)*tiempo)];
end


for b=1:MC;
plot(Emaxevol_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
'LineStyle','-.','Color',[0 0 1]);
hold on
plot(Eopt_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
'LineStyle','-','Color',[0 0 0.8]);
plot(Eminevol_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
'LineStyle','--','Color',[0 0 0.6]);
ylabel('Energía [MWh]')
xlabel('Tiempo [h]')
end
 %Crea la caja de texto
 annotation('textbox',[0.23 0.61 0.1 0.12],...
 'String',{'E_M_A_X'},'LineWidth',1,'FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
 annotation('textbox',[0.70 0.32 0.09 0.12],...
 'String','E_M_I_N','LineWidth',1,'FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
 annotation('textbox',[0.46 0.57 0.09 0.12],...
 'String',{'E_P_O_U'},'LineWidth',1,'FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
%