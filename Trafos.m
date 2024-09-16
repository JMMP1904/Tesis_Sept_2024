
Ai_mod=[100,150,100,100,100,150,200,50,100,100,100,100,200,100,100,100,150,100,100,100,150,150,600,500,100,100,100,200,200,200,200,100]; %-50MW
At_mod=sum(Ai_mod)*0.8757;  

%Se puede usar este codigo original
Ctrafo_minute=Ai_mod';
for a=1:tiempo_minute*24-1
Ctrafo_minute=[Ctrafo_minute,Ai_mod'];
end