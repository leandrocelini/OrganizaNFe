unit TefDiscado;

interface

Uses Windows, SysUtils, Forms, Db, Dialogs, Classes, ExtCtrls, Controls,
     ShellApi, mbDialogo, TEF;

Function Abrir_Gerenciador_Tef(Var Erro:String):Boolean;
Function Verifica_Gerenciador_Tef():Boolean;
Function RealizaTransacao(Var DadosTEF:TDadosTEF):Integer;
Function ConfirmaTransacao():Boolean;
Function ImprimeTransacao(iConta:Integer;Gerencial:Boolean):Boolean;
Function NaoConfirmaTransacao():Boolean;
procedure VerificarCancelarTransacoesConfirmadas(iConta:Integer);
Function CancelaTransacaoConfirmada(cNSU,cValor,cNomeRede,cTipo,cNumeroDOC,
                                    cData,cHora,cTipoPessoa,cDocPessoa,
                                    cDataCheque:String; iVezes: integer):Boolean;
Function TerminaTransacaoTEF:Boolean;
Procedure VerificarCancelarTransacoesPendentes;
Function FuncaoAdministrativaTEF(cIdentificacao:TDateTime):Integer;
Function AguardaRespostaTEF(cIdent:String;iConta:Integer):Integer;

implementation

uses ECF, mbFuncoes, MsgEspera;

////////////////////////////////////////////////////////
Function Abrir_Gerenciador_Tef(Var Erro:String):Boolean;
////////////////////////////////////////////////////////
Begin
   Erro := '';
   Result := True;

   //Verifica se possui alguma resposta e apaga
   If ( FileExists(TEF.DirResp + '\INTPOS.STS') ) then begin
      DeleteFile(TEF.DirResp + '\INTPOS.STS');
   End;

   //Verifica se possui alguma resposta e apaga
   //If ( FileExists( DirResp + '\INTPOS.001' ) ) then begin
   //   DeleteFile( DirResp + '\INTPOS.001' );
   //End;

   //Verifica se possui algum arquivo de requisi��o
   //If ( FileExists( DirReq + '\INTPOS.001' ) ) then begin
   //   DeleteFile( DirReq + '\INTPOS.001' );
   //End;

   If ( FileExists(TEF.DirResp + '\ATIVO.001' ) ) then begin
      DeleteFile(TEF.DirResp + '\ATIVO.001' );
   End;

   If FileExists(TEF.NomeExeTef) Then begin
      ShellExecute(0, Nil, PChar(TEF.NomeExeTef), Nil, Nil, SW_ShowMaximized);
      SleepEx(7000,True);
      mbFuncoes.EmptyKeyQueue;
      mbFuncoes.EmptyMouseQueue;
      mbFuncoes.ForceForegroundWindowForm(Screen.ActiveForm.Handle);
      Application.ProcessMessages;
   End else begin
      Erro := 'Gerenciador n�o encontrado!!!' + Chr(13) +
              'Reinstalar o gerenciador do TEF';
      Result := False;
   End;
End;

///////////////////////////////////////////////////////////
//Fun��o utilizada para verificar se o gerenciador do TEF esta ativo
//Paramentros:
//  Erro - Variavel string que retorna a mesagem de erro
//Retorno:
//  True - Gerenciador Ativo
//  False - Gerenciador Inativo
//Autor: Jo�o Paulo Francisco Bellucci
////////////////////////////////////////////
Function Verifica_Gerenciador_Tef():Boolean;
////////////////////////////////////////////
var cConteudoArquivo, cErro: string;
    cIdentificacao:TDateTime;
    cArquivo:TextFile;
    iTentativas:Integer;
    lFlag:LongBool;
begin
   //Verifica se possui alguma resposta e apaga
   If ( FileExists(TEF.DirResp + '\INTPOS.STS') ) then begin
      DeleteFile(TEF.DirResp + '\INTPOS.STS');
   End;

   If ( FileExists(TEF.DirResp + '\ATIVO.001' ) ) then begin
      DeleteFile( TEF.DirResp + '\ATIVO.001' );
   End;

   Result := True;
   lFlag := True;
   cIdentificacao := Now();

   //Cria o cabe�alho de teste de comunica��o com o gerenciador
   cConteudoArquivo := '000-000 = ATV' + #13 + #10 +
                       '001-000 = ' + FormatDateTime('hhmmss',cIdentificacao) + #13 + #10 +
                       '999-999 = 0';

   //Cria a arquivo de identifica��o
   AssignFile(cArquivo,'INTPOS.001');
   ReWrite( cArquivo );
   WriteLn( cArquivo, cConteudoArquivo );
   CloseFile( cArquivo );

   //Copia o Arquivo para o diret�rio de requisi��o do TEF
   CopyFile(PChar('INTPOS.001'),
            PChar(TEF.DirReq + '\INTPOS.001'),lFlag);

   //Apaga o arquivo local
   DeleteFile('INTPOS.001');

   For iTentativas := 1 to 7 do begin
      If ( FileExists(TEF.DirResp + '\ATIVO.001' ) ) or
           ( FileExists(TEF.DirResp + '\INTPOS.STS' ) ) then begin
          Break;
      End;

      //Aguarda 1 segundo
      Sleep(1000);

      If ( iTentativas = 7 ) then begin
         ECF.Finaliza_Modo_TEF();
         mbFuncoes.EmptyKeyQueue();
         mbFuncoes.EmptyMouseQueue();
         Application.ProcessMessages();

         If TEF.AbreGerenciador Then begin
            MessageDlg('Gerenciador Padr�o n�o est� ativo ' + #13 +
                       'e ser� ativado autom�ticamente!',
                       mtInformation,[mbOk],0);

            If Abrir_Gerenciador_Tef(cErro) Then begin
               Msg(False);
            End else begin
               Msg(False);
               MessageDlg(cErro,mtInformation,[mbOk],0);

               Result := False;
               Break;
            End;
         End else begin
            MessageDlg('Erro de Comunica��o - TEF.' + #13 +
                       'Favor Ativa-lo!!!',
                       mtInformation,[mbOk],0);

            Result := False;
            Break;
         End;
      End;
   End;

   //Verifica se possui alguma resposta e apaga
   If ( FileExists(TEF.DirResp + '\INTPOS.STS') ) then begin
      DeleteFile(TEF.DirResp + '\INTPOS.STS');
   End;
end;

//////////////////////////////////////////////////////////
// Fun��o:
//    RealizaTransacao
// Objetivo:
//    Realiza a transa��o TEF
//
// Par�metros:
//   DadosTEF: TDadosTEF
//
// Retorno:
//    True para OK
//    False para n�o OK
//
//////////////////////////////////////////////////////////
function RealizaTransacao(Var DadosTEF:TDadosTEF):Integer;
//////////////////////////////////////////////////////////
Var cConteudoArquivo, cLinhaArquivo, cLinha,
    cCampoArquivo, cValorPago, cErro, cTipoTransacao: string;
    cArquivo  : TextFile;
    lFlag     : longbool;
    iTentativas, iVezes, iConta, iErros: integer;
    bTransacao,ContinuaTEF: boolean;
begin
   bTransacao := False;
   lFlag      := False;
   Result     := -2;

   // Se j� existe mais de um pagamento, deve-se confirmar a transa��o anterior
   If ( FileExists( 'PENDENTE.TXT' ) ) then begin
      ContinuaTEF := True;
      While ContinuaTEF do begin
         If ConfirmaTransacao() Then begin
            ContinuaTEF := False;
         End;
      End;

      //Aguarda 1 segundo
      Sleep(1000);
   End else begin
      If Not Verifica_Gerenciador_Tef() Then begin
         Exit;
      End;
   End;

   //Verifica se os arquivos de resposta ainda est�o no diret�rio e apaga
   If ( FileExists( TEF.DirResp + '\INTPOS.STS' ) ) then
      DeleteFile( TEF.DirResp + '\INTPOS.STS' );

   If ( FileExists( TEF.DirResp + '\INTPOS.001' ) ) then
      DeleteFile( TEF.DirResp + '\INTPOS.001' );

   //Inicializa as variaveis de retorno
   DadosTEF.MsgRetorno    := '';
   DadosTEF.MsgUser       := '';
   DadosTEF.NomeRede      := '';
   DadosTEF.TipoTransacao := '';
   DadosTEF.Comprovante   := '';

   //Soma o n�mero de transacoes
   iConta := TEF.nTransacoes + 1;

   //Formata o campo valor pago
   cValorPago := FormatFloat('########0.00',DadosTEF.Valor);

   //Retira o ponto decimal
   Delete(cValorPago,Pos(DecimalSeparator,cValorPago),1);

   //Verifica o tipo de transa��o que dever� ser solicitada
   If ( DadosTEF.TipoFormaPg = 'Cheque' ) Then begin
      cTipoTransacao := 'CHQ';
   End else begin
      cTipoTransacao := 'CRT';
   End;

   Try
      // Conte�do do arquivo INTPOS.001 para solicitar a transa��o TEF.
      AssignFile(cArquivo,'INTPOS.001');
      cConteudoArquivo := '';
      cConteudoArquivo := '000-000 = ' + cTipoTransacao + #13 + #10 +
                          '001-000 = ' + FormatDateTime( 'hmmss', DadosTEF.Identificacao ) + #13 + #10 +
                          '002-000 = ' + DadosTEF.NumeroCupom + #13 + #10 +
                          '003-000 = ' + cValorPago + #13 + #10 +
                          '999-999 = 0';
                          //'777-777=TESTE REDECARD' + #13 + #10 +
      ReWrite(cArquivo);
      WriteLn(cArquivo,cConteudoArquivo);
      CloseFile(cArquivo);

      //Copia o arquivo para o diret�rio do TEF
      CopyFile(Pchar('INTPOS.001'),pchar(TEF.DirReq+'\INTPOS.001' ), lFlag );

      If FileExists(pchar(TEF.DirReq+'\INTPOS.001' )) Then begin
         DeleteFile('INTPOS.001');
      End;
   Except
      On E:Exception do begin
         MessageDlg('Erro ao criar arquivo!!!' + #13 +
                    E.Message,mtError,[mbOK],0);
         Exit;
      End;
   End;

   //Se o arquivo de transa��o ja existir apaga
   If FileExists( 'IMPRIME' + inttostr( iConta ) + '.TXT' ) then begin
      DeleteFile( 'IMPRIME' + inttostr( iConta ) + '.TXT' );
   End;

   //Aguarda a resposta do gerenciador padr�o em at� 10 segundos
   For iTentativas := 1 to 10 do begin
      If FileExists( TEF.DirResp + '\INTPOS.STS' ) then begin
         Break;
      End else begin
         sleep( 1000 );
      End;
   End;

   //O arquivo INTPOS.STS n�o retornou em 10 segundos, ent�o o operador � informado.
   If ( iTentativas > 10 ) then begin
      If ( FileExists( TEF.DirReq + '\INTPOS.001' ) ) then
         DeleteFile( TEF.DirReq + '\INTPOS.001' );

      If TEF.AbreGerenciador Then begin
         Msg(True,'Gerenciador Padr�o n�o est� ativo ' + #13 +
                  'e ser� ativado autom�ticamente!');

         If Abrir_Gerenciador_Tef(cErro) Then begin
            Msg(False);
         End else begin
            Msg(False);
            MessageDlg(cErro,mtInformation,[mbOk],0);
         End;
      End else begin
         MessageDlg('Erro de Comunica��o - TEF.' + #13 +
                    'Favor Ativa-lo!!!',
                    mtInformation,[mbOk],0);
      End;

      Result := -3;
      Exit;
   End;

   cLinhaArquivo := '';
   cLinha := '';
   iErros := 0;
   while ( result = -2 ) do begin
      //Processa as msg do windows
      Application.ProcessMessages;

      // Verifica o arquivo INTPOS.001 de resposta.
      If FileExists( TEF.DirResp + '\INTPOS.001' ) then begin

         //Se recebeu a resposta apaga o arquivo de requisi��o
         //Bug do gerenciador do TEF que n�o apaga o arquivo de
         //requisi��o quando � clicado no bot�o '9' para sair
         //s� apaga se pressionar '9', na homologa��o tem que tirar essa linha
         While ( FileExists( TEF.DirReq + '\INTPOS.001' ) ) do begin
            DeleteFile( TEF.DirReq + '\INTPOS.001' );
            Sleep(100);
         End;

         Try
            AssignFile( cArquivo, TEF.DirResp + '\INTPOS.001' );
            Reset( cArquivo );
            while not EOF( cArquivo ) do begin

               ReadLn( cArquivo, cLinhaArquivo );
               cCampoArquivo := copy( cLinhaArquivo, 1, 3 );

               case StrToIntDef( cCampoArquivo, -1 ) of
                  // Verifica se o campo de identifica��o � o mesmo do solicitado.
                  1:Begin
                     If ( copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 ) <> FormatDateTime( 'hmmss', DadosTEF.Identificacao ) ) then begin
                        //Fecha o arquivo
                        CloseFile( cArquivo );
                        Sleep(1000);
                        DeleteFile( TEF.DirResp + '\INTPOS.001' );
                        Result := -2;
                        Break;
                     End;
                  End;

                  // Verifica se a Transa��o foi Aprovada.
                  9:begin
                     If ( copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 ) ) = '0' then begin
                        bTransacao := True;
                        result := 1;
                     End else begin
                        bTransacao := False;
                        Result := -1;
                     End;
                  end;

                  //Verifica o nome da rede
                  10:begin
                     DadosTEF.NomeRede := Copy(cLinhaArquivo,11,Length(cLinhaArquivo)-10);
                  End;

                  //Verifica o tipo da transa��o
                  11:begin
                     DadosTEF.TipoTransacao := Copy(cLinhaArquivo,11,Length(cLinhaArquivo)-10);
                  End;

                  // Verifica se existem linhas para serem impressas.
                  28:begin
                     If ( StrToInt( copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 ) ) <> 0 ) and ( bTransacao = True ) then begin
                        // � realizada uma c�pia tempor�ria do arquivo INTPOS.001 para cada transa��o efetuada.
                        // Caso a transa��o necessite ser cancelada, as informa��es estar�o neste arquivo.
                        CopyFile(pchar(TEF.DirResp+'\INTPOS.001' ),pchar(TEF.DirTmp+'\INTPOS'+IntToStr(iConta)+'.001' ),lFlag);

                        For iVezes := 1 to StrToInt( copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 ) ) do begin
                           ReadLn( cArquivo, cLinhaArquivo );
                           If copy( cLinhaArquivo, 1, 3 ) = '029' then begin
                              cLinha := cLinha + copy( cLinhaArquivo, 12, Length( cLinhaArquivo ) - 12 ) + #13 + #10;
                           End;
                        End;
                     End;
                  End;

                  // Verifica se o campo � o 030 para mostrar a mensagem para o operador
                  30:begin
                     If ( cLinha <> '' ) then begin
                        DadosTEF.MsgRetorno := Copy(cLinhaArquivo,11,Length(cLinhaArquivo)-10);
                     End else begin
                        //Verifica se o arquivo de requisi��o foi apagado se n�o foi apaga
                        //If ( FileExists( DirReq + '\INTPOS.001' ) ) then
                        //   DeleteFile( DirReq + '\INTPOS.001' );

                        //Retorna a msg para o usu�rio
                        DadosTEF.MsgUser := Copy(cLinhaArquivo,11,Length(cLinhaArquivo)-10);
                     End;
                  End;
               End;
            End;
         Except
            On E:Exception do begin
               //Incrementa o contador de erros
               Inc(iErros);

               //Aguarda a maquina processar
               Sleep(100);

               //Se der mais de 10 erros informa ao usu�rio
               If ( iErros >= 10 ) Then begin
                  MessageDlg('Erro na leitura do arquivo INTPOS.001!!!' + #13 +
                             E.Message + #13 +
                             'Tente novamente.',mtError,[mbOk],0);
                  iErros := 0;
               End;
            End;
         End;
      End;
   End;

   //Fecha o arquivo
   CloseFile( cArquivo );

   // Cria o arquivo tempor�rio IMPRIME.TXT com a imagem do comprovante
   If ( cLinha <> '' ) then begin
      //Salva os dados do comprovante
      DadosTEF.Comprovante := cLinha;

      //Salva o comprovante em arquivo texto
      AssignFile( cArquivo, 'IMPRIME' + IntToStr( iConta ) + '.TXT' );
      ReWrite( cArquivo );
      WriteLn( cArquivo, cLinha );
      CloseFile( cArquivo );
   End;

   //Faz o foco voltar para aplica��o via Form
   mbFuncoes.ForceForegroundWindowForm(Screen.ActiveForm.Handle);

   If ( Result = 1 ) then begin
      AssignFile( cArquivo, 'PENDENTE.TXT' );
      ReWrite( cArquivo );
      WriteLn( cArquivo, inttostr( iConta ) );
      CloseFile( cArquivo );

      //Atualiza o n�mero de transacoes realizadas
      TEF.nTransacoes := iConta;

      //Salva os dados da transa��o
      DadosTransacoes[iConta].Identificacao  := DadosTEF.Identificacao;
      DadosTransacoes[iConta].NumeroCupom    := DadosTEF.NumeroCupom;
      DadosTransacoes[iConta].TipoFormaPg    := DadosTEF.TipoFormaPg;
      DadosTransacoes[iConta].FormaPagamento := DadosTEF.FormaPagamento;
      DadosTransacoes[iConta].Fk_FormaPg     := DadosTEF.Fk_FormaPg;
      DadosTransacoes[iConta].Valor          := DadosTEF.Valor;
      DadosTransacoes[iConta].TipoTransacao  := DadosTEF.TipoTransacao;
      DadosTransacoes[iConta].NomeRede       := DadosTEF.NomeRede;
      DadosTransacoes[iConta].MsgRetorno     := DadosTEF.MsgRetorno;
      DadosTransacoes[iConta].MsgUser        := DadosTEF.MsgUser;
      DadosTransacoes[iConta].Comprovante    := DadosTEF.Comprovante;

      // Neste ponto � criado o arquivo TEF.TXT, indicando que h� uma
      // opera��o de TEF sendo realizada. Caso ocorra uma queda de energia,
      // no momento da impress�o do TEF, e a aplica��o for inicializada,
      // ao identificar a exist�ncia deste arquivo, a transa��o do TEF
      // dever� ser concelada.
      Try
         AssignFile( cArquivo, 'TEF.TXT');
         Try
            ReWrite( cArquivo );
            WriteLn( cArquivo, IntToStr( TEF.nTransacoes ) );
         Finally
            CloseFile( cArquivo );
         End;
      Except
         On E:Exception do begin
            MessageDlg('Erro ao criar o arquivo TEF.TXT' + #13 +
                       E.Message, mtError,[mbOk],0);
         End;
      End;
   End else begin
      If ( FileExists( TEF.DirResp + '\INTPOS.001' ) ) then
         DeleteFile( TEF.DirResp + '\INTPOS.001' );

      IF ( DadosTEF.MsgRetorno <> '' ) Then begin
         MsgTEF(DAdosTEF.MsgRetorno,5000);
      End;
   End;

   If ( FileExists( TEF.DirResp + '\INTPOS.STS' ) ) then
      DeleteFile( TEF.DirResp + '\INTPOS.STS' );
End;

////////////////////////////////////////////////////////////////////
//
// Fun��o:
//    ImprimeTransacao
// Objetivo:
//    Realiza a impress�o da Transa��o TEF
// Par�metros:
//   String para a Forma de Pagamento
//   String para a Valor da Forma de Pagamento
//   String para o N�mero do Cupom Fiscal (COO)
//   TDateTime para identificar o n�mero da transa��o
//   Integer com o n�mero da transa��o
// Retorno:
//    True para OK
//    False para n�o OK
//
////////////////////////////////////////////////////////////////////
function ImprimeTransacao(iConta:Integer;Gerencial:Boolean):Boolean;
////////////////////////////////////////////////////////////////////
Var cLinha, cErro: string;
    Dados:TStringList;
    cArquivo:TextFile;
    DadosComprovante:TDadosComprovante;
    IniciaNovo,FechaRelatorio:Boolean;
    iVias: integer;
begin

   Result := true;

   //Cria o string list para armazenar os dados se n�o for comprovante vinculado
   Dados := TStringList.Create;
   Try
      //Verifica se a variavel esta vazia e pega os dados do arquivo
      If ( DadosTransacoes[iConta].Comprovante = '' ) Then begin
         If FileExists( 'IMPRIME' + inttostr( iConta ) + '.TXT' ) then begin
            AssignFile( cArquivo, 'IMPRIME' + IntToStr(iConta) + '.TXT' );
            Reset( cArquivo );
            cLinha := '';
            While Not EOF( cArquivo ) do begin
               ReadLn( cArquivo, cLinha );

               //Monta o comprovante
               DadosTransacoes[iConta].Comprovante := DadosTransacoes[iConta].Comprovante + cLinha + #13 + #10;
            End;
            CloseFile( cArquivo );
         End;
      End;

      //Se n�o houver nada para imprimir sai da rotina
      If ( DadosTransacoes[iConta].Comprovante = '' ) Then begin
         Exit;
      End;

      DadosComprovante.FormaPg     := DadosTransacoes[iConta].TipoFormaPg;
      DadosComprovante.Valor       := DadosTransacoes[iConta].Valor;
      DadosComprovante.NumeroCupom := DadosTransacoes[iConta].NumeroCupom;
      DadosComprovante.CGC         := '';
      DadosComprovante.Nome        := '';
      DadosComprovante.Endereco    := '';

      //Imprime � quantidade de vias do comprovante do TEF
      Dados.Text := '';
      For iVias := 1 to TEF.NumeroVias do begin
         //Monta os dados que ser�o impressos
         Dados.Text := Dados.Text + DadosTransacoes[iConta].Comprovante;

         If ( iVias <> TEF.NumeroVias ) then begin
            Dados.Add(''); Dados.Add('');
            Dados.Add(''); Dados.Add('');
            Dados.Add(''); Dados.Add('');
            Dados.Add('');

            Dados.Add('***Funcao_Aciona_Guilhotina***');
         end;
      End;

      If Gerencial Then begin
         If ( iConta = 1 ) Then begin
            IniciaNovo := True;
         End else begin
            IniciaNovo := False;
         End;

         //S� fecha o relat�rio se for a ultima transa��o
         If TEF.nTransacoes = iConta Then begin
            FechaRelatorio := True;
         End else begin
            FechaRelatorio := False;

            Dados.Add(''); Dados.Add('');
            Dados.Add(''); Dados.Add('');
            Dados.Add(''); Dados.Add('');
            Dados.Add('');

            Dados.Add('***Funcao_Aciona_Guilhotina***');
         End;

         If Not ECF.Imprime_Nao_Fiscal(Dados,cErro,IniciaNovo,FechaRelatorio) Then begin
            Result := False;
         End;
      End else begin
         If Not ECF.Imprime_Comprovante_Vinculado(DadosComprovante,Dados,cErro) Then begin
            Result := False;
         End;
      End;
   Finally
      //Libera da mem�ria
      Dados.Free;

      //Se foi impresso com sucesso apaga o arquivo
      If Result Then begin
         If FileExists( 'IMPRIME' + inttostr( iConta ) + '.TXT' ) then
            DeleteFile( 'IMPRIME' + IntToStr( iConta ) + '.TXT' );

         //Verifica se possui alguma resposta e apaga
         If ( FileExists(TEF.DirResp + '\INTPOS.STS') ) then begin
            DeleteFile(TEF.DirResp + '\INTPOS.STS');
         End;

         If ( FileExists( TEF.DirResp + '\INTPOS.001' ) ) then
            DeleteFile( TEF.DirResp + '\INTPOS.001' );
      End;
   End;   
end;

///////////////////////////////////////
//
// Fun��o:
//    ConfirmaTransacao
// Objetivo:
//    Confirmar a Transa��o TEF pendente do TEF
// Retorno:
//    True para OK
//    False para n�o OK
//
//////////////////////////////////////
Function ConfirmaTransacao(): boolean;
//////////////////////////////////////
Var cLinhaArquivo, cConteudo, cNomeArquivo, cErro, cLinha:String;
    iTentativas, iConta:Integer;
    cArquivo:TextFile;
    lFlag:longbool;
begin
   If Verifica_Gerenciador_Tef() Then begin
      Result := True;
   End else begin
      Result := False;
      Exit;
   End;

   If ( FileExists( 'PENDENTE.TXT' ) ) then begin
      AssignFile( cArquivo, 'PENDENTE.TXT' );
      Reset( cArquivo );
      ReadLn( cArquivo, cLinha );
      CloseFile( cArquivo );

      iConta := StrToIntDef(cLinha,0);
   End else begin
      Exit;
   End;

   cLinhaArquivo := '';
   cConteudo     := '';
   lFlag         := False;

   If ( iConta > 0 ) then begin
      cNomeArquivo := TEF.DirTmp + '\INTPOS' + IntToStr( iConta ) + '.001';
   End else begin
      cNomeArquivo := TEF.DirResp + '\INTPOS.001';
   End;

   If FileExists( cNomeArquivo ) then begin
      AssignFile( cArquivo, cNomeArquivo );

      Reset( cArquivo );
      while not EOF( cArquivo ) do begin
         ReadLn( cArquivo, cLinhaArquivo );
         If ( copy( cLinhaArquivo, 1, 3 ) = '001' ) or
            ( copy( cLinhaArquivo, 1, 3 ) = '002' ) or
            ( copy( cLinhaArquivo, 1, 3 ) = '010' ) or
            ( copy( cLinhaArquivo, 1, 3 ) = '012' ) or
            ( copy( cLinhaArquivo, 1, 3 ) = '027' ) then begin

            cConteudo := cConteudo + cLinhaArquivo + #13 + #10;

         End;

         If ( copy( cLinhaArquivo, 1, 3 ) = '999' ) then begin
            cConteudo := cConteudo + cLinhaArquivo;
         End;
      End;
      CloseFile( cArquivo );

      cConteudo := '000-000 = CNF' + #13 + #10 + cConteudo;

      AssignFile( cArquivo, 'INTPOS.001' );
      ReWrite( cArquivo );
      WriteLn( cArquivo, cConteudo );
      CloseFile( cArquivo );
      CopyFile(pchar('INTPOS.001'),pchar(TEF.DirReq + '\INTPOS.001'),lFlag);
      DeleteFile( 'INTPOS.001' );

      //Aguarda a resposta do gerenciador padr�o em at� 8 segundos
      For iTentativas := 1 to 10 do begin
         If FileExists( TEF.DirResp + '\INTPOS.STS' ) then begin
            Break;
         End;

         sleep( 1000 );
      End;

      //O arquivo INTPOS.STS n�o retornou em 10 segundos, ent�o o operador � informado.
      If ( iTentativas > 10 ) then begin
         If TEF.AbreGerenciador Then begin
            Msg(True,'Gerenciador Padr�o n�o est� ativo ' + #13 +
                     'e ser� ativado autom�ticamente!');

            If Abrir_Gerenciador_Tef(cErro) Then begin
               Msg(False);
            End else begin
               Msg(False);
               MessageDlg(cErro,mtInformation,[mbOk],0);
            End;
         End else begin
            MessageDlg('Erro de Comunica��o - TEF.' + #13 +
                       'Favor Ativa-lo!!!',
                       mtInformation,[mbOk],0);
         End;

         Result := False;
         Exit;
      End;

      DeleteFile( TEF.DirResp + '\INTPOS.STS' );

      //Se a transa��o foi confirmada com sucesso
      //Incrementa o contador de confirmadas
      If Result Then begin
         Inc(TEF.nConfirmadas);
      End;
   End;

   //Apaga o arquivo que informa que possui uma transa��o pendente
   If ( FileExists( 'PENDENTE.TXT' ) ) then DeleteFile( 'PENDENTE.TXT' );
end;

////////////////////////////////////////
//
// Fun��o:
//    NaoConfirmaTransacao
// Objetivo:
//    N�o Confirmar a Transa��o TEF
// Par�metros:
//   Integer com o n�mero da transa��o
// Retorno:
//    True para OK
//    False para n�o OK
//
////////////////////////////////////////
Function NaoConfirmaTransacao():Boolean;
////////////////////////////////////////
var cLinhaArquivo, cConteudo, cCampoArquivo, cNomeArquivo, cNomeBackup, cErro: string;
    cValor, cNomeRede, cNSU, cLinha: string;
    cArquivo: TextFile;
    lFlag   : longbool;
    iTentativas, iConta: integer;
begin
   If Verifica_Gerenciador_Tef() Then begin
      Result := True;
   End else begin
      Result := False;
      Exit;
   End;

   If ( FileExists( 'PENDENTE.TXT' ) ) then begin
      AssignFile( cArquivo, 'PENDENTE.TXT' );
      Reset( cArquivo );
      ReadLn( cArquivo, cLinha );
      CloseFile( cArquivo );

      iConta := StrToIntDef(cLinha,0);
   End else begin
      Exit;
   End;

   DeleteFile( 'IMPRIME' + IntToStr( iConta ) + '.TXT' );

   cLinhaArquivo := '';
   cConteudo     := '';
   lFlag         := False;

   IF ( iConta > 0 ) Then begin
      If FileExists( TEF.DirResp + '\INTPOS.001' ) Then begin
         cNomeArquivo := TEF.DirResp + '\INTPOS.001';
      End else If FileExists( TEF.DirTmp + '\INTPOS' + IntToStr( iConta ) + '.001' ) then begin
         cNomeArquivo := TEF.DirTmp + '\INTPOS' + IntToStr( iConta ) + '.001';
      End else begin
         cNomeArquivo := '';
      End;

      cNomeBackup := TEF.DirTmp + '\INTPOS' + IntToStr( iConta ) + '.001';
   End else begin
      cNomeArquivo := TEF.DirResp + '\INTPOS.001';
   End;

   //Cancela a transa��o corrente
   If FileExists( cNomeArquivo ) then begin
      AssignFile( cArquivo, cNomeArquivo );
      Reset( cArquivo );

      while not EOF( cArquivo ) do begin
         ReadLn( cArquivo, cLinhaArquivo );
         cCampoArquivo := copy( cLinhaArquivo, 1, 3 );
         case StrToIntDef( cCampoArquivo, -1 ) of
            1: cConteudo := cConteudo + cLinhaArquivo + #13 + #10;
            3: cValor := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
            10:begin
               cConteudo := cConteudo + cLinhaArquivo + #13 + #10;
               cNomeRede := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
            end;
            12:begin
               cConteudo := cConteudo + cLinhaArquivo + #13 + #10;
               cNSU := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
            end;
            27: cConteudo := cConteudo + cLinhaArquivo + #13 + #10;
            999: cConteudo := cConteudo + cLinhaArquivo;
         end;
      end;

      CloseFile( cArquivo );

      cConteudo := '000-000 = NCN' + #13 + #10 + cConteudo;

      AssignFile( cArquivo, 'INTPOS.001' );
      ReWrite( cArquivo );
      WriteLn( cArquivo, cConteudo );
      CloseFile( cArquivo );
      CopyFile( pchar( 'INTPOS.001' ), pchar( TEF.DirReq + '\INTPOS.001' ), lFlag );
      DeleteFile( 'INTPOS.001' );

      //Aguarda a resposta do gerenciador padr�o em at� 10 segundos
      For iTentativas := 1 to 10 do begin
         If FileExists( TEF.DirResp + '\INTPOS.STS' ) then begin
            Break;
         End else begin
            sleep( 1000 );
         End;
      End;

      //O arquivo INTPOS.STS n�o retornou em 10 segundos, ent�o o operador � informado.
      If ( iTentativas > 10 ) then begin
         //If ( FileExists( DirReq + '\INTPOS.001' ) ) then
         //   DeleteFile( DirReq + '\INTPOS.001' );

         If TEF.AbreGerenciador Then begin
            Msg(True,'Gerenciador Padr�o n�o est� ativo ' + #13 +
                     'e ser� ativado autom�ticamente!');

            If Abrir_Gerenciador_Tef(cErro) Then begin
               Msg(False);
            End else begin
               Msg(False);
               MessageDlg(cErro,mtInformation,[mbOk],0);
            End;
         End else begin
            MessageDlg('Erro de Comunica��o - TEF.' + #13 +
                       'Favor Ativa-lo!!!',
                       mtInformation,[mbOk],0);
         End;

         Result := False;
         Exit;
      End;

      //Apaga o arquivo de resposta
      DeleteFile( TEF.DirResp + '\INTPOS.STS' );

      //Verifica se possui mais de uma transa��o pendente se n�o possui apaga
      // o arquivo TEF.txt
      IF ( iConta <= 1 ) Then begin
         //Se o arquivo TEF.TXT, que identifica que houve uma transa��o impressa
         //existir, o mesmo ser� exlu�do.
         if ( FileExists( 'TEF.TXT' ) ) then
            DeleteFile( 'TEF.TXT' );
      ENd;

      //Faz o foco voltar para aplica��o via Form
      If ( Screen.ActiveForm <> Nil ) Then begin
         mbFuncoes.ForceForegroundWindowForm(Screen.ActiveForm.Handle);
      End;

      //Apaga o arquivo de backup
      DeleteFile( cNomeArquivo );
      DeleteFile( cNomeBackup );

      //Apaga o arquivo que informa que possui uma transa��o pendente
      If ( FileExists( 'PENDENTE.TXT' ) ) then DeleteFile( 'PENDENTE.TXT' );

      //Aguarda 3 segundos o sistema operacional apagar o arquivo
      Sleep(3000);

      //Limpa o buffer do teclado e do mouse para mostrar a msg
      mbFuncoes.EmptyKeyQueue();
      mbFuncoes.EmptyMouseQueue();

      If ( cValor = '' ) Then begin
         cValor := '';
      End else begin
         cValor := 'Valor: ' + FormatFloat('##,##0.00',StrToFloatDef(cValor,0)/100 )
      End;

      MessageDlg('Cancelada a Transa��o' + #13 + #13 +
                 'Rede: ' + cNomeRede + #13 +
                 'Doc N�: ' + cNSU + #13 +
                 cValor,
                 mtInformation,[mbOk],0);
   End else begin
      //Apaga o arquivo que informa que possui uma transa��o pendente
      If ( FileExists( 'PENDENTE.TXT' ) ) then DeleteFile( 'PENDENTE.TXT' );
   End;
end;

//////////////////////////////////////////////////////////////////
//Procedimento utilizado para verificar e cancelar transa��es confirmadas
//Autor: Jo�o Paulo Francisco Bellucci
/////////////////////////////////////////////////////////////////
procedure VerificarCancelarTransacoesConfirmadas(iConta:Integer);
/////////////////////////////////////////////////////////////////
Var cHeader,cValor, cNomeRede, cNSU, cIdent, cData, cHora, cTipo,
    cTipoPessoa,cDocPessoa,cDataCheque:String;
    cLinhaArquivo, cConteudo, cCampoArquivo, cNomeArquivo: string;
    cArquivo: TextFile;
    iVezes:Integer;
    Continua:Boolean;
begin
   //Verifica se possui transacoes ja confirmadas para cancelar
   For iVezes := 1 to iConta do begin
      If FileExists( TEF.DirResp + '\INTPOS.001' ) Then begin
         cNomeArquivo := TEF.DirResp + '\INTPOS.001';
      End else If FileExists( TEF.DirTmp + '\INTPOS' + IntToStr( iVezes ) + '.001' ) then begin
         cNomeArquivo := TEF.DirTmp + '\INTPOS' + IntToStr( iVezes ) + '.001';
      End else begin
         cNomeArquivo := '';
      End;

      If FileExists( cNomeArquivo ) Then begin
         cLinhaArquivo := '';
         cConteudo     := '';
         cTipoPessoa   := '';
         cDocPessoa    := '';
         cDataCheque   := '';

         AssignFile( cArquivo, cNomeArquivo );

         Reset( cArquivo );
         While not EOF( cArquivo ) do begin
            ReadLn( cArquivo, cLinhaArquivo );
            cCampoArquivo := copy( cLinhaArquivo, 1, 3 );
            case StrToIntDef( cCampoArquivo, -1 ) of
               0:  cHeader     := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               1:  cIdent      := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               3:  cValor      := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               6:  cTipoPessoa := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               7:  cDocPessoa  := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               8:  cDataCheque := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               10: cNomeRede   := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               11: cTipo       := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               12: cNSU        := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               22: cData       := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
               23: cHora       := copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 );
            end;
         end;

         CloseFile( cArquivo );

         //Verifica se a transa��o � em cheque e n�o cancela a transa��o
         //confirmada
         If ( Trim(cHeader) = 'CHQ' ) Then begin
            Continua := False;
         End else begin
            Continua := True;
         End;

         While Continua do begin
            If CancelaTransacaoConfirmada( cIdent,
                                           cValor,
                                           cNomeRede,
                                           cTipo,
                                           cNSU,
                                           cData,
                                           cHora,
                                           cTipoPessoa,
                                           cDocPessoa,
                                           cDataCheque,
                                           iVezes ) Then begin

               If ( Screen.ActiveForm <> Nil ) Then begin
                  mbFuncoes.ForceForegroundWindowForm(Screen.ActiveForm.Handle);
               End;

               Sleep(5000);

               Continua := False;
            End else begin
               Sleep(5000);
            End;
         End;
      End;
   end;

   //Se o arquivo TEF.TXT, que identifica que houve uma transa��o impressa
   //existir, o mesmo ser� exlu�do.
   if ( FileExists( 'TEF.TXT' ) ) then
      DeleteFile( 'TEF.TXT' );
   
end;


////////////////////////////////////////////////////////////////////////////////
// Fun��o: CancelaTransacaoConfirmada
// Objetivo: Cancelar uma transa��o j� confirmada
// Par�metros: String com o n�mero de identifica��o (NSU)
//             String com o valor da transa��o
//             String com o nome e bandeira (REDE)
//             String com o n�mero do documento
//             String com a data da transa��o no formato DDMMAAAA
//             String com a hora da transa��o no formato HHSMMSS
//             Integer com o numero da transa��o
// Retorno: True para OK ou False para n�o OK
/////////////////////////////////////////////////////////////////////////////////
Function CancelaTransacaoConfirmada(cNSU,cValor,cNomeRede,cTipo,cNumeroDOC,
                                    cData,cHora,cTipoPessoa,cDocPessoa,
                                    cDataCheque:String; iVezes: integer):Boolean;
/////////////////////////////////////////////////////////////////////////////////
var cConteudo:String;
    cArquivo: TextFile;
    iConta:Integer;
    lFlag:longbool;
begin
    Result := False;
    lFlag  := False;
    
    If Not Verifica_Gerenciador_Tef() Then begin
       Exit;
    End;

    //Apaga os arquivos de resposta se possuir
    If ( FileExists( TEF.DirResp + '\INTPOS.STS' ) ) then
        DeleteFile( TEF.DirResp + '\INTPOS.STS' );

    If ( FileExists( TEF.DirResp + '\INTPOS.001' ) ) then
        DeleteFile( TEF.DirResp + '\INTPOS.001' );

    //Soma o n�mero de transacoes
    iConta := TEF.nTransacoes + 1;

    If ( cTipo <> '' ) Then begin
       cTipo := '011-000 = ' + cTipo + #13 + #10;
    End;

    If ( cTipoPessoa <> '' ) Then begin
       cTipoPessoa := '006-000 = ' + cTipoPessoa + #13 + #10;
    End;

    If ( cDocPessoa <> '' ) Then begin
       cDocPessoa := '007-000 = ' + cDocPessoa + #13 + #10;
    End;

    If ( cDataCheque <> '' ) Then begin
       cDataCheque := '008-000 = ' + cDataCheque + #13 + #10;
    End;

    Try
       Try
          cConteudo := '';
          cConteudo := '000-000 = CNC'            + #13 + #10 +
                       '001-000 = ' + cNSU        + #13 + #10 +
                       '003-000 = ' + cValor      + #13 + #10 +
                                      cTipoPessoa +
                                      cDocPessoa  +
                                      cDataCheque +
                       '010-000 = ' + cNomeRede   + #13 + #10 +
                                      cTipo       +
                       '012-000 = ' + cNumeroDOC  + #13 + #10 +
                       '022-000 = ' + cData       + #13 + #10 +
                       '023-000 = ' + cHora       + #13 + #10 +
                       '999-999 = 0';

          AssignFile( cArquivo, 'INTPOS.001' );
          ReWrite( cArquivo );
          WriteLn( cArquivo, cConteudo );
          CloseFile( cArquivo );

          //Copia o arquivo para o diret�rio de requisi��o
          CopyFile(pchar('INTPOS.001'),pchar(TEF.DirReq + '\INTPOS.001'),lFlag );
          DeleteFile('INTPOS.001');

          If ( AguardaRespostaTEF(cNSU,iConta) <> 1 ) Then begin
             Result := False;
             Exit;
          End;

          Result := True;
       Except
          On E:Exception do begin
             MessageDlg('Erro ao criar arquivo INTPOS.001!!!' + #13 +
                        E.Message,mtError,[mbOK],0);
          End;
       End;
    Finally
       //Apaga o arquivo IntPos
       DeleteFile( TEF.DirResp + '\INTPOS.STS' );
    End;
end;

/////////////////////////////////////
//Fun��es Utilizadas para terminar as transa��es do TEF
//Autor: Jo�o Paulo Francisco Bellucci
/////////////////////////////////////
Function TerminaTransacaoTEF:Boolean;
/////////////////////////////////////
Var n:Integer;
begin
   If ( TEF.nTransacoes > 0 ) then begin
      For n := 1 to TEF.nTransacoes do begin
         If ( FileExists( TEF.DirTmp + '\INTPOS' + IntToStr(n) + '.001' ) ) then begin
            DeleteFile( TEF.DirTmp + '\INTPOS' + IntToStr(n) + '.001' );
         End;

         DeleteFile( TEF.DirTmp + '\CANCEL' + IntToStr(n) + '.001' );
         DeleteFile( 'IMPRIME' + IntToStr( n ) + '.TXT' );
      End;

      If ( FileExists( 'PENDENTE.TXT' ) ) then DeleteFile('PENDENTE.TXT');

      //Se o arquivo TEF.TXT, que identifica que houve uma transa��o impressa
      //existir, o mesmo ser� exclu�do.
      If ( FileExists( 'TEF.TXT' ) ) then DeleteFile( 'TEF.TXT' );
   End;

   //Zera o contador de transacoes
   TEF.nTransacoes  := 0;
   TEF.nConfirmadas := 0;
   
   Result := True;
End;


///////////////////////////////////////////////
//Fun��o Utilizada para verifica e cancelar transacoes pendentes
//Autor: Jo�o Paulo Francisco Bellucci
///////////////////////////////////////////////
Procedure VerificarCancelarTransacoesPendentes;
///////////////////////////////////////////////
Var cArquivo:TextFile;
    cLinha:String;
begin

   //Verifica se existe o arquivo TEF.TXT, indicando que houve uma queda de
   //energia e que existe uma transa��o pendente.
   If FileExists( 'TEF.TXT' ) then begin
      If FileExists( 'TEF.TXT' ) then begin
         AssignFile( cArquivo, 'TEF.TXT' );
         Reset( cArquivo );
         ReadLn( cArquivo, cLinha );
         CloseFile( cArquivo );

         //Indica o n�mero de transa��es para apagar os arquivos tempor�rios
         TEF.nTransacoes := StrToIntDef(cLinha,0);

         //Verifica se existe o arquivo que informa
         //que a transa��o esta pendente
         If FileExists( 'PENDENTE.TXT' ) then begin
            TEF.nConfirmadas := TEF.nTransacoes-1;
         End else begin
            TEF.nConfirmadas := TEF.nTransacoes;
         End;

         If ( FileExists( 'PENDENTE.TXT' ) ) then begin
            NaoConfirmaTransacao();
         End;

         VerificarCancelarTransacoesConfirmadas(TEF.nTransacoes);
      End;
   End;

   //Termina as transa��es
   TerminaTransacaoTEF();
end;

///////////////////////////////////////////////////////////////////
// Fun��o:
//    FuncaoAdministrativaTEF
// Objetivo:
//    Chamar o m�dulo administrativo da bandeira
// Par�metro:
//    String com o identificador
// Retorno:
//    1 para OK
//    diferente de 1 para n�o OK
///////////////////////////////////////////////////////////////////
Function FuncaoAdministrativaTEF(cIdentificacao:TDateTime):Integer;
///////////////////////////////////////////////////////////////////
var cArquivo        : TextFile;
    lFlag           : longbool;
    cConteudoArquivo, cIdent: string;
begin
   If Not Verifica_Gerenciador_Tef() Then begin
      Result := 0;
      Exit;
   End;

   //Verifica se os arquivos de resposta ainda est�o no diret�rio e apaga
   If ( FileExists( TEF.DirResp + '\INTPOS.STS' ) ) then
      DeleteFile( TEF.DirResp + '\INTPOS.STS' );

   If ( FileExists( TEF.DirResp + '\INTPOS.001' ) ) then
      DeleteFile( TEF.DirResp + '\INTPOS.001' );

   //Cria o arquivo de solicita��o
   AssignFile( cArquivo, 'INTPOS.001');

   //Monta o identificador
   cIdent := FormatDateTime( 'hhmmss', cIdentificacao );

   // Conte�do do arquivo INTPOS.001 para solicitar a transa��o TEF
   cConteudoArquivo := '';
   cConteudoArquivo := '000-000 = ADM' + #13 + #10 +
                       '001-000 = ' + cIdent + #13 + #10 +
                       '999-999 = 0';
   ReWrite( cArquivo );
   WriteLn( cArquivo, cConteudoArquivo );
   CloseFile( cArquivo );

   lFlag := False;

   CopyFile(PChar( 'INTPOS.001' ),PChar( TEF.DirReq + '\INTPOS.001' ),lFlag);
   DeleteFile('INTPOS.001');

   MsgTEF('Aguarde, Abrindo modulo...',500);

   Result := AguardaRespostaTEF(cIdent,1);
end;

///////////////////////////////////////////////////
//Fun��o utilizada para aguardar reposta do TEF
//Retorno:
//   1 para Ok
//Autor: Jo�o Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////
Function AguardaRespostaTEF(cIdent:String;iConta:Integer):Integer;
//////////////////////////////////////////////////////////////////
var cErro, cLinhaArquivo, MsgRetorno, sDadosImp, cNomeArquivo:string;
    cArquivo:TextFile;
    iTentativas, iVezes, iErros, n:Integer;
    DadosImp : TStringList;
    bTransacao, Continua: boolean;
    lFlag:LongBool;
begin

   Result     := 0;
   DadosImp   := TStringList.Create;
   lFlag      := False;
   DadosImp.Clear;
   Try
      bTransacao := False;

      //Aguarda a resposta do gerenciador padr�o em at� 10 segundos
      For iTentativas := 1 to 10 do begin
         If FileExists( TEF.DirResp + '\INTPOS.STS' ) then begin
            Break;
         End else begin
            sleep( 1000 );
         End;
      End;

      //O arquivo INTPOS.STS n�o retornou em 10 segundos, ent�o o operador � informado.
      If ( iTentativas > 10 ) then begin
         If ( FileExists( TEF.DirReq + '\INTPOS.001' ) ) then
            DeleteFile( TEF.DirReq + '\INTPOS.001' );

         If TEF.AbreGerenciador Then begin
            Msg(True,'Gerenciador Padr�o n�o est� ativo ' + #13 +
                     'e ser� ativado autom�ticamente!');

            If Abrir_Gerenciador_Tef(cErro) Then begin
               Msg(False);
            End else begin
               Msg(False);
               MessageDlg(cErro,mtInformation,[mbOk],0);
            End;
         End else begin
            MessageDlg('Erro de Comunica��o - TEF.' + #13 +
                       'Favor Ativa-lo!!!',
                       mtInformation,[mbOk],0);
         End;

         Result := -3;
         Exit;
      End;

      cLinhaArquivo := '';
      iErros        := 0;
      MsgRetorno    := '';
      while True do begin
         //Processa as msg do windows
         Application.ProcessMessages;
         
         // Verifica o arquivo INTPOS.001 de resposta
         If FileExists( TEF.DirResp + '\INTPOS.001' ) then begin
            //Se recebeu a resposta apaga o arquivo de requisi��o
            //Bug do gerenciador do TEF que n�o apaga o arquivo de
            //requisi��o quando � clicado no bot�o '9' para sair
            //s� apaga se pressionar '9', na homologa��o tem que tirar essa linha
            If ( FileExists( TEF.DirReq + '\INTPOS.001' ) ) then begin
               DeleteFile( TEF.DirReq + '\INTPOS.001' );
            End;

            Try
               AssignFile( cArquivo, TEF.DirResp + '\INTPOS.001' );
               Reset( cArquivo );
               While not EOF( cArquivo ) do begin
                  ReadLn( cArquivo, cLinhaArquivo );


                  //Verifica se o campo de identifica��o � o mesmo do solicitado.
                  If ( copy( cLinhaArquivo, 1, 3 ) = '001' ) then begin
                     If ( copy( cLinhaArquivo, 11, Length( cLinhaArquivo ) - 10 ) = cIdent ) then begin
                        Result := 0;
                     End else begin
                        //Fecha o arquivo
                        CloseFile( cArquivo );
                        Sleep(1000);
                        DeleteFile( TEF.DirResp + '\INTPOS.001' );
                        Result := -2;
                        Break;
                     End;
                  End else If ( copy( cLinhaArquivo, 1, 3 ) = '009' ) then begin
                     // Verifica se a Transa��o foi Aprovada
                     If ( copy( cLinhaArquivo, 11,Length( cLinhaArquivo ) - 10 ) ) = '0' then begin
                        bTransacao := True;
                     End else begin
                        bTransacao := False
                     End;
                  End else If ( copy( cLinhaArquivo, 1, 3 ) = '028' ) then begin
                     // Verifica se existem linhas para serem
                     // impressas
                     If ( StrToInt( copy( cLinhaArquivo, 11,Length( cLinhaArquivo ) - 10 ) ) <> 0 ) and
                           ( bTransacao = True ) then begin
                        Result := 1; // OK
                        For iVezes := 1 to StrToInt(Copy(cLinhaArquivo,11,Length(cLinhaArquivo)-10)) do begin
                            ReadLn( cArquivo,cLinhaArquivo );

                            //Verifica se o campo � 029 e armazena as linhas que ser�o impressas
                            If copy( cLinhaArquivo, 1, 3 ) = '029' then begin
                               DadosImp.Add(copy(cLinhaArquivo, 12, Length(cLinhaArquivo)-12));
                            End;
                        End;
                     End;
                  End else If ( copy( cLinhaArquivo,1,3 ) = '030' ) Then begin
                     // Verifica se o campo � o 030 para mostrar a
                     // mensagem para o operador
                     MsgRetorno := copy(cLinhaArquivo,11,Length( cLinhaArquivo )-10);
                  End;
               End;

               //Se o identificador veio correto sai do while
               If Result <> -2 Then Break;
            Except
               On E:Exception do begin
                  //Incrementa o contador de erros
                  Inc(iErros);

                  //Aguarda o sistema liberar o arquivo
                  Sleep(100);

                  If ( iErros >= 10 ) Then begin
                     iErros := 0;
                     MessageDlg('Erro na leitura do arquivo INTPOS.001!!!' + #13 +
                                E.Message + #13 +
                                'Tente novamente.',mtError,[mbOk],0);
                  End;
               End;
            End;
         End;

      End;

      //Fecha o arquivo
      CloseFile( cArquivo );

      If ( Screen.ActiveForm <> Nil ) Then begin
         mbFuncoes.ForceForegroundWindowForm(Screen.ActiveForm.Handle);
      End;

      //Verifica se o TEF retornou algum arquivo para ser impresso na ECF
      If ( DadosImp.Count > 0 ) then begin
         //Cria o arquivo tempor�rio informando que existe uma transa��o
         //pendente de confirma��o
         AssignFile( cArquivo, 'PENDENTE.TXT' );
         ReWrite( cArquivo );
         WriteLn( cArquivo, inttostr( iConta ) );
         CloseFile( cArquivo );

         cNomeArquivo := TEF.DirTmp+'\INTPOS'+IntToStr(iConta)+'.001';

         //� realizada uma c�pia tempor�ria do arquivo INTPOS.001 para cada transa��o efetuada.
         //Caso a transa��o necessite ser cancelada, as informa��es estar�o neste arquivo.
         CopyFile(pchar(TEF.DirResp+'\INTPOS.001'),pchar(cNomeArquivo),lFlag);

         //Atualiza o n�mero de transacoes realizadas
         TEF.nTransacoes := iConta;

         // Neste ponto � criado o arquivo TEF.TXT, indicando que h� uma
         // opera��o de TEF sendo realizada. Caso ocorra uma queda de energia,
         // no momento da impress�o do TEF, e a aplica��o for inicializada,
         // ao identificar a exist�ncia deste arquivo, a transa��o do TEF
         // dever� ser concelada.
         Try
            AssignFile( cArquivo, 'TEF.TXT');
            Try
               ReWrite( cArquivo );
               WriteLn( cArquivo, IntToStr(iConta) );
            Finally
               CloseFile( cArquivo );
            End;
         Except
            On E:Exception do begin
               MessageDlg('Erro ao criar o arquivo TEF.TXT' + #13 +
                          E.Message, mtError,[mbOk],0);
            End;
         End;

         If ( MsgRetorno <> '' ) Then begin
            Msg(True,MsgRetorno);
         End;
         ECF.Inicia_Modo_TEF;
         Try
            //Pula as linhas
            DadosImp.Add(''); DadosImp.Add(''); DadosImp.Add('');
            DadosImp.Add(''); DadosImp.Add(''); DadosImp.Add('');
            DadosImp.Add('');

            //Salva os dados originais das impress�es
            sDadosImp := DadosImp.Text;
            DadosImp.Clear;
            For n := 1 to TEF.NumeroVias do begin
               DadosImp.Text := DadosImp.Text + sDadosImp;

               If ( n < TEF.NumeroVias ) Then begin
                  DadosImp.Add('***Funcao_Aciona_Guilhotina***');
               End;
            End;

            Continua := True;
            While Continua do begin
               If ECF.Imprime_Nao_Fiscal(DadosImp,cErro) Then begin
                  Continua := False;
               End else begin
                  Msg(False);
                  ECF.Finaliza_Modo_TEF;
                  If ( MessageDlg('Impressora n�o responde!!!' + #13 +
                                  'Tentar novamente???',mtError,[mbYes,mbNo],0) = mrNo ) Then begin
                     Result := -1;
                     Exit;
                  End;
                  ECF.Inicia_Modo_TEF;
                  If ( MsgRetorno <> '' ) Then begin
                     Msg(True,MsgRetorno);
                  End;
               End;
            End;
         Finally
            If ( Result = 1 ) Then begin
               //Confirma que a impress�o foi ok
               ConfirmaTransacao();
            End else begin
               //N�o confirma que a impress�o foi ok
               NaoConfirmaTransacao();
            End;

            //Se for um unica transa��o e j� foi confirmada ou n�o confirmada
            //apaga o arquivo TEF.txt
            If ( iConta = 1 ) Then begin
               //Se o arquivo TEF.TXT, que identifica que houve uma transa��o impressa
               //existir, o mesmo ser� exclu�do.
               If ( FileExists( 'TEF.TXT' ) ) then DeleteFile( 'TEF.TXT' );

               TEF.nTransacoes  := 0;
               TEF.nConfirmadas := 0;
            End;

            //Verifica se o arquivo tempor�rio existe e apaga
            If ( FileExists( cNomeArquivo ) ) then
                 DeleteFile( cNomeArquivo );

            Sleep(3000);
                 
            Msg(False);
            ECF.Finaliza_Modo_TEF;
         End;
      End else begin
         //Verifica se deve mostrar a msg esperando enter do operador
         If ( MsgRetorno <> '' ) Then begin
            Application.ProcessMessages;
            MessageDlg(MsgRetorno,mtInformation,[mbOk],0);
         End;
      End;
   Finally
      //Tira o objeto da mem�ria
      DadosImp.Free;

      if ( FileExists( TEF.DirResp + '\INTPOS.STS' ) ) then
           DeleteFile( TEF.DirResp + '\INTPOS.STS' );

      if ( FileExists( TEF.DirResp + '\INTPOS.001' ) ) then
           DeleteFile( TEF.DirResp + '\INTPOS.001' );
   End;
end;

end.
