unit Estacionamento;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Funcoes, DllPkpHiper;

function HabilitaEstacionamento(Var Erro:String):Boolean;
function ValidarTicketEstacionamento(Codigo:String;Var MsgRetorno:String):Boolean;
function AtualizaConexao(Var Erro:String):Boolean;
function DesabilitaEstacionamento(Var Erro:String):Boolean;

Var TempoTolerancia:Integer;

implementation

/////////////////////////////////////////////////////////
//Função utilizada para habilitar a comunicação com o programa do estacionamento
//Autor: João Paulo Francisco Bellucci
/////////////////////////////////////////////////////////
function HabilitaEstacionamento(Var Erro:String):Boolean;
/////////////////////////////////////////////////////////
Var MsgRetorno:PChar;
Begin
   //Inicializa o retorno
   Result := False;

   If Not DllPkpHiper.AbrirDll Then begin
      Erro := 'Não foi possível abrir a PkpHiper.dll';
      Exit;
   End;

   MsgRetorno := PChar(Space(50));
   If DllPkpHiper.AlocarRecursos(MsgRetorno,50) = 0 Then begin
      Erro   := '';
      Result := True;
   End else begin
      Erro := MsgRetorno;
   End;
End;

//////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para validar o tickat de estacionamento
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////////////
function ValidarTicketEstacionamento(Codigo:String;Var MsgRetorno:String):Boolean;
//////////////////////////////////////////////////////////////////////////////////
Var nRetorno,nTamCod:Integer;
    PMsgRetorno:PChar;
    PCodigo:PChar;
Begin

   Result := False;

   If ( Trim(Codigo) = '' ) Then begin
      MsgRetorno   := 'Código vazio!!!';
   End;

   //Inicializa a Msg de Retorno
   PMsgRetorno := PChar(Space(50));

   //Verifica o tamanho do código
   nTamCod := Length(Codigo);

   PCodigo := PChar(Codigo);

   nRetorno := DllPkpHiper.ValidarTicket(PCodigo,
                                         nTamCod,
                                         0,
                                         TempoTolerancia,
                                         PMsgRetorno,
                                         50);

   MsgRetorno := PMsgRetorno;
   If ( nRetorno = 0 ) Then begin
      MsgRetorno := 'Ticket abonado !';
      Result := True;
   End else If ( nRetorno = 1 ) Then begin
      MsgRetorno := 'Pague o restante no caixa do Estacionamento.';
   End else If ( nRetorno = 2 ) Then begin
      MsgRetorno := 'Este ticket já foi validado anteriormente.';
   End else If ( nRetorno = 3 ) Then begin
      MsgRetorno := 'Este ticket já foi utilizado anteriormente.';
   End else If ( nRetorno = 4 ) Then begin
      MsgRetorno := 'Problemas de conexão com o banco de dados do Estacionamento.' + #13 +
		              'Após sanar o problema, reinicie este computador.';
   End else If ( nRetorno = 5 ) Then begin
      MsgRetorno := 'Não é um ticket válido de Estacionamento.';
   End else If ( nRetorno = 6 ) Then begin
      MsgRetorno := 'A função AlocarRecursos não foi chamada, ou retornou erro.' + #13 +
                    'Reinicie este computador.';
   End;
End;

///////////////////////////////////////////////////////////
//Função utilizada para desabilitar a comunicação com o programa de estacionamento
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////
function DesabilitaEstacionamento(Var Erro:String):Boolean;
///////////////////////////////////////////////////////////
Var MsgRetorno:PChar;
Begin
   //Inicializa o retorno
   Result := False;

   MsgRetorno := PChar(Space(50));
   If DllPkpHiper.DesalocarRecursos(MsgRetorno,50) = 0 Then begin
      Erro   := '';
      Result := True;
   End else begin
      Erro := MsgRetorno;
   End;

   DllPkpHiper.FecharDll();
End;

//////////////////////////////////////////////////
//Função utilizada para atualizar a conexão com o servidor
//do estacionamento
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////
function AtualizaConexao(Var Erro:String):Boolean;
//////////////////////////////////////////////////
Var PMsgRetorno:PChar;
begin
   PMsgRetorno := PChar(Space(50));
   If ( DllPkpHiper.AtualizarConexaoEstacao(PMsgRetorno,50) <> 0 ) Then begin
      Erro := PMsgRetorno;
      Result := False;
   End else begin
      Result := True;
   End;
end;

end.
