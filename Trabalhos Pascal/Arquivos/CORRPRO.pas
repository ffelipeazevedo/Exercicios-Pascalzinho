Program CORRPRO ;
{Faça um programa que leia as respostas de uma prova de múltipla escolha de 6 (seis) disciplinas, 
constantes no arquivo de acesso sequencial tipo texto “prova.txt” (no anexo), 
cada registro é um string[74] e é composto por:
01-04    = número do candidato
05-74    = as setenta respostas da prova, assim divididas;
05 – 09 = respostas da disciplina 1 (05 questões);
10 – 19 = respostas da disciplina 2 (10 questões);
20 – 29 = respostas da disciplina 3 (10 questões);
30 – 49 = respostas da disciplina 4 (20 questões);
50 – 69 = respostas da disciplina 5 (20 questões);
70 – 74 = respostas da disciplina 6 (05 questões);
Após ler o registro, o programa deverá corrigir a prova do candidato, por disciplina e 
gravar o número do candidato e as notas das 6 (seis) disciplinas no arquivo de acesso 
sequencial tipo texto “notas.txt”, cujo registro 


erá um string[28]. 
A nota máxima de cada uma das 6 (seis) disciplinas  é 100. 
Os registros de “notas.txt” devem ficar como abaixo
01 – 04 = número do candidato
05 – 08 = nota da disciplina 1;
09 – 12 = nota da disciplina 2;
13 – 16 = nota da disciplina 3;
17 – 20 = nota da disciplina 4;
21 – 24 = nota da disciplina 5;
25 – 28 = nota da disciplina 6;
Ou seja:
0002  40   0   0  30  45  50
0003  50  10  10  25  45  40
............................
}
USES TARDENOITE;
VAR ARQ,ARQ1:TEXT;  //NOMES LOGICOS DOS ARQUIVOS
    REG:STRING[74]; //PROVAS
    REG1:STRING[28]; //NOTAS
    GABA:STRING[70];
    CE:ARRAY[1..6] OF INTEGER;
		A,B,TG,ERG,C,INI,FIM:INTEGER;
    NOTA:ARRAY[1..6] OF INTEGER;
    NOAL:STRING[4];
CONST
    QUES:ARRAY[1..6] OF INTEGER = (5,10,10,20,20,05);
Begin
 ASSIGN(ARQ,'PROVA.TXT');
 RESET(ARQ);//ABRE PARA LEITURA
 ASSIGN(ARQ1,'NOTAS.TXT');
 REWRITE(ARQ1);
 REPEAT//VALIDA O GABARITO QUE SERAH LIDO
  ERG:=0;
	WRITELN('DIGITE O GABARITO');
  WRITELN('0000000001111111111222222222233333333334444444444555555555566666666667');
  WRITELN('1234567890123456789012345678901234567890123456789012345678901234567890');
  READLN(GABA);
	TG:=LENGTH(GABA);
	gaba:=upcase(gaba);
	IF(TG<70)THEN
	 BEGIN
	  WRITELN('ILEGAL MENOS DE 70');
	  ERG:=1;
	 END
	ELSE
   REPEAT
    A:=A+1;
	  IF(GABA[A]<'A') OR (GABA[A]>'E')THEN
	   BEGIN 
	    WRITELN('GABARITO DIGITADO ILEGAL');
	    ERG:=1;
	   END;
	 UNTIL(ERG=1) OR (A=70);
 UNTIL (ERG=0) ;
//INICIO DA LEITURA
 WHILE(NOT EOF(ARQ)) DO
  BEGIN
   READLN(ARQ,REG);
//INICIO DA CORRECAO
//COMO CONTADORES SÃO INDIVIDUAIS (CE) TEM QUE ZERAR
//PARA 6 DISCIPLINAS
   INI:=1;
	 FOR B:=1 TO 6 DO
	  BEGIN
	   CE[B]:=0;
     FIM:=INI+QUES[B]-1;
     FOR A:= INI TO FIM DO
      IF(GABA[A]=REG[A+4])THEN //ACERTOU SE VERDADE
       CE[B]:=CE[B]+1;
//CALCULA A NOTA
      NOTA[B]:=CE[B]*(100 DIV QUES[B]);
      INI:=INI+QUES[B];
    END;
//ESTOU COM O VETOR DE  6 NOTAS (INTEGER) PREENCHIDOS
//TRANSFORMAR AS NOTAS PARA STRING E CONCATENAR EM REG1
   REG1:=COPY(REG,1,4);
   FOR B:=1 TO 6 DO
    BEGIN
     STR(NOTA[B]:4,NOAL);
     REG1:=REG1+NOAL;
    END;
   WRITELN(ARQ1,REG1);
  END;
 CLOSE(ARQ1);
 CLOSE(ARQ);
 TERMINE
End.               
