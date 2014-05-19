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
//Função utilizada para abrir a dll
//Autor: João Paulo Francisco Bellucci
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
//Função Utilizada para Fechar a Dll
//Autor: João Paulo Francisco Bellucci
////////////////////
Procedure FecharDll;
////////////////////
Begin
   FreeLibrary(HDll);
End;

/////////////////////////////////////////////////////////////////
//Parametros:
//           MsgRetorno – Ponteiro para uma cadeia de caracteres que a função
//                        preencherá com a descrição do código de retorno.
//           TamMsg – Espaço em Bytes alocado para o ponteiro MsgRetorno.
//Retorno:
//	       0 – “Estação Ativada”
//	       1 – “Estação JÁ Carregada”
//	       2 – “NÃO Habilitou Socket TCP”
//	       3 – “Configurações Inválidas”
//	       4 – “Estação NÃO Configurada”
//	       5 – “Erro na Conexão com o BD”
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
//	       0 – “Conexão Atualizada”
//	       1 – “Estação NÃO Carregada”
//        2 – “Erro na Conexão com o BD”
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
//           CodBarras – Ponteiro para uma cadeia de caracteres que deve conter
//                       somente o valor do Código de Barras do ticket do
//                       estacionamento (atuais 12 caracteres).
//	          TamCod – Espaço em Bytes alocado para o ponteiro CodBarras.
//	          ValorDesc – Valor da tarifa a ser descontado. Caso seja
//                       menor ou igual a 0(zero), o desconto será por
//                       tempo de permanência.
//	          TempoDesc – Tempo em minutos de tolerância para saída grátis
//                       em relação a data de entrada do ticket. Caso seja
//                       menor ou igual a 0(zero), o desconto será em valor.
//	                      OBS: Caso os dois valores (ValorDesc e TempoDesc)
//                       passados para a função sejam menores ou iguais
//                       a 0(zero), o Sistema Parking Plus usará um valor
//                       padrão de desconto configurado no Parking Plus Manager.
//	          MsgRetorno – Ponteiro para uma cadeia de caracteres que a função
//                        preencherá com a descrição do código de retorno.
//	          TamMsg – Espaço em Bytes alocado para o ponteiro MsgRetorno.
//Retorno
//	     0 – “Ticket Abonado”
//	     1 – “Ticket Abonado Parcialmente”
//	     2 – “Abono Inválido”
//	     3 – “Ticket Processado”
//	     4 – “Erro na Conexão com o BD”
//	     5 – “Código de Barras Inválido”
//	     6 – “Estação NÃO carregada”
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
//           MsgRetorno – Ponteiro para uma cadeia de caracteres que a função
//                        preencherá com a descrição do código de retorno.
//	          TamMsg – Espaço em Bytes alocado para o ponteiro MsgRetorno.
//Retorno
//	      0 – “Estação Desativada”
//	      1 – “Estação NÃO carregada”
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
