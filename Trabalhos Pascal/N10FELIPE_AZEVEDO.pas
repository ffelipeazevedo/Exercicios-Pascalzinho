Program N10FELIPE_AZEVEDO;
{ Feito por: Felipe Fernandes de Azevedo
  Trabalho 10 }

USES TARDENOITE;

CONST CARGOS: ARRAY[1..12] OF STRING[22] = (
    'ENGANADOR DE CHEFE    ', 'ENROLADOR DE TRABALHO ', 'PENSADOR              ',
    'ANALISTA DE SISTEMAS  ', 'DEGUSTADOR DE CERVEJA ', 'TÉCNICO EM REDES      ',
    'CONTADOR DE ESTORIAS  ', 'SAI DA AULA ANTES     ', 'JOGADOR DE PING PONG  ',
    'SEGURANÇA DE BANHEIRO ', 'GESTOR DE BORBOLETAS  ', 'LEVA E TRAZ CONVERSA  '
  );

VAR
  ARQ: FILE OF REGIS;
  REG: REGIS;
  VET: VETOR;
  I, J, IND, OP, PFI, CONTLIN, ANTERIOR: INTEGER;
	CLCSTR,CLGSTR:STRING[4];
	CCLSTR,CARSTR:STRING[2];

BEGIN   
  CORTELA(0);
  TEXTCOLOR(15);
  ASSIGN(ARQ, 'CAND.IND');
  RESET(ARQ);

  REPEAT
    WRITELN('ORDENAR POR:');
    WRITELN;
    WRITELN('1 - Candidatos Classificados por Ordem Alfabética');
    WRITELN('2 - Classificação Geral por Cargo');
    WRITELN('3 - Classificação Geral');
    WRITELN;
    LEIA('Selecione uma opção ', OP);
    IF (OP < 1) OR (OP > 4) THEN
      WRITELN('Selecione uma opção válida');
  UNTIL (OP >= 1) AND (OP <= 3);

  PFI:= 0;
  IND:= 0;
  WHILE NOT EOF(ARQ) DO
  BEGIN
    READ(ARQ, REG);
    
    IF (OP = 1) AND (REG.CCL = 0) THEN
	    BEGIN
	      PFI:= PFI + 1;
	    END
    ELSE
	    BEGIN
	      IND:= IND + 1;
	      VET[IND].PF:= PFI;	
	      IF OP = 1 THEN
		      BEGIN
		        STR(REG.CCL:2, CCLSTR);
		        VET[IND].CC:= CCLSTR + REG.NOME;
		      END
	      ELSE IF OP = 2 THEN
		      BEGIN
		        STR(REG.CAR:2, CARSTR);
		        STR(REG.CLC:3, CLCSTR);
		        VET[IND].CC:= CARSTR + CLCSTR;
		      END
	      ELSE IF OP = 3 THEN
		      BEGIN
		        STR(REG.CLG:4, CLGSTR);
		        VET[IND].CC:= CLGSTR;
		      END;
						
	      PFI:= PFI + 1;
	    END;
  END;

  WRITELN('Aguarde...');
  ORDEM(VET, IND);
  CONTLIN:= 0;
  ANTERIOR:= -1;

  IF OP = 1 THEN
	  BEGIN
	    FOR I := 1 TO IND DO
	    BEGIN
	      SEEK(ARQ, VET[I].PF);
	      READ(ARQ, REG);
	      IF REG.CCL <> 0 THEN
	      BEGIN
	        IF (REG.CAR <> ANTERIOR) THEN
	        BEGIN
	          IF CONTLIN > 0 THEN
	          BEGIN
	            READLN;
	            CLRSCR;
	          END;
	
	          WRITELN('  CLASSIFICADOS DO CURSO: ', CARGOS[REG.CAR]);
	          WRITELN('  ORD  NUM    N O M E                          NASCIMENTO  CAR');
	          CONTLIN:= 0;
	          ANTERIOR:= REG.CAR;
	        END;
	
	        CONTLIN:= CONTLIN + 1;	
	        WRITELN(CONTLIN:5, REG.NUM:5, ' ', REG.NOME, ' ',
	                REG.DATA.DIA:2, '/', REG.DATA.MES:2, '/', REG.DATA.ANO, ' ', REG.CAR:3);
	      END;
	    END;
	  END
  ELSE IF OP = 2 THEN
	  BEGIN
	    FOR I := 1 TO IND DO
	    BEGIN
	      SEEK(ARQ, VET[I].PF);
	      READ(ARQ, REG);
	      IF (CONTLIN MOD 25 = 0) OR (REG.CAR <> ANTERIOR) THEN
		      BEGIN
		        IF I > 1 THEN
			        BEGIN
			          READLN;
			          CLRSCR;
			        END;
		        WRITELN;
		        WRITELN('  CURSO: ', CARGOS[REG.CAR]);
		        WRITE('  ORD  NUM N O M E                             ');
		        WRITELN(' SOMA  N4  N5  N3  N2  N6  N1   NASCIMENTO  CAR OBSERVAÇÃO');
		        CONTLIN:= 0;
		        ANTERIOR:= REG.CAR;
		      END;
					
	      WRITE(I:5, REG.NUM:5, ' ', REG.NOME:35, ' ', REG.SOM:5);
	      WRITE(REG.NOTAS[4]:4, REG.NOTAS[5]:4, REG.NOTAS[3]:4,
	            REG.NOTAS[2]:4, REG.NOTAS[6]:4, REG.NOTAS[1]:4);
	      WRITE('   ', REG.DATA.DIA:2, '/', REG.DATA.MES:2, '/', REG.DATA.ANO, ' ', REG.CAR:3, '  ');
	
	      IF REG.CCL > 0 THEN
	        WRITE('CLAS-CAR:', REG.CCL:2);
	
	      IF REG.FALTA = 1 THEN
	        WRITELN(' *FALTOU*')
	      ELSE
	        WRITELN;
	
	      CONTLIN:= CONTLIN + 1;
	    END;
	  END
  ELSE IF OP = 3 THEN
	  BEGIN
	    CONTLIN:= 0;
	
	    FOR I := 1 TO IND DO
	    BEGIN
	      SEEK(ARQ, VET[I].PF);
	      READ(ARQ, REG);	
	      IF (CONTLIN MOD 25 = 0) THEN
		      BEGIN
		        IF I > 1 THEN
			        BEGIN
			          READLN;
			          CLRSCR;
			        END;		
		        WRITELN;
		        WRITELN('  RELAÇÃO ORDEM DE CLASSIFICAÇÃO GERAL');
		        WRITE('  ORD  NUM N O M E                             ');
		        WRITELN(' SOMA  N4  N5  N3  N2  N6  N1   NASCIMENTO  CAR OBSERVAÇÃO');
		        CONTLIN := 0;
		      END;
	
	      WRITE(I:5, REG.NUM:5, ' ', REG.NOME:35, ' ', REG.SOM:5);
	      WRITE(REG.NOTAS[4]:4, REG.NOTAS[5]:4, REG.NOTAS[3]:4,
	            REG.NOTAS[2]:4, REG.NOTAS[6]:4, REG.NOTAS[1]:4);
	      WRITE('   ', REG.DATA.DIA:2, '/', REG.DATA.MES:2, '/', REG.DATA.ANO, ' ', REG.CAR:3);
	      IF (REG.CCL <> 0) AND (REG.FALTA <> 1) THEN
	        WRITE('  CLAS-CAR:', REG.CCL);
	      IF REG.FALTA = 1 THEN
	        WRITELN('   *FALTOU*')
	      ELSE
	        WRITELN;
	
	      CONTLIN:= CONTLIN + 1;
	    END;
	  END;

  CLOSE(ARQ);
  WRITELN;
  TERMINE;
END.

