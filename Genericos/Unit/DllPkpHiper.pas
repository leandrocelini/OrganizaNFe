unit DllPkpHiper;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Funcoes;

function AbrirDll:Boolean;
procedure FecharDll;
function AlocarRecursos(MsgRetorno:PChar;TamMsg:Integer):Integer;
function AtualizarConexaoEstacao(MsgRetorno:PChar;TamMsg:Integer):Integer;
function ValidarTicket(CodBarras:PChar;TamCod:Integer;ValorDesc:Single;
                       TempoDesc:Integer;MsgRetorno:PChar;TamMsg:Integer):Integer;
function DesalocarRecursos(MsgRetorno:PChar;TamMsg:Integer):Integer;

Var HDll:THandle;

implementation

//////////////////////////
//Fun��o utilizada para abrir a dll
//Autor: Jo�o Paulo Francisco Bellucci
//////////////////////////
Function AbrirDll:Boolean;
//////////////////////////
Begin
   HDll := LoadLibrary(PChar('PkpHiper.dll'));

   If ( HDll = 0 ) Then begin
      Result := False;
   End else begin
      Result := True;
   End;
End;

////////////////////
//Fun��o Utilizada para Fechar a Dll
//Autor: Jo�o Paulo Francisco Bellucci
////////////////////
Procedure FecharDll;
////////////////////
Begin
   FreeLibrary(HDll);
End;

/////////////////////////////////////////////////////////////////
//Parametros:
//           MsgRetorno � Ponteiro para uma cadeia de caracteres que a fun��o
//                        preencher� com a descri��o do c�digo de retorno.
//           TamMsg � Espa�o em Bytes alocado para o ponteiro MsgRetorno.
//Retorno:
//	       0 � �Esta��o Ativada�
//	       1 � �Esta��o J� Carregada�
//	       2 � �N�O Habilitou Socket TCP�
//	       3 � �Configura��es Inv�lidas�
//	       4 � �Esta��o N�O Configurada�
//	       5 � �Erro na Conex�o com o BD�
/////////////////////////////////////////////////////////////////
function AlocarRecursos(MsgRetorno:PChar;TamMsg:Integer):Integer;
/////////////////////////////////////////////////////////////////
Var
   CallDll:function(MsgRetorno:PChar;TamMsg:Integer):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'AlocarRecursos');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(MsgRetorno,TamMsg);
   End;
end;

//////////////////////////////////////////////////////////////////////////
//Retorno:
//	       0 � �Conex�o Atualizada�
//	       1 � �Esta��o N�O Carregada�
//        2 � �Erro na Conex�o com o BD�
//////////////////////////////////////////////////////////////////////////
function AtualizarConexaoEstacao(MsgRetorno:PChar;TamMsg:Integer):Integer;
//////////////////////////////////////////////////////////////////////////
Var
   CallDll:function(MsgRetorno:PChar;TamMsg:Integer):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'AtualizarConexaoEstacao');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(MsgRetorno,TamMsg);
   End;
end;

//////////////////////////////////////////////////////////////////////////////////
//Parametros:
//           CodBarras � Ponteiro para uma cadeia de caracteres que deve conter
//                       somente o valor do C�digo de Barras do ticket do
//                       estacionamento (atuais 12 caracteres).
//	          TamCod � Espa�o em Bytes alocado para o ponteiro CodBarras.
//	          ValorDesc � Valor da tarifa a ser descontado. Caso seja
//                       menor ou igual a 0(zero), o desconto ser� por
//                       tempo de perman�ncia.
//	          TempoDesc � Tempo em minutos de toler�ncia para sa�da gr�tis
//                       em rela��o a data de entrada do ticket. Caso seja
//                       menor ou igual a 0(zero), o desconto ser� em valor.
//	                      OBS: Caso os dois valores (ValorDesc e TempoDesc)
//                       passados para a fun��o sejam menores ou iguais
//                       a 0(zero), o Sistema Parking Plus usar� um valor
//                       padr�o de desconto configurado no Parking Plus Manager.
//	          MsgRetorno � Ponteiro para uma cadeia de caracteres que a fun��o
//                        preencher� com a descri��o do c�digo de retorno.
//	          TamMsg � Espa�o em Bytes alocado para o ponteiro MsgRetorno.
//Retorno
//	     0 � �Ticket Abonado�
//	     1 � �Ticket Abonado Parcialmente�
//	     2 � �Abono Inv�lido�
//	     3 � �Ticket Processado�
//	     4 � �Erro na Conex�o com o BD�
//	     5 � �C�digo de Barras Inv�lido�
//	     6 � �Esta��o N�O carregada�
//////////////////////////////////////////////////////////////////////////////////
function ValidarTicket(CodBarras:PChar;TamCod:Integer;ValorDesc:Single;
                       TempoDesc:Integer;MsgRetorno:PChar;TamMsg:Integer):Integer;
//////////////////////////////////////////////////////////////////////////////////
Var
   CallDll:function(CodBarras:PChar;TamCod:Integer;ValorDesc:Single;
                    TempoDesc:Integer;MsgRetorno:PChar;TamMsg:Integer):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ValidarTicket');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(CodBarras,TamCod,ValorDesc,TempoDesc,MsgRetorno,TamMsg);
   End;
end;

////////////////////////////////////////////////////////////////////
//Parametros:
//           MsgRetorno � Ponteiro para uma cadeia de caracteres que a fun��o
//                        preencher� com a descri��o do c�digo de retorno.
//	          TamMsg � Espa�o em Bytes alocado para o ponteiro MsgRetorno.
//Retorno
//	      0 � �Esta��o Desativada�
//	      1 � �Esta��o N�O carregada�
////////////////////////////////////////////////////////////////////
function DesalocarRecursos(MsgRetorno:PChar;TamMsg:Integer):Integer;
////////////////////////////////////////////////////////////////////
Var
   CallDll:function(MsgRetorno:PChar;TamMsg:Integer):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'DesalocarRecursos');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(MsgRetorno,TamMsg);
   End;
End;

end.
