unit DllTerminal;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Funcoes;

function AbrirDll(Nome:String):Boolean;
procedure FecharDll;
function ConfigLpt(Endereco, Timeout:Word):Integer;
procedure Dll_PosCur(Terminal, Lin, Col: Byte);
procedure Dll_Clear(Terminal:Byte);
procedure Dll_Echo(Terminal:Byte;Dado:char);
procedure Dll_Display(Terminal:Byte;Dado:string);
function Dll_Get(Terminal:Byte):char;
function Dll_Status(Terminal:Byte):Byte;
function Dll_Print(Terminal:Byte;Dado:String):Byte;
function Dll_Serial(Terminal:Byte;Dado:String):Byte;
function Dll_Acesso(Cmd:string):Integer;
function Dll_Versao:String;
function Liga_Interface_USB(Var Erro:String):Boolean;
Function Liga_Interface_TCP(Var Erro:String):Boolean;
procedure Desliga_Interface_USB;
procedure Desliga_Interface_TCP;
function Dll_LogReset:Integer;
function Dll_LogTerminal(Terminal:Byte):Integer;
Function Numero_Conexoes_Ativas_TCP:Integer;
Function Dados_Conexoes_TCP(nConexao:Integer;pDados:PChar):Boolean;

Var HDll:THandle; NomeDll:String;

implementation

///////////////////////////////////////
Function AbrirDll(Nome:String):Boolean;
///////////////////////////////////////
Begin
   HDll := LoadLibrary(PChar(Nome));

   If ( HDll = 0 ) Then begin
      Result := False;
      NomeDll := '';
   End else begin
      Result := True;
      NomeDll := Nome;
   End;
End;

////////////////////
//Fecha a dll aberta na memória
////////////////////
Procedure FecharDll;
////////////////////
Begin
   If ( UpperCase(NomeDll) <> 'USB_485.DLL' ) Then Begin
      FreeLibrary(HDll);
   End;
End;

///////////////////////////////////////////////////
Function ConfigLpt(Endereco, Timeout:Word):Integer;
///////////////////////////////////////////////////
Var
   CallDll:function(Endereco,Timeout:Word):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ConfigLpt');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(Endereco,Timeout);
   End;
end;

///////////////////////////////////////////////
procedure Dll_PosCur(Terminal, Lin, Col: Byte);
///////////////////////////////////////////////
Var
   CallDll:procedure(Terminal, Lin, Col: Byte); stdcall;
begin
   @CallDll := GetProcAddress(HDLL,'Dll_PosCur');
   If ( @CallDll <> Nil ) then begin
      CallDll(Terminal,Lin,Col);
   End;
end;

///////////////////////////////////
procedure Dll_Clear(Terminal:Byte);
///////////////////////////////////
Var
   CallDll:procedure(Terminal:Byte); stdcall;
begin
   @CallDll := GetProcAddress(HDLL,'Dll_Clear');
   If ( @CallDll <> Nil ) then begin
      CallDll(Terminal);
   End;
end;

////////////////////////////////////////////
procedure Dll_Echo(Terminal:Byte;Dado:char);
////////////////////////////////////////////
Var
   CallDll:procedure(Terminal:Byte;Dado:char); stdcall;
Begin
   @CallDll := GetProcAddress(HDLL,'Dll_Echo');
   If ( @CallDll <> Nil ) then begin
      CallDll(Terminal,Dado);
   End;
End;

/////////////////////////////////////////////////
procedure Dll_Display(Terminal:Byte;Dado:string);
/////////////////////////////////////////////////
Var
   CallDll:procedure(Terminal:Byte;Dado:String); stdcall;
Begin
   @CallDll := GetProcAddress(HDLL,'Dll_Display');
   If ( @CallDll <> Nil ) then begin
      CallDll(Terminal,Dado);
   End;
End;

/////////////////////////////////////
function Dll_Get(Terminal:Byte):Char;
/////////////////////////////////////
Var
   CallDll:function(Terminal:Byte):Char; stdcall;
Begin
   Result := #0;
   @CallDll := GetProcAddress(HDLL,'Dll_Get');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Terminal);
   End;
End;

////////////////////////////////////////
function Dll_Status(Terminal:Byte):Byte;
////////////////////////////////////////
Var
   CallDll:function(Terminal:Byte):Byte; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Dll_Status');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Terminal);
   End;
End;

///////////////////////////////////////////////////
//Função utilizada para enviar o dado para porta Lpt do terminal
///////////////////////////////////////////////////
function Dll_Print(Terminal:Byte;Dado:String):Byte;
///////////////////////////////////////////////////
Var
   CallDll:function(Terminal:Byte;Dado:PChar):Byte; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Dll_Print');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Terminal,PChar(Dado));
   End;
End;

////////////////////////////////////////////////////
//Função utilizada para enviar o dado para serial do terminal
////////////////////////////////////////////////////
function Dll_Serial(Terminal:Byte;Dado:String):Byte;
////////////////////////////////////////////////////
Var
   CallDll:function(Terminal:Byte;Dado:PChar):Byte; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Dll_Serial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Terminal,PChar(Dado));
   End;
End;

////////////////////////////////////////
function Dll_Acesso(Cmd:string):Integer;
////////////////////////////////////////
Var
   CallDll:function(Cmd:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Dll_Acesso');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Cmd);
   End;

   //Se for terminal gradual aguarda o terminal estabilizar para enviar o outro dado
   If ( UpperCase(NomeDll) = 'WTECHLPT.DLL' ) Then begin
      Sleep(1);
   End;
End;

///////////////////////////
//Função utilizada para retornar a versão da Dll
///////////////////////////
function Dll_Versao:String;
///////////////////////////
Var
   CallDll:function:PChar; stdcall;
Begin
   Result := '';
   @CallDll := GetProcAddress(HDLL,'Dll_Versao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
End;

/////////////////////////////////////////////////////
//Função utilizada para ligar a inferface USB da IEE
/////////////////////////////////////////////////////
function Liga_Interface_USB(Var Erro:String):Boolean;
/////////////////////////////////////////////////////
Var
   CallDll:function(Erro:PChar):Boolean; stdcall;
   E:PChar;
Begin
   Result := False;
   @CallDll := GetProcAddress(HDLL,'Liga_Interface_USB');
   If ( @CallDll <> Nil ) then begin
      E := PChar(Space(255));
      Result := CallDll(E);
      Erro := E;
   End;
End;

////////////////////////////////
//Procedimento Utilizada para desligar a interface USB
////////////////////////////////
procedure Desliga_Interface_USB;
////////////////////////////////
Var
   CallDll:Procedure; stdcall;
Begin
   @CallDll := GetProcAddress(HDLL,'Desliga_Interface_USB');
   If ( @CallDll <> Nil ) then begin
      CallDll();
   End;
End;

//////////////////////////////
//Função utilizada para Retornar o numero de vezes que a interface reiniciou
//////////////////////////////
function Dll_LogReset:Integer;
//////////////////////////////
Var
   CallDll:function:Integer; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Dll_LogReset');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
End;

////////////////////////////////////////////////
//Função utilizada para retornar o numero de erros que ocorreram no terminal
////////////////////////////////////////////////
function Dll_LogTerminal(Terminal:Byte):Integer;
////////////////////////////////////////////////
Var
   CallDll:function(Terminal:Byte):Integer; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Dll_LogTerminal');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Terminal);
   End;
End;

/////////////////////////////////////////////////////
//Função Utilizada para ligar a interface TCP
//Autor: João Paulo Francisco Bellucci
/////////////////////////////////////////////////////
Function Liga_Interface_TCP(Var Erro:String):Boolean;
/////////////////////////////////////////////////////
Var
   CallDll:function(Erro:PChar):Boolean; stdcall;
   E:PChar;
Begin
   Result := False;
   @CallDll := GetProcAddress(HDLL,'Liga_Interface_TCP');
   If ( @CallDll <> Nil ) then begin
      E := PChar(Space(255));
      Result := CallDll(E);
      Erro := E;
   End;
End;

////////////////////////////////
//Procedimento Utilizada para desligar a interface USB
////////////////////////////////
procedure Desliga_Interface_TCP;
////////////////////////////////
Var
   CallDll:Procedure; stdcall;
Begin
   @CallDll := GetProcAddress(HDLL,'Desliga_Interface_TCP');
   If ( @CallDll <> Nil ) then begin
      CallDll();
   End;
End;

////////////////////////////////////////////
Function Numero_Conexoes_Ativas_TCP:Integer;
////////////////////////////////////////////
Var
   CallDll:function:Integer; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Numero_Conexoes_Ativas_TCP');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

///////////////////////////////////////////////////////////////////
Function Dados_Conexoes_TCP(nConexao:Integer;pDados:PChar):Boolean;
///////////////////////////////////////////////////////////////////
Var
   CallDll:function(nConexao:Integer;pDados:PChar):Boolean; stdcall;
Begin
   Result := False;
   @CallDll := GetProcAddress(HDLL,'Dados_Conexoes_TCP');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(nConexao,pDados);
   End;
end;

end.
