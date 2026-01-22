Program N08FELIPE_AZEVEDO;
// Feito por: Felipe Fernandes de Azevedo

{FUP atualize os campos das 6 notas e o campo soma das notas dos registros do arquivo CAND.IND, dos candidatos presentes. 
Antes, executar o programa MARCAFALTAS.PAS, (atualiza o campo “.falta” com 1) enviado. 
Para atualizar as notas, execute o programa CORPRO.PAS, que irá gerar o arquivo NOTAS.TXT a partir do arquivo “PROVA.TXT”. 
O TRABALHO 08 deverá antes de encerrar, mostrar apenas as médias das 6 disciplinas, CONFORME ABAIXO:

DISCIPLINA                         MEDIA
L.E.M.                             43.27
INFORMATICA                        58.12 
......                                            ...... 
}



USES TARDENOITE;

CONST
  DISCIP:ARRAY[1..6] OF STRING[20] =
  ('L.E.M               ',
   'MATEMÁTICA          ',
   'LÓGICA              ',
   'CONHECIMENTO ESPEC. ',
   'INFORMÁTICA         ',
   'ATUALIDADES         ');

VAR
  ARQ: FILE OF REGIS;
  ARQNOTA: TEXT;
  REG: REGIS;
  VET: VETOR;
  A, LOC, POSINI, B, ERRO: INTEGER;
  ACUM: ARRAY[1..6] OF INTEGER;
  CODIGO: STRING[4];
  LINHANOTA: ARRAY[1..6] OF STRING[4];
  NUMVAL, TOTALNOTAS: INTEGER;
  CHAVE: STRING[4];
  TAM: INTEGER;
  TT: INTEGER;

BEGIN
  ASSIGN(ARQ, 'CAND.IND');
  ASSIGN(ARQNOTA, 'NOTAS.TXT');
  RESET(ARQ);
  RESET(ARQNOTA);
  
  FOR A:= 1 TO 6 DO
    ACUM[A]:= 0;
  
  WHILE NOT EOF(ARQ) DO
  BEGIN
    READ(ARQ, REG);
    A:= A + 1;
    VET[A].PF:= POSINI;
    STR(REG.NUM, CHAVE);
    TAM:= LENGTH(CHAVE);
    FOR B:= 1 TO 4 - TAM DO
      INSERT('0', CHAVE, 1);
    VET[A].CC:= CHAVE;
    POSINI:= POSINI + 1;
  END;
  
  WRITELN('PROCESSANDO MÉDIAS, AGUARDE...');
  ORDEM(VET, A);
  
	//LER NOTAS.TXT E ATUALIZAR CAND.IND
  WHILE NOT EOF(ARQNOTA) DO
  BEGIN
    READLN(ARQNOTA, CODIGO,LINHANOTA[1], LINHANOTA[2], LINHANOTA[3],  LINHANOTA[4], LINHANOTA[5], LINHANOTA[6]);
    TAM:= LENGTH(CODIGO);
    FOR B:= 1 TO 4 - TAM DO
      INSERT('0', CODIGO, 1);
    PEBIN1(VET, CODIGO, A, LOC);
    IF (LOC < 1) OR (LOC > A) THEN
      CONTINUE;
    TT:= TT + 1;

    SEEK(ARQ, VET[LOC].PF);
    READ(ARQ, REG);

    TOTALNOTAS:= 0;
    FOR B:= 1 TO 6 DO
    BEGIN
      VAL(LINHANOTA[B], NUMVAL, ERRO);
      IF ERRO <> 0 THEN
        NUMVAL:= 0;
      REG.NOTAS[B]:= NUMVAL;
      ACUM[B]:= ACUM[B] + NUMVAL;
      TOTALNOTAS:= TOTALNOTAS + NUMVAL;
    END;
    
    REG.SOM := TOTALNOTAS;
    SEEK(ARQ, VET[LOC].PF);
    WRITE(ARQ, REG);
  END;

  CLOSE(ARQNOTA);
  CLOSE(ARQ);
  
  CLRSCR;
  WRITELN;
  WRITELN('==============================================');
  WRITELN('                 MÉDIAS GERAIS                ');
  WRITELN('==============================================');
  WRITELN;
  WRITELN('DISCIPLINA', 'MÉDIA':35);
  WRITELN;

  IF TT > 0 THEN
    FOR B:= 1 TO 6 DO
      WRITELN(DISCIP[B], (ACUM[B] / TT):25:2)
  ELSE
    WRITELN('Nenhum registro encontrado.');
  WRITELN;
  TERMINE;
END.


