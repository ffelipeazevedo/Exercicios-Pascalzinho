Program N06FELIPE_AZEVEDO;
// Feito por => Felipe Fernandes de Azevedo
USES TARDENOITE;
{FUP QUE LEIA DO TECLADO:
Número de Inscrição (4 dígitos)   (1 ATÉ 9999) 
Nome (35 caracteres) 
CPF (11 dígitos)   VALIDAR
Data de Nascimento VALIDAR (8 dígitos) 
Cargo (2 dígitos)  VALIDAR ->(1 ATÉ 12) 
E GERE UM ARQUIVO DE ACESSO SEQUENCIAL CHAMADO SAI1.TXT COM AS INFORMACOES LIDAS
Ou seja, 
posição
01-04 – número com zeros a esquerda quando for o caso; 
05-39 – Nome (maiúsculas) com brancos a direita (para completar 35 caracteres quando for o caso);
40-50 – CPF; 
51-52 – Dia de nascimento com zero à esquerda quando for o caso; 
53-54 – Mês de nascimento com zero à esquerda quando for o caso; 
55-58 – Ano de nascimento e 
59-60 – Código do curso com zero à esquerda quando for o caso (entre 1 e 12). 
>>>>>>>>>>>>>>>>>>>>NAO ESQUECER DE DEIXAR OS CAMPOS COM O NUMERO DE CARACTERES INDICADOS<<<<<<<<<<<<<<<<<<<<<<
INSC LIDA ='0000', ENCERRAR O PROGRAMA
}
VAR ARQ:TEXT;
    NUM,ANO:STRING[4];
    NOME:STRING[35];
    CPF:STRING[11];
    DIA,MES,CAR:STRING[2];
    REG:STRING[60];
    A,B,T,E,X:INTEGER;
    D,M,AN:INTEGER;
Begin
  ASSIGN(ARQ,'C:\Users\ffern\OneDrive\Escritorio\Trabalhos Pascal\SAI1.TXT');
  APPEND(ARQ);
//valida a leitura do numero
  REPEAT
	 WRITE('INSCRIÇÃO=> ');
   READLN(NUM);
   VAL(NUM,X,E);
   IF (E > 0)THEN
    WRITELN('ILEGAL');
  UNTIL E=0;
//fimda validacao do numero
  WHILE(NUM<>'0000') DO
   BEGIN
    T:=LENGTH(NUM);//T CONTERA O TOTAL DE CARACTERES NO STRING NUM
    FOR A:=1 TO 4-T DO
     INSERT('0',NUM,1); //INSERE ZEROS A ESQUERDA
    WRITE('NOME=>');
    READLN(NOME);
    nome:=UPCASE(NOME);
    T:=LENGTH(NOME); //T contera o tota de caracteres do string NOME
    FOR A:=T+1 TO 35 DO
     INSERT(' ',NOME,A);  //insere espaços a direita
//VALIDAR O CPF - USAR O MÓDULO DA UNIT TARDENOITE
		 REPEAT
       WRITE('CPF=> ');
       READLN(CPF);
		 UNTIL VALIDACPF(CPF);		
//VALIDAR A DATA - USAR Os MÓDULOs DA UNIT TARDENOITE   (INSERIR ZERO A ESQUERDA DO DIA E DO MES, SE FOR O CASO)
//LEMBRAR QUE A FUNCTION VALDATA, PRECISAA RECEBER O DIA, MES E ANO COMO INTEGER....    
		REPEAT
		   //DIA
    	 WRITE('DIA => ');
    	 READLN(DIA);
			  T:=LENGTH(DIA);
			  FOR A:=1 TO 2-T DO
     	  INSERT('0',DIA,1); //INSERE ZEROS A ESQUERDA 
		   //MES
			 WRITE('MES => ');		   
			 READLN(MES);
		  	T:=LENGTH(MES);
			  FOR A:=1 TO 2-T DO
     	  INSERT('0',MES,1); //INSERE ZEROS A ESQUERDA
       //ANO
			 WRITE('ANO => ');
    	 READLN(ANO);
			 			 
			 VAL(DIA,D,E);
			 VAL(MES,M,E);
			 VAL(ANO,AN,E);      			 		
		UNTIL VALDATA(D, M, AN);
//VALIDAR O CARGO -> SÓ NUMEROS E ENTRE 1 E 12 (INSERIR ZERO A ESQUERD DO CAR, SE FOR O CASO
    REPEAT
			WRITE('CARGO=>');
	    READLN(CAR);
	    T:=LENGTH(CAR);
	    FOR A:=1 TO 2-T DO
	    INSERT('0',CAR,1);
	    
	    VAL(CAR,B,E);
    UNTIL (B>=1) AND (B<=12);   
//OU USA O INSERT, POR EXEMPLO INSERT(NUM,REG,1)
//OU
//CONCATENA
    REG:=NUM+NOME+CPF+DIA+MES+ANO+CAR;
    WRITELN(ARQ,REG);
   REPEAT
	  WRITE('INSCRIÇÃO=> ');
    READLN(NUM);
    VAL(NUM,X,E);
    IF (E > 0)THEN
     WRITELN('ILEGAL');
   UNTIL E=0;
  END;
   CLOSE(ARQ);
   TERMINE; 
End.