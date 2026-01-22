Program N02FELIPE_AZEVEDO;
// Autor: Felipe Fernandes de Azevedo
{ FUP que leia 10 números e mostre o total de números lidos pares e ímpares; 
após, leia mais 10 números e mostre o total de números lidos múltiplos de 3 e não múltiplos de 3 }



VAR P1, P2, N, NUM, X, R: INTEGER; // Variáveis globais

// Função que pega a parte inteira de um numero real
FUNCTION INTEIRO(NN:REAL): INTEGER; // (NN) = Parametro formal

VAR DIV1, MULT, INT_RESULT: INTEGER; // Variáveis locais da funcão inteiro
    II:REAL;                         
    
	BEGIN
	  DIV1:= TRUNC(NN);// Trunc ele transforma um valor real em inteiro
	  MULT:= 1;
	  IF (DIV1 < 0) THEN
	    MULT:= -1;
	  DIV1:= DIV1 * MULT;
	  INT_RESULT:= 0;
	  II:= 0;	
	  REPEAT
	  	INT_RESULT:= INT_RESULT + 1;
	    II:= II + 1;
	  UNTIL (II > DIV1);	
	  INTEIRO:= (INT_RESULT - 1) * MULT;
	END;

// Função que calcula o resto da divisao
FUNCTION RESTO(A,B: INTEGER): INTEGER; // (A, B) = Parametro formal

VAR INT_RESULT: INTEGER; // VariáveL locaL da function resto
	BEGIN
	  INT_RESULT:= INTEIRO(A / B); // Onde INTEIRO(A/B), é o parametro real da função inteiro
	  RESTO:= A - INT_RESULT * B;
	END;
	
// Procedimentos para mostrar os resultados
PROCEDURE SAI;

	BEGIN
	  WRITELN('Multiplos de ', N:1, ' = ', P1:1);
	  WRITELN('Não multiplos de ', N:1, ' = ', P2:1);
	  WRITELN;
	END;
	

// Procedimento para testar se o resto é zero
PROCEDURE TESTA(res: INTEGER; VAR MU, NMU: INTEGER); // (res, MU, NMU) = Parametro formal

	BEGIN
	  IF (res = 0) THEN
	    MU:= MU + 1
	  ELSE
	    NMU:= NMU + 1;
	END;


{ALGORITIMO PRINCIPAL}
	BEGIN
	  //Multiplos de 2
		P1:= 0;
	  P2:= 0;
	  N:= 2;
	  WRITELN('Digite 10 numeros para verificar multiplos de 2:');
	  FOR X:= 1 TO 10 DO
	  BEGIN
	    WRITE('Digite o ', X:2, '° numero => ');
	    READLN(NUM);
	    R:= RESTO(NUM, N);  
	    TESTA(R, P1, P2);
	  END;
	  SAI; 
	  //Multiplos de 3
	  P1:= 0;
	  P2:= 0;
	  N:= 3;
	  WRITELN('Digite 10 números para verificar quais são os multiplos de 3:');
	  FOR X := 1 TO 10 DO
	  BEGIN
	    WRITE('Digite o ', X:2, '° numero => ');
	    READLN(NUM);
	    R:= RESTO(NUM, N);  
	    TESTA(R, P1, P2);    
	  END;
	  SAI;
	
	  WRITE('Pressione (X) para encerrar: ');
		READLN;
	END.


{			1- Escreva os nomes das variáveis locais. 	
				 R:	DIV1, MULT, INT_RESULT, II.
			------------------------------------------
			2- Escreva os nomes das variáveis globais.
			   R: P1, P2, N, NUM, X, R.
			------------------------------------------   
			3- Escreva os nomes dos parâmetros formais.
			   R: NN, A, B, res, MU, NMU
			------------------------------------------   
			4- Escreva os nomes dos parâmetros reais. 
			   R: A / B (quando chama INTEIRO), NUM, N, R, P1, P2
			------------------------------------------   
			5- Explique o motivo de existir passagem de parâmetros por valor e por referência, na rotina TESTA. 
         R: res é por valor porque não é alterado. MU e NMU são por referência para que os contadores sejam atualizados fora do procedimento.
}        
