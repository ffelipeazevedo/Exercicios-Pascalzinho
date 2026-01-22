Program NO1FELIPE_AZEVEDO;
//AUTOR: FELIPE FERNANDES DE AZEVEDO

{FUP pegue do sistema uma data atual (DIAAT, MESAT e ANOAT). 
Após, leia uma data de nascimento (DIANA, MESNA e ANONA). 
Calcular e mostrar a idade em anos, meses e dias (ex.: 18 anos, 11 meses e 3 dias).
}


uses crt;

var diaat, mesat, anoat, s, 
		d, m , a, diamx,
		dcal, mcal, acal,
		dmesatr, mesatr: integer;
		validar: boolean;

Begin
    getdate(anoat, mesat, diaat, s);
    writeln('Digite a data do seu nascimento - (dd/mm/aaaa):');
    write('Dia => ');
    readln(d);
    write('Mês => ');
		readln(m);
    write('Ano => ');
    readln(a);
    clrscr;
    //Validaçao da data
    validar:= true;
    if (a > anoat) then
    	validar:= false
  	else	
  	if (m < 1) or (m > 12) then
  		validar:= false
  	else
  	begin
    	diamx:= 31;
			if (m = 4) or (m = 6) or (m = 9) or (m = 11) then 
				diamx:= 30;
			if (m = 2) then
				begin
					diamx:= 28;
					if (a mod 4) = 0 then
						diamx:= 29;
				end;
			if (d < 1) or (d > diamx) then
				validar:= false;			
		end;
		//Calculo da Idade 
		dcal:= diaat - d;
		mcal:= mesat - m;
		acal:= anoat - a;
		//Calculo do mes
	  if (mcal < 0) then
	  	begin
	  		mcal:= mcal + 12;                          
	  		acal:= acal - 1
	  	end;
	  //Calculo de dias
		if (dcal < 0) then
		 	begin
				if (mesatr = 1) then
					mesatr:= mesatr + 11
				else
					mesatr:= mesatr - 1;
					
			  if (mesatr = 2) then
			  	begin
			  		dmesatr:= 28;
			  		if (anoat mod 4) = 0 then
			  		dmesatr:= 29;
			  	end;
			  if (mesatr = 4) or (mesatr = 6) or (mesatr = 9) or (mesatr = 11) then
	    		dmesatr:= 30
	    	else
	    		dmesatr:= 31;
    	dcal:= dcal + (dmesatr - 1);
      end;	  		
		if validar then
			begin
				writeln('Você nasceu em => ',d, '/' ,m, '/',a);
				writeln('Data atual => ', diaat,'/', mesat,'/', anoat);
				writeln('Idade atual => ',acal, ' anos, ', mcal,' meses e ', dcal,' dias');
				writeln();
				writeln('Digite enter para encerrar');
				readln();
			end		
		else 
			writeln('Data inválida!');
			writeln();
			writeln('Digite enter para encerrar');
			readln();
End.