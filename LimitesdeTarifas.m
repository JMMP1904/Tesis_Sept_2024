DifDesviTotal=[];
for a=1:nag;
MCA=[];
    for mc=1:MC;
    MCA=[MCA;Simul((mc*nag)-(nag-1)+a-1,:)];
    medMCA=mean(MCA);
    Name=genvarname(['medMCA',num2str(a)]);
    DifDesviMCAmax=(max(MCA)-medMCA);
    DifDesviMCAmin=(medMCA-min(MCA));
    %Name=genvarname(['DifDesviMCA',num2str(a)]);
    %eval([Name,'=DifDesviMCA']);
    end
    %DifDesviTotal=[DifDesviTotal;DifDesviMCA];
    %Grafica de las N simumlaciones junto con la grafica de la banda tarifaria mediante diagrama de caja y bigote
    %axes1 = axes('Parent',figure,'Position',[0.13 0.22 0.85 0.75]);
    axes1 = axes('Parent',figure,'Position',[0.13 0.22 0.85 0.75]);
    xlim(axes1,[1 tiempo_minute]);
    box(axes1,'on');
    hold(axes1,'on');
    ylabel('Potencia [kW]','FontWeight','bold')
    xlabel('Tiempo [h]','FontWeight','bold')
    set(gcf,'units','normalized');
    set(gcf,'WindowStyle','normal');
    set(gcf,'position',[0 0 0.25 0.25]);  
    %prueba=max(max(MCA));%Para definir el límite máximo de la gráfica
    for b=1:MC;
    %plot(MCA(b,:));%,'Color',[0.5 0.5 0.5]
    hold on
    end
    plot(medMCA+DifDesviMCAmax,'MarkerFaceColor',[0 0 0],'Marker','none','LineWidth',1,...
    'LineStyle','-','Color',[0 0.44 0.73]);%Grafica el límite superior de la banda de tarifa [0 0.44 0.73] 
    plot(abs(medMCA-DifDesviMCAmin),'MarkerFaceColor',[0 0 0],'Marker','none','LineWidth',1,...
    'LineStyle','-', 'Color',[0 0.44 0.73]);%Grafica el límite inferior de la banda de tarifa
    %boxplot((MCA),'color',[0 0 0],'boxstyle','filled','symbol','w'); % Diagrama de caja y bigotes
    %axis([1 tiempo 0 300])
    %xlim(axes1,[1 tiempo]);
    %ylim(axes1,[0 max(max(MCA))+50]);%max(max(MCA)) es para definir el límite máximo de la gráfica
    set(axes1,'FontName','Times New Roman','FontSize',14,...
    'XColor',[0 0 0],'XTick',[1 3 6 9 12 15 18 21 24],'XTickLabel',...
    {'12','15','18','21','0','3','6','9','12'},'XTickLabelRotation',0,...
    'YColor',[0 0 0],'ZColor',[0 0 0]);
end
clc
  
