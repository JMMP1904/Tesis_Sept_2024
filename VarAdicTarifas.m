% Pago del agregador para los 1000 casos bajo la tarifa TOU
CTOU=[Ppref(4,:)*C_mod(hour1:hour2)'];
CTTOU=[CTTOU,CTOU];

% Para el calculo de la tarifa POU
Simul1=[Simul1;PprefLimTrafo(1,:)];
M=mean(Simul1);
    for a=1:nag;
        Simul=[Simul;PprefLimTrafo(a,:)];
    end
    
% Para calcular la gráfica de Emin y Emax
Emaxevol_total=[Emaxevol_total;sum(Emax_evol1)/1000];
Eminevol_total=[Eminevol_total;sum(Emin_evol1)/1000];
Eoptevol_total=[Eoptevol_total;((A1(1:tiempo_minute,1:tiempo_minute)*(sum(PprefLimTrafo)')/(delta_t_inv_minute))+(sum(ESOC_evol)'))/1000];

% Guarda y grafica los MC perfiles del transformador de distribución primaria    
PDT_total=[PDT_total;sum(PprefLimTrafo)];

