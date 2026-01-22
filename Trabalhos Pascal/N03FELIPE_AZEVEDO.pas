Program N03FELIPE_AZEVEDO;
// Autor: Felipe Fernandes de Azevedo

{ FUP que leia uma série de datas, VALIDAR. O programa só continua após ler uma data válida. 
Assim sendo, mostrar a data lida como abaixo:
Leu 17 para o dia, 8 para o mês e 2010 para o ano, mostrar:
CURITIBA, 17 DE AGOSTO DE 2010.
Usar um vetor  de 12 posições para guardar o extenso dos meses.
O programa deverá, NECESSARIAMENTE, usar os módulos da UNIT tardenoite.pas, ENVIADA, para validar as datas lidas, 
para ler dia, mês e ano do teclado e para encerrar o programa. Após mostrar a data com o extenso do mês, perguntar se quer 
continuar com as opções 1 (SIM), outro número (NÃO) }


USES TARDENOITE;


VAR MESES: ARRAY[1..12] OF STRING[12] =	
		('JANEIRO', 'FEVEREIRO', 'MARÇO', 'ABRIL', 'MAIO', 'JUNHO', 'JULHO', 'AGOSTO', 'SETEMBRO', 'OUTUBRO', 'NOVEMBRO', 'DEZEMBRO');
		D, A, M, RESP: INTEGER;

BEGIN
	REPEAT
		REPEAT
			WRITELN('Digite uma data - (DD/MM/AAAA):');
			LEIA('Dia => ', D);
			LEIA('Mês => ', M);
			LEIA('Ano => ', A);
			CLRSCR;
		UNTIL VALDATAF(D,M,A);
			WRITELN('CURITIBA, ', D, ' DE ', MESES[M], ' DE ', A);
			WRITELN('Deseja continuar? 1-[SIM] QUALQUER NÚMERO-[NÃO]:');
			LEIA('Digite sua opção => ', RESP);
			IF (RESP = 1) THEN
				CLRSCR;	
  UNTIL RESP <> 1;
  	CLRSCR;
  	TERMINE;
END.