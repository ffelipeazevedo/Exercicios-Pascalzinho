Program N04FELIPE_AZEVEDO;
{Autor: Felipe Fernandes de Azevedo

FUP que leia uma relação de números positivos, colocando-os em um vetor, encerrada por um número negativo 
(o número negativo não deve fazer parte do vetor). Após a leitura, mostrar os números pares lidos em ordem crescente 
e os números ímpares lidos em ordem decrescente. (Máximo de 100 números <= para determinar o tamanho do vetor). 
Usar OBRIGATORIAMENTE o método de ordenação da troca, explicado na aula do dia 06/10/2025 e que consta na DS110_APOSTILA.DOCX. 
Usar a UNIT TARDENOITE.}

USES TARDENOITE;

VAR 
  VET: ARRAY[1..100] OF INTEGER;
  NUM, IND, TOTAL, I, AUX, LIMITE: INTEGER;
  TROCOU: BOOLEAN;

BEGIN
  LEIA('DIGITE UM NÚMERO (NEGATIVO ENCERRA) => ', NUM);
  IND := 0;
  WHILE NUM >= 0 DO
  BEGIN
    IF IND < 100 THEN
    BEGIN
      IND := IND + 1;
      VET[IND] := NUM;
    END;
    LEIA('DIGITE UM NÚMERO (NEGATIVO ENCERRA) => ', NUM);
  END;
  TOTAL := IND;

  IF IND <> 0 THEN
  BEGIN
    // ORDENAR TODO O VETOR EM ORDEM CRESCENTE
    LIMITE := TOTAL;
    REPEAT
      TROCOU := FALSE;
      FOR I := 1 TO LIMITE - 1 DO
      BEGIN
        IF VET[I] > VET[I+1] THEN
        BEGIN
          AUX := VET[I];
          VET[I] := VET[I+1];
          VET[I+1] := AUX;
          TROCOU := TRUE;
        END;
      END;
      LIMITE := LIMITE - 1;
    UNTIL NOT TROCOU;

    CLRSCR;
    WRITELN('PARES => ');
    // ORDEM CRESCENTE
    FOR I := 1 TO TOTAL DO
      IF VET[I] MOD 2 = 0 THEN
        WRITELN(VET[I]);

    // ORDEM DECRESCENTE
    LIMITE := TOTAL;
    REPEAT
      TROCOU := FALSE;
      FOR I := 1 TO LIMITE - 1 DO
      BEGIN
        IF VET[I] < VET[I+1] THEN
        BEGIN
          AUX := VET[I];
          VET[I] := VET[I+1];
          VET[I+1] := AUX;
          TROCOU := TRUE;
        END;
      END;
      LIMITE := LIMITE - 1;
    UNTIL NOT TROCOU;

    WRITELN('IMPARES => ');
    // SOMENTE IMPARES, NA ORDEM DECRESCENTE
    FOR I := 1 TO TOTAL DO
      IF VET[I] MOD 2 <> 0 THEN
        WRITELN(VET[I]);
  END
  ELSE
  BEGIN
    WRITELN('NENHUM NUMERO FOI LIDO');
  END;
  TERMINE;
END.


          












