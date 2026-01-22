Program POETURMAS ;
//
//luiz antonio profe
//COLOCA NO CAMPO TUR, DE CAND.IND A TURMA QUE O CANDIDATO FARAH A PROVA
//usará o arquivo TURMASFT.txt que contem O NUMERO DA TURMA E O NUMER DE CANDIDATOS POR TURMA
//01-02 === NUMERO DA TURMA
//04-05 === NUMERO DE CANDIDATOS POR TURMA
//
uses TARDENOITE;
var
//arquivos
 arq:file of regis; //LOGICO
 reg:regis;         //REGISTRO
 TURMA:text;        //LOGICO
 REGTUR:STRING[5];  //REGISTRO
//VETOR QUE CONTERA O NUMERO DE CANDIDATOS POR TURMA
 CANTUR,LEVE:ARRAY[1..100] OF INTEGER;  //SUPERESTIMADO
//outras
 vet:vetor;
 a,b,c,CT,CCT,np,ii,tot,tc,tt,TTT,ERR:integer;     //POSIV= INDICE DO VETOR
 num:string[2];
Begin
 assign(arq,'C:\Users\ffern\OneDrive\Escritorio\Trabalhos Pascal\cand.ind');
 assign(TURMA,'C:\Users\ffern\OneDrive\Escritorio\Trabalhos Pascal\TURMASFT.txt');
 reset(arq);
 reset(TURMA);
//LE O NUM DE CAND POR TURMA E MONTA O VETOR
 A:=0;
 REPEAT
  READLN(TURMA,REGTUR);
  A:=A+1;
  VAL(COPY(REGTUR,4,2),CANTUR[A],ERR);
 UNTIL(EOF(TURMA));
 CLOSE(TURMA);
 A:=0;
//OS CANDIDATOS DEVEM SER ALOCADOS NAS TURMAS POR CARGO
//monta o vetor pelo num DO CARGO
 repeat
  read(arq,reg);
  ii:=a+1;          //ii=indice do vetor
	vet[ii].pf:=a;    //a=posicao fisica do registro no arquivo
	str(reg.CAR,num);
	IF(REG.CAR<10)THEN
	 insert('0',num,1);  //insere zero a esquerda NO CARGO TRANSF EM STRING
	vet[ii].cc:=num; 
	A:=A+1;
 until(eof(arq));	
//fim da montagem
 tot:=ii;
 WRITELN(' PRIMEIROS 20 ELEMENTOS ANTES DA ORDENACAO. CC E PF');
 for a:=1 to 20 do
  writeln(' ',vet[a].cc,'  ',vet[a].pf:5);
 writeln(' inicio da ordenacao');
 ordem(vet,ii);
 writeln(' fim da ordenação');
 WRITELN(' PRIMEIROS 20 ELEMENTOS DO VETOR DEPOIS DA ORDENACAO. CC E PF');
 for a:=1 to 20 do
  writeln(' ',vet[a].cc,'  ',vet[a].pf:5);
 writeLN(' enter para continuar');
 readln;
 writeln;
//ATUALIZA O CAMPO TURMA DE TODOS OS CANDIDATOS A PARTIR DO VETOR ORDENADO
 CT:=1;//CONTADOR DE TURMA
 FOR A:=1 TO TOT DO
  BEGIN
   seek(arq,vet[A].pf);  //POSICIONA APONTADOR NO INICIO DO REGISTRO
	 read(arq,reg);
//ATUALIZA O CAMPO REG.TUR COM O CAMPO CHAVE DO VETOR
   IF(CCT=CANTUR[CT])THEN
    BEGIN
     CT:=CT+1;
     CCT:=0;
    END;
   CCT:=CCT+1;
	 REG.TUR:=CT;
	 SEEK(ARQ,VET[A].PF);//RETORNA APONTADOR PARA INICIO DO REGISTRO
	 WRITE(ARQ,REG);
	END;
 writeln(' ATUALIZADOS --',A:5,' candidatos');
 CLOSE(ARQ);
 RESET(ARQ);
 WHILE NOT EOF(ARQ) DO
  BEGIN
	 READ(ARQ,REG);
	 LEVE[REG.TUR]:=LEVE[REG.TUR]+1;
	END;
 FOR A:=1 TO 50 DO
  BEGIN
   WRITELN(A:10,LEVE[A]:5,'<=ARQ',CANTUR[A]:5,'<=TURMAS');
	 TTT:=TTT+LEVE[A];
	END;
 WRITELN(TTT:15);	
 termine; 
 CLOSE(ARQ);
 TERMINE;
End.