Program Pzim ;
USES TARDENOITE;

VAR
  arq: file of regis;
  reg: regis;
  VAGAS: text;
  vet: vetor;
  strNotas: array[1..6] of string[3];
  vagasc: array[1..12] of integer;
  poscargo: array[1..12] of integer;
  aprovados: array[1..12] of integer;
  soma, idadeStr: string[8];
  ind, a, nasc, idade, erro, qtd, pfi, numCargo: integer;
  linha, cargoStr, qtdStr: string[40];

BEGIN
  CORTELA(0);
  TEXTCOLOR(12);

  { inicializa contadores e vetores para segurança }
  for a := 1 to 12 do
  begin
    vagasc[a] := 0;
    poscargo[a] := 0;
    aprovados[a] := 0;
  end;

  assign(VAGAS, 'vagas.txt');
  assign(ARQ, 'cand.ind');

  { abre os arquivos: vagas (texto) e cand.ind (binário) para leitura }
  reset(VAGAS);
  reset(ARQ);

  { lê o arquivo de vagas e preenche o array de vagas por cargo }
  while not EOF(VAGAS) do
  begin
    readln(VAGAS, linha);
    cargoStr := copy(linha, 1, 2);
    qtdStr := copy(linha, 30, 2);
    val(trim(cargoStr), numCargo, erro);
    val(trim(qtdStr), qtd, erro);
    if (numCargo >= 1) and (numCargo <= 12) then
      vagasc[numCargo] := qtd;
  end;

  { --- leitura segura do arquivo de candidatos, preenchendo 'vet' --- }
  ind := 0;
  pfi := 0;

  while not EOF(ARQ) do
  begin
    read(ARQ, reg);

    { proteções: evita ultrapassar o limite do vetor (se declar. como array estático) }
    if ind = high(vet) then
    begin
      writeln('Aviso: limite do vetor atingido em ', ind, ' registros lidos.');
      break;
    end;

    ind := ind + 1;
    vet[ind].PF := pfi;

    { limpa campos de controle }
    reg.clg := 0;
    reg.clc := 0;
    reg.ccl := 0;

    { formata as notas com 3 posições cada (com zeros à esquerda) }
    for a := 1 to 6 do
    begin
      str(reg.notas[a]:3, strNotas[a]);
      while length(strNotas[a]) < 3 do
        insert('0', strNotas[a], 1);
    end;

    { soma formatada com 3 dígitos }
    str(reg.som:3, soma);
    while length(soma) < 3 do
      insert('0', soma, 1);

    { converte data para número AAAAMMDD corretamente }
    nasc := reg.data.ano * 10000 + reg.data.mes * 100 + reg.data.dia;
    idade := 20250826 - nasc;

    { formata idade com 8 dígitos (zeros à esquerda) }
    str(idade:8, idadeStr);
    while length(idadeStr) < 8 do
      insert('0', idadeStr, 1);

    { monta a chave de comparação CC (mesma ordem do seu original) }
    vet[ind].CC := soma + strNotas[4] + strNotas[5] + strNotas[3] +
                   strNotas[2] + strNotas[6] + strNotas[1] + idadeStr;

    pfi := pfi + 1;
  end;

  { fecha arquivos de leitura antes de ordenar / reabrir para escrita }
  close(VAGAS);
  close(ARQ);

  writeln('Ordenando, aguarde..');
  ordem(vet, ind);  { assume que ordem está definida na unidade TARDENOITE }

  { reabre o arquivo cand.ind para atualizar os registros in-place }
  assign(ARQ, 'cand.ind');
  reset(ARQ);  { reset preserva o arquivo existente — não usamos rewrite }

  { percorre a classificação (do maior para o menor) e atualiza campos nos registros }
  for a := ind downto 1 do
  begin
    { posiciona no registro original pelo campo PF armazenado }
    seek(ARQ, vet[a].PF);
    read(ARQ, reg);

    reg.clg := ind - a + 1;

    if (reg.car >= 1) and (reg.car <= 12) then
    begin
      poscargo[reg.car] := poscargo[reg.car] + 1;
      reg.clc := poscargo[reg.car];

      if reg.clc <= vagasc[reg.car] then
      begin
        reg.ccl := reg.car;
        aprovados[reg.car] := aprovados[reg.car] + 1;
      end
      else
        reg.ccl := 0;
    end
    else
    begin
      reg.clc := 0;
      reg.ccl := 0;
    end;

    { volta à posição do registro e sobrescreve com os novos valores }
    seek(ARQ, vet[a].PF);
    write(ARQ, reg);
  end;

  close(ARQ);

  { mostra resumo final }
  writeln;
  writeln('Candidatos aprovados por cargo:');
  writeln;
  for a := 1 to 12 do
    writeln('Cargo ', a:2, ': ', aprovados[a], ' vagas');

  writeln;
  writeln('O concurso obteve ', IND:5, ' candidatos na classificação geral');
  writeln;
  termine;
END.
