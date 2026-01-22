Program N07FELIPE_AZEVEDO;
// Autor: Felipe Fernandes de Azevedo                  
{FUP que mostre todos os campos (veja LISTAINDDIR.PAS, LISTANASCI.PAS) dos registros de CAND.IND:
1 – Em ordem de turma e alfabética dentro da turma; (lista de porta da turma)
2 – Em ordem de turma e de número de inscrição dentro da turma. (lista de chamada da turma)
		No cabeçalho (veja LISTAINDDIR.PAS, LISTANASCI.PAS) acrescentar o número da turma conforme abaixo:

   ==========> TURMA: nn <==========
   ORD  NUM N O M E                             ===C P F=== NASCIMENTO(ETC....)}



USES TARDENOITE;

VAR ARQ:FILE OF REGIS;
    REG:REGIS;
    VET:VETOR;
    TURMA:STRING[2];
    NUMS:STRING[4];    
    A,B,IND,PFI,TOTAL,OP,CARANT,CONTL:INTEGER;
    
Begin
  ASSIGN(ARQ,'CAND.IND');
  RESET(ARQ);
  
	REPEAT
		LEIA('[1] - ALFABÉTICA | [2] - INCRIÇÃO',OP);
		IF(OP<1) OR (OP>2) THEN
	  WRITE('ILEGAL');
	UNTIL (OP>0) AND (OP<3);
	
// VETOR
	PFI:=0;
	IND:=0;
	WHILE (NOT EOF(ARQ)) DO
		BEGIN
			READ(ARQ,REG);
			IND:=IND+1;
			VET[IND].PF:=PFI;
			STR(REG.TUR:2,TURMA);
			IF(OP=1)THEN
				BEGIN
					VET[IND].CC:=TURMA+REG.NOME;
				END;
			IF(OP=2)THEN
				BEGIN
				  STR(REG.NUM:4,NUMS);
					VET[IND].CC:=TURMA+NUMS;
				END;
			PFI:=PFI+1;				 
		END;		
// ORDENAR VETOR
  WRITELN('LIDOS=',IND:5,' REGISTROS');
  FOR A:=1 TO 20 DO
  TOTAL:=IND;
  WRITELN('ORDENANDO, AGUARDE');
	ORDEM(VET,TOTAL); 
  WRITELN('ENTER PARA CONTINUAR');
  READLN;
  CONTL:=0;
	FOR B:=1 TO TOTAL DO
	 BEGIN
	  SEEK(ARQ,VET[B].PF);
		READ(ARQ,REG);
// CABEÇALHO
    IF((CONTL MOD 25=0) OR (CARANT<>REG.TUR)) THEN
    BEGIN
      READLN;
      CLRSCR;
			WRITELN;
      WRITELN('  ==========> TURMA: ', REG.TUR:2, ' <==========');
  		WRITELN('  ORD NUM  N O M E                             ===C P F=== NASCIMENTO  CS  N1  N2  N3  N4  N5  N6  SO   CG  CC CV FA TU');
      CARANT:=REG.TUR;
			CONTL:=0;
     END;
		WRITE(B:5,REG.NUM:5,' ',REG.NOME,' ',REG.CPF,' ',REG.DATA.DIA,'/',REG.DATA.MES,'/',REG.DATA.ANO,REG.CAR:3);
		FOR A:=1 TO 6 DO
		 WRITE(REG.NOTAS[A]:4);
		WRITELN(REG.SOM:5,REG.CLG:5,REG.CLC:4,REG.CCL:3,REG.FALTA:3,REG.TUR:3);
		CONTL:=CONTL+1;
		CARANT:=REG.TUR;
	 END;	
	CLOSE(ARQ);
	TERMINE;  
End.