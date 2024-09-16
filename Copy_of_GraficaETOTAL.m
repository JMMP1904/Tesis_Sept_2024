
axes1=axes('Parent',figure,...
'Position',[0.15 0.2 0.8 0.75]);
xlim(axes1,[1 tiempo]);
box(axes1,'on');
hold(axes1,'on');
ylabel('Power (kW)','FontName','Times New Roman','FontSize',12,'FontWeight','bold')
xlabel('Time (h)','FontName','Times New Roman','FontSize',12,'FontWeight','bold')

% Modifica la ventana de la figura
set(gcf,'units','normalized');
set(gcf,'WindowStyle','normal');
set(gcf,'position',[0 0 0.25 0.215]);
set(axes1,'FontName','Times New Roman','FontSize',12,...
'XColor',[0 0 0],'XTick',[1 3 6 9 12 15 18 21 24],'XTickLabel',...
{'12','15','18','21','0','3','6','9','12'},'XTickLabelRotation',0,...
'YColor',[0 0 0],'ZColor',[0 0 0]);
set(axes1,'FontName','Times New Roman','FontSize',12,...
'YColor',[0 0 0],'YTick',[15 20 25 30 35],'YTickLabel',...
{'25','50','75','100'},'YTickLabelRotation',0,...
'YColor',[0 0 0],'ZColor',[0 0 0]);


Eopt_total=[];
Eoptevol1_total=Eoptevol_total';
for a=1:MC
Eopt_total=[Eopt_total;Eoptevol1_total(1+(a-1)*tiempo:tiempo+(a-1)*tiempo)];
end


for b=1:MC;
plot(Emaxevol_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
'LineStyle','-','Color',[0 0 1]);
hold on
plot(Eminevol_total(b,:),'MarkerFaceColor',[0 0 0],'LineWidth',1,...
'LineStyle','-','Color',[1 0 0]);
ylabel('SOC [%]','FontWeight','bold')
xlabel('Tiempo [h]','FontWeight','bold')
end



% Create ellipse
annotation('ellipse',...
    [0.27 0.24 0.03 0.05],...
    'FaceColor',[0 0 0]);

% Create ellipse
annotation('ellipse',...
    [0.80 0.77 0.03 0.05],...
    'FaceColor',[0 0 0]);


%Crea la caja de texto
 annotation('textbox',[0.24 0.29 0.1 0.12],...
 'String',{'h_a_r_r'},'LineStyle','none','FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
 annotation('textbox',[0.78 0.82 0.09 0.12],...
 'String','h_d_e_p', 'LineStyle','none','FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
 annotation('textbox',[0.001 0.26 0.09 0.12],...
 'String',{'SOC_l_l_e_g_a_d_a'},'LineStyle','none','FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');
 annotation('textbox',[0.00001 0.79 0.09 0.12],...
 'String',{'SOC_d_e_s_e_a_d_o'},'LineStyle','none','FontWeight','bold','FontName','Times New Roman','FitBoxToText','off');

%Crea Línea
annotation('line',[0.6 0.15],...
    [0.799 0.799],'LineStyle','--');

