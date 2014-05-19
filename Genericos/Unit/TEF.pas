unit TEF;

interface

Uses Windows, SysUtils, Forms, Db, Dialogs, Classes, ExtCtrls, Controls,
     ShellApi, mbDialogo;

Type TTipoTEF = (ttDiscado,ttSiTef);
Type TDadosTEF = Record
                    Identificacao:TDateTime;
                    NumeroCupom:String;
                    FormaPagamento:String;
                    TipoFormaPg:String;
                    Fk_FormaPg:Integer;
                    Valor:Currency;
                    ValorSaque:Currency;
                    TipoTransacao:String;
                    NomeRede:String;
                    MsgRetorno:String;
                    MsgUser:String;
                    Comprovante:String;
                 End;

Var NomeExeTef,DirReq,DirResp,DirTmp:String;
    NumeroVias:Integer;
    nTransacoes:Integer;
    nConfirmadas:Integer;
    AbreGerenciador:Boolean;
    TEFAtivo:Boolean;
    TipoTEF:TTipoTEF;
    DadosTransacoes:Array[1..10] Of TDadosTEF;

Procedure Seleciona_Tipo_Tef(sTipoTef:String);
Function Abrir_Gerenciador_Tef(Var Erro:String):Boolean;
Function Verifica_Gerenciador_Tef():Boolean;
Function RealizaTransacao(Var DadosTEF:TDadosTEF):Integer;
Function ConfirmaTransacao():Boolean;
Procedure ConfirmaImprimeTransacaoPendente();
Function ImprimeTransacao(iConta:Integer;Gerencial:Boolean):Boolean;
Function NaoConfirmaTransacao():Boolean;
procedure VerificarCancelarTransacoesConfirmadas(iConta:Integer);
Function CancelaTransacaoConfirmada(cNSU,cValor,cNomeRede,cTipo,cNumeroDOC,
                                    cData,cHora,cTipoPessoa,cDocPessoa,
                                    cDataCheque:String; iVezes: integer):Boolean;
Function TerminaTransacaoTEF:Boolean;
Procedure VerificarCancelarTransacoesPendentes;
Function FuncaoAdministrativaTEF(cIdentificacao:TDateTime):Integer;
procedure MsgTEF(Texto:String;Tempo:Integer=1000);

implementation

uses ECF, mbFuncoes, MsgEspera, TefDiscado, SiTef;

//////////////////////////////////////////////
Procedure Seleciona_Tipo_Tef(sTipoTef:String);
//////////////////////////////////////////////
begin
   sTipoTef := UpperCase(sTipoTef);
   If ( sTipoTef = 'DISCADO' ) Then begin
      TipoTEF := ttDiscado;
   End else If ( sTipoTef = 'SITEF' ) Then begin
      TipoTEF := ttSiTef;
   End else begin
      TipoTEF := ttDiscado;
   End;
end;

////////////////////////////////////////////////////////
Function Abrir_Gerenciador_Tef(Var Erro:String):Boolean;
////////////////////////////////////////////////////////
Begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.Abrir_Gerenciador_Tef(Erro);
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.Abrir_Gerenciador_Tef(Erro);
   End else begin
      Result := TefDiscado.Abrir_Gerenciador_Tef(Erro);
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
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.Verifica_Gerenciador_Tef();
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.Verifica_Gerenciador_Tef;
   End else begin
      Result := TefDiscado.Verifica_Gerenciador_Tef();
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
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.RealizaTransacao(DadosTEF);
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.RealizaTransacao(DadosTEF);
   End else begin
      Result := TefDiscado.RealizaTransacao(DadosTEF);
   End;
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
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.ImprimeTransacao(iConta,Gerencial);
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.ImprimeTransacao(iConta,Gerencial);
   End else begin
      Result := TefDiscado.ImprimeTransacao(iConta,Gerencial);
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
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.ConfirmaTransacao();
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.ConfirmaTransacao();
   End else begin
      Result := TefDiscado.ConfirmaTransacao();
   End;
end;

/////////////////////////////////////////////
//Fun��o utilizada para confirmar e imprimir transa��o pendente
//Autor: Jo�o Paulo F. Bellucci
/////////////////////////////////////////////
Procedure ConfirmaImprimeTransacaoPendente();
/////////////////////////////////////////////
begin
   If ( TipoTEF = ttSiTef ) Then begin
      SiTef.ConfirmaTransacao(True);
   End;
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
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.NaoConfirmaTransacao();
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.NaoConfirmaTransacao();
   End else begin
      Result := TefDiscado.NaoConfirmaTransacao();
   End;
end;

//////////////////////////////////////////////////////////////////
//Procedimento utilizado para verificar e cancelar transa��es confirmadas
//Autor: Jo�o Paulo Francisco Bellucci
/////////////////////////////////////////////////////////////////
procedure VerificarCancelarTransacoesConfirmadas(iConta:Integer);
/////////////////////////////////////////////////////////////////
begin
   If ( TipoTEF = ttDiscado ) then begin
      TefDiscado.VerificarCancelarTransacoesConfirmadas(iConta);
   End else If ( TipoTEF = ttSiTef ) Then begin
      SiTef.VerificarCancelarTransacoesConfirmadas(iConta);
   End else begin
      TefDiscado.VerificarCancelarTransacoesConfirmadas(iConta);
   End;
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
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.CancelaTransacaoConfirmada(cNSU,cValor,cNomeRede,cTipo,cNumeroDOC,cData,cHora,
                                                      cTipoPessoa,cDocPessoa,cDataCheque,iVezes);
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.CancelaTransacaoConfirmada(cNSU,cValor,cNomeRede,cTipo,cNumeroDOC,cData,cHora,
                                                 cTipoPessoa,cDocPessoa,cDataCheque,iVezes);
   End else begin
      Result := TefDiscado.CancelaTransacaoConfirmada(cNSU,cValor,cNomeRede,cTipo,cNumeroDOC,cData,cHora,
                                                      cTipoPessoa,cDocPessoa,cDataCheque,iVezes);
   End;
end;

/////////////////////////////////////
//Fun��es Utilizadas para terminar as transa��es do TEF
//Autor: Jo�o Paulo Francisco Bellucci
/////////////////////////////////////
Function TerminaTransacaoTEF:Boolean;
/////////////////////////////////////
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.TerminaTransacaoTEF();
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.TerminaTransacaoTEF();
   End else begin
      Result := TefDiscado.TerminaTransacaoTEF();
   End;
End;


///////////////////////////////////////////////
//Fun��o Utilizada para verifica e cancelar transacoes pendentes
//Autor: Jo�o Paulo Francisco Bellucci
///////////////////////////////////////////////
Procedure VerificarCancelarTransacoesPendentes;
///////////////////////////////////////////////
begin
   If ( TipoTEF = ttDiscado ) then begin
      TefDiscado.VerificarCancelarTransacoesPendentes();
   End else If ( TipoTEF = ttSiTef ) Then begin
      SiTef.VerificarCancelarTransacoesPendentes();
   End else begin
      TefDiscado.VerificarCancelarTransacoesPendentes();
   End;
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
begin
   If ( TipoTEF = ttDiscado ) then begin
      Result := TefDiscado.FuncaoAdministrativaTEF(cIdentificacao);
   End else If ( TipoTEF = ttSiTef ) Then begin
      Result := SiTef.FuncaoAdministrativaTEF(cIdentificacao);
   End else begin
      Result := TefDiscado.FuncaoAdministrativaTEF(cIdentificacao);
   End;
end;

//////////////////////////////////////////////////
//Procedimento Utilizado para mostrar a mensagem do TEF
//Autor: Jo�o Paulo Francisco Bellucci
//////////////////////////////////////////////////
procedure MsgTEF(Texto:String;Tempo:Integer=1000);
//////////////////////////////////////////////////
Var cMensagem:TForm;
    n:Integer;
Begin
   cMensagem := TForm.Create( Nil );
   With cMensagem do begin
      With TPanel.Create( Nil ) do begin
         Parent := cMensagem;
         Align := alClient;
         cMensagem.Font.Size := 15;
         Caption := Texto;
         BevelWidth := 5;
      End;

      BorderStyle := bsNone;
      BorderIcons := [];
      Font.Size := 15;
      Height := 100;
      Width := Canvas.TextWidth(Texto) + 60;
      Position := poScreenCenter;
      Show;
      Refresh;

      //Aguarda o tempo informado
      For n := 1 To 10 do begin
         //Manda o form para frente
         Refresh;
         SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,0);
         SleepEx(Round(Tempo/10),True);
      End;

      Close;
      Free;
   End;
End;

end.
