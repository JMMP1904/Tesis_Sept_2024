
% Pago mediante la tarifa POU
CTT=[];
for b=1:MC
CT1=[];
for a=1:tiempo
if (medMCA(1,a)-DifDesviMCA4(1,a))<=(MCA(b,a))<=(medMCA(1,a)+DifDesviMCA4(1,a))
    CT=sum((MCA(b,a))*Pr); 
elseif (MCA(b,a))>=(medMCA(1,a)+DifDesviMCA4(1,a))
    CT=sum(medMCA(1,a)*Pr)+sum((abs(MCA(b,a)-(abs(medMCA(1,a)+DifDesviMCA4(1,a)))))*(Pp-Pr)); 
end

if (MCA(b,a))<=(medMCA(1,a)-DifDesviMCA4(1,a))
    CT=sum(medMCA(1,a)*Pr)+sum((abs(MCA(b,a)-(abs(medMCA(1,a)+DifDesviMCA4(1,a)))))*(Pp-Pr));
end
CT1=sum([CT1;CT]);
end
CTT=[CTT;CT1];
end

% Crea Histograma para la tarifa POU
axes1 = axes('Parent',figure,'Position',[0.11 0.22 0.86 0.75]);
set(gcf,'units','normalized');
set(gcf,'WindowStyle','normal');
set(gcf,'position',[0 0 0.25 0.215]);
histogram(CTT,57,'FaceColor',[0.8 0.8 0.8],'LineWidth',1);
set(axes1,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
'XColor',[0 0 0],...
'YColor',[0 0 0],'ZColor',[0 0 0]);
xlim(axes1,[155 180])
ylabel('Frecuency')
xlabel('Aggregator payment (U$S)')

 % Crea Histograma para la tarifa TOU
 axes1 = axes('Parent',figure,'Position',[0.11 0.22 0.86 0.75]);
 set(gcf,'units','normalized');
 set(gcf,'WindowStyle','normal');
 set(gcf,'position',[0 0 0.25 0.215]); 
 histogram(CTTOU,25,'FaceColor',[0.8 0.8 0.8],'LineWidth',1);
 set(axes1,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
 'XColor',[0 0 0],...
 'YColor',[0 0 0],'ZColor',[0 0 0]);
 xlim(axes1,[155 180])
 ylabel('Frecuency')
 xlabel('Aggregator payment (U$S)')















