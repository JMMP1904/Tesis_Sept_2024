%%Grafica PDT original
axes1=axes('Parent',figure,'Position',[0.13 0.22 0.85 0.75]);
xlim(axes1,[1 tiempo]);
ylim(axes1,[0.95 1.05]);
box(axes1,'on');
hold(axes1,'on');
ylabel('Power (kW)')
xlabel('Time (h)')
set(gcf,'units','normalized');
set(gcf,'WindowStyle','normal');
set(gcf,'position',[0 0 0.25 0.215]);

for b=1:MC;
    plot(PDT_total(b,:),'Color',[0.5 0.5 0.5]);
    hold on
end
boxplot((PDT_total),'color',[0 0 0],'boxstyle','filled','symbol','w'); % Diagrama de caja y bigotes
xlim(axes1,[1 tiempo]);
ylim(axes1,[0 max(max(PDT_total))+400])
set(axes1,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
'XColor',[0 0 0],'XTick',[1 3 6 9 12 15 18 21 24],'XTickLabel',...
{'12','15','18','21','0','3','6','9','12'},'XTickLabelRotation',0,...
'YColor',[0 0 0],'ZColor',[0 0 0]);