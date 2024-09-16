VAR=3;         
nag=32;        
nPEV=VAR*150;
%Número de EV por agregador
nPEVag=VAR*[4 4 5 2 2 8 8 2 2 2 2 2 5 2 2 2 4 4 4 4 4 4 18 18 2 2 2 5 8 6 9 2];
%Acumulado de EV 
cPEV=zeros(nag+1,1);
for a=1:nag
cPEV(a+1)=sum(nPEVag(1:a)); 
end