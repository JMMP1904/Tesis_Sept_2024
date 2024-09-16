
% SUMA DE LOS PAGOS DE CADA AGREGADOR
PagoPOU_Total=[];
for a=1:nag;
Pago=[];
    for mc=1:MC;
    Pago=[Pago;Simul((mc*nag)-(nag-1)+a-1,:)];
    end
    for mc=1:MC;
    PagoPOU1=[];
    for b=1:tiempo
    if (mean(Pago(:,b))-DifDesviTotal(a,b))<=(Pago(mc,b))<=(mean(Pago(:,b))+DifDesviTotal(a,b))
    PagoPOU=sum((Pago(mc,b))*Pr); 
    elseif (Pago(mc,b))>=(mean(Pago(:,b))+DifDesviTotal(a,b))
    PagoPOU=sum(mean(Pago(:,b))*Pr)+sum((abs((Pago(mc,b))-(abs(mean(Pago(:,b))+DifDesviTotal(a,b)))))*(Pp-Pr)); 
    end

    if (Pago(mc,b))<=(mean(Pago(:,b))-DifDesviTotal(a,b))
    PagoPOU=sum(mean(Pago(:,b))*Pr)+sum((abs((Pago(mc,b))-(abs(mean(Pago(:,b))+DifDesviTotal(a,b)))))*(Pp-Pr));
    end
    PagoPOU1=sum([PagoPOU1;PagoPOU]);
    end
    PagoPOU_Total=[PagoPOU_Total;PagoPOU1];
    end
end

POU_Total=[];
for mc=1:MC;
POU_Total1=[];
    for a=1:nag;
    POU_Total1=[POU_Total1;PagoPOU_Total((a*MC)-(MC)+mc)];
    end
POU_Total=[POU_Total;sum(POU_Total1)];
end

% PAGO A NIVEL DEL DSO
POU_PDTTotal=[];
    for mc=1:MC;
    POU_PDT1=[];
    DifDesviPDT=(max(PDT_total)-min(PDT_total))/2;
    for b=1:tiempo
    if (mean(PDT_total(:,b))-DifDesviPDT(1,b))<=(PDT_total(mc,b))<=(mean(PDT_total(:,b))+DifDesviTotal(1,b))
    POU_PDT=sum((PDT_total(mc,b))*Pr); 
    elseif (PDT_total(mc,b))>=(mean(PDT_total(:,b))+DifDesviPDT(1,b))
    POU_PDT=sum(mean(PDT_total(:,b))*Pr)+sum((abs((PDT_total(mc,b))-(abs(mean(PDT_total(:,b))+DifDesviPDT(1,b)))))*(Pp-Pr)); 
    end

    if (PDT_total(mc,b))<=(mean(PDT_total(:,b))-DifDesviPDT(1,b))
    POU_PDT=sum(mean(PDT_total(:,b))*Pr)+sum((abs((PDT_total(mc,b))-(abs(mean(PDT_total(:,b))+DifDesviPDT(1,b)))))*(Pp-Pr));
    end
    POU_PDT1=sum([POU_PDT1;POU_PDT]);
    end
    POU_PDTTotal=[POU_PDTTotal;POU_PDT1];
    end
