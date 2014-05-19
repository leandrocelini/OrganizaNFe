unit Daruma;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, mbFuncoes;

Const NomeDll = 'Daruma32.dll';

function AbrirDll:Boolean;
procedure FecharDll;
function Daruma_FI_AbrePortaSerial:Integer;
function Daruma_FI_FechaPortaSerial:Integer;
function Daruma_FI_AberturaDoDia( ValorInicioDia:String ; Pagto:String):Integer;
function Daruma_FI_LeituraX:Integer;
function Daruma_FI_ReducaoZ( cData: String; cHora: String ):Integer;
function Daruma_FI_NumeroSerie(NumeroSerie:String):Integer;
function Daruma_FI_FlagsFiscais(Var Valor:Integer):Integer;
function Daruma_FI_DataHoraImpressora(Data:String; Hora:String):integer;
function Daruma_FI_DataHoraReducao(Data:String; Hora:String):Integer;
function Daruma_FI_DataMovimento(Data:String):Integer;
function Daruma_FI_ProgramaAliquota(Aliquota:PChar;Vinculo:Integer):Integer;
function Daruma_FI_NumeroCaixa(Caixa:String):Integer;
function Daruma_FI_RetornoAliquotas(Aliquotas:String):Integer;
function Daruma_FI_AbreRelatorioGerencialMFD(Indice:String):Integer;
function Daruma_FI_AbreRelatorioGerencial():Integer;
function Daruma_FI_RelatorioGerencial(Dados:PChar):Integer;
function Daruma_FI_FechaRelatorioGerencial:Integer;
function Daruma_FI_VersaoDll(Versao:String):Integer;

function Daruma_FI_AbreCupom(CGC_CPF:String):Integer;
function Daruma_FI_VendeItemDepartamento( Codigo: String;
                                    Descricao: String;
                                    Aliquota: String;
                                    Quantidade: String;
                                    ValorUnitario: String;
                                    Acrescimo: String;
                                    Desconto: String;
                                    IndiceDepto: String;
                                    UN:String):Integer;
function Daruma_FI_CancelaItemGenerico(NumeroItem:String):Integer;
function Daruma_FI_IniciaFechamentoCupom(DescAcres:String;
                                   TipoDescontoAcres:String;
                                   Valor:String):Integer;
function Daruma_FI_EfetuaFormaPagamento(Pagto:String;Valor:String):Integer;
function Daruma_FI_TerminaFechamentoCupom(Texto:String):Integer;
function Daruma_FI_NumeroCupom(COO:String):Integer;
function Daruma_FI_CancelaCupom:Integer;
function Daruma_FI_Sangria(Valor:String):Integer;
function Daruma_FI_Suprimento(Valor:String;Pagto:String):Integer;

function Daruma_FI_AcionaGaveta:Integer;
function Daruma_FI_ProgramaHorarioVerao:Integer;
function Daruma_FI_VersaoFirmware(VersaoFirmware:PChar):Integer;
function Daruma_FI_LeituraMemoriaFiscalData(DataInicial,DataFinal:String):Integer;
function Daruma_FI_LeituraMemoriaFiscalSerialData(DataInicial,DataFinal:String):Integer;
function Daruma_FI_LeituraMemoriaFiscalReducao(ReducaoInicial,ReducaoFinal:String):Integer;
function Daruma_FI_ProgramaArredondamento:Integer;
function Daruma_FI_ProgramaTruncamento:Integer;
function Daruma_FI_VerificaTruncamento(Flag:String):Integer;
function Daruma_FI_VerificaTipoImpressora(Var TipoImpressora:Integer):Integer;
function Daruma_FI_AcionaGuilhotinaMFD(TipoAcionamento:Integer):Integer;

function Daruma_FI_AbreComprovanteNaoFiscalVinculado(FormaPagamento,
                                                     Valor,
                                                     NumeroCupom:PChar):Integer;
function Daruma_FI_UsaComprovanteNaoFiscalVinculado(Texto:PChar):Integer;
function Daruma_FI_FechaComprovanteNaoFiscalVinculado:Integer;

function Daruma_FI_VerificaDescricaoFormasPagamento(FormaPg:PChar):Integer;
function Daruma_FI_ProgramaFormasPagamento(FormaPg:PChar):Integer;
function Daruma_FI_VerificaZPendente(ZPend:String):Integer;

function Daruma_FI_DadosUltimaReducao(Var sDadosReducao:String):Integer;
function Daruma_FI_DadosUltimaReducaoMFD(Var sDadosReducao:String):Integer;
function Daruma_FIMFD_RetornaInformacao(sIndice:String; Valor:String):Integer;

Function Daruma_Registry_MFD_LeituraMFCompleta(Param:String):Integer;
function Daruma_FI_LeituraMemoriaFiscalDataMFD(DataInicial,DataFinal,FlagLeitura:string):Integer;
function Daruma_FI_LeituraMemoriaFiscalSerialDataMFD(DataInicial,DataFinal,FlagLeitura:string):Integer;
function Daruma_FI_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;
function Daruma_FI_LeituraMemoriaFiscalSerialReducao(ReducaoInicial,ReducaoFinal:String):Integer;
function Daruma_FI_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;

function Daruma_FI_RetornoImpressora( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ):Integer;
function Daruma_FI_Erros(Numero:Integer):String;

Var HDll:THandle;

implementation

//////////////////////////
Function AbrirDll:Boolean;
//////////////////////////
Begin
   HDll := LoadLibrary(PChar(NomeDll));

   If ( HDll = 0 ) Then begin
      Result := False;
   End else begin
      Result := True;
   End;
End;

////////////////////
//Fecha a dll aberta na memória
////////////////////
Procedure FecharDll;
////////////////////
Begin
   If ( HDll <> 0 ) Then Begin
      FreeLibrary(HDll);
   End;
End;

///////////////////////////////////////////
//Função utilizada para abrir porta serial da ECF e
//estabelecer comunicação
///////////////////////////////////////////
Function Daruma_FI_AbrePortaSerial:Integer;
///////////////////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AbrePortaSerial');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll();
   End;
end;

////////////////////////////////////////////
//Função utilizada para fechar a porta de comunicação com a ECF
////////////////////////////////////////////
Function Daruma_FI_FechaPortaSerial:Integer;
////////////////////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_FechaPortaSerial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_AberturaDoDia( ValorInicioDia:String ; Pagto:String):Integer;
////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(ValorInicioDia:String; Pagto:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AberturaDoDia');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ValorInicioDia,Pagto);
   End;
end;

////////////////////////////////////
function Daruma_FI_LeituraX:Integer;
////////////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_LeituraX');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

////////////////////////////////////////////////////////////////////
function Daruma_FI_ReducaoZ( cData: String; cHora: String ):Integer;
////////////////////////////////////////////////////////////////////
Var CallDll:function(cData:String;cHora:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_ReducaoZ');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(cData,cHora);
   End;
end;

///////////////////////////////////////////////////////////
function Daruma_FI_NumeroSerie(NumeroSerie:String):Integer;
///////////////////////////////////////////////////////////
Var CallDll:function(NumeroSerie:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_NumeroSerie');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(NumeroSerie);
   End;
end;

///////////////////////////////////////////////////////////
function Daruma_FI_FlagsFiscais(Var Valor:Integer):Integer;
///////////////////////////////////////////////////////////
Var CallDll:function(Var Valor:Integer):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_FlagsFiscais');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Valor);
   End;
end;

////////////////////////////////////////////////////////////////////////
function Daruma_FI_DataHoraImpressora(Data:String; Hora:String):integer;
////////////////////////////////////////////////////////////////////////
Var CallDll:function(Data:String; Hora:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_DataHoraImpressora');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Data,Hora);
   End;
end;

/////////////////////////////////////////////////////////////////////
function Daruma_FI_DataHoraReducao(Data:String; Hora:String):Integer;
/////////////////////////////////////////////////////////////////////
Var CallDll:function(Data:String; Hora:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_DataHoraReducao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Data,Hora);
   End;
end;

//////////////////////////////////////////////////////
function Daruma_FI_DataMovimento(Data:String):Integer;
//////////////////////////////////////////////////////
Var CallDll:function(Data:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_DataMovimento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Data);
   End;
end;

////////////////////////////////////////////////////////////////////////////
function Daruma_FI_ProgramaAliquota(Aliquota:PChar;Vinculo:Integer):Integer;
////////////////////////////////////////////////////////////////////////////
Var CallDll:function(Aliquota:PChar;Vinculo:INteger):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_ProgramaAliquota');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Aliquota,Vinculo);
   End;
end;

/////////////////////////////////////////////////////
function Daruma_FI_NumeroCaixa(Caixa:String):Integer;
/////////////////////////////////////////////////////
Var CallDll:function(Caixa:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_NumeroCaixa');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Caixa);
   End;
end;

//////////////////////////////////////////////////////////////
function Daruma_FI_RetornoAliquotas(Aliquotas:String):Integer;
//////////////////////////////////////////////////////////////
Var CallDll:function(Aliquotas:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_RetornoAliquotas');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Aliquotas);
   End;
end;

////////////////////////////////////////////////////////////////////
function Daruma_FI_AbreRelatorioGerencialMFD(Indice:String):Integer;
////////////////////////////////////////////////////////////////////
Var CallDll:function(Indice:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AbreRelatorioGerencialMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Indice);
   End;
end;

////////////////////////////////////////////////////
function Daruma_FI_AbreRelatorioGerencial():Integer;
////////////////////////////////////////////////////
Var CallDll:function():Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AbreRelatorioGerencial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

///////////////////////////////////////////////////////////
function Daruma_FI_RelatorioGerencial(Dados:PChar):Integer;
///////////////////////////////////////////////////////////
Var CallDll:function(Dados:PChar):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_RelatorioGerencial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Dados);
   End;
end;

///////////////////////////////////////////////////
function Daruma_FI_FechaRelatorioGerencial:Integer;
///////////////////////////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_FechaRelatorioGerencial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

////////////////////////////////////////////////////
function Daruma_FI_VersaoDll(Versao:String):Integer;
////////////////////////////////////////////////////
Var CallDll:function(Versao:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_VersaoDll');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Versao);
   End;
end;

/////////////////////////////////////////////////////
function Daruma_FI_AbreCupom(CGC_CPF:String):Integer;
/////////////////////////////////////////////////////
Var CallDll:function(CGC_CPF:String):Integer; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AbreCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(CGC_CPF);
   End;
End;

//////////////////////////////////////////////////////////
function Daruma_FI_VendeItemDepartamento( Codigo:String;
                                    Descricao: String;
                                    Aliquota: String;
                                    Quantidade: String;
                                    ValorUnitario: String;
                                    Acrescimo: String;
                                    Desconto: String;
                                    IndiceDepto: String;
                                    UN:String):Integer;
//////////////////////////////////////////////////////////
Var CallDll:function(Codigo:String;
                     Descricao:String;
                     Aliquota:String;
                     Quantidade:String;
                     ValorUnitario:String;
                     Acrescimo:String;
                     Desconto:String;
                     IndiceDepto:String;
                     UN:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_VendeItemDepartamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(pchar(Codigo),
                        pchar(Descricao),
                        pchar(Aliquota),
                        pchar(Quantidade),
                        pchar(ValorUnitario),
                        pchar(Acrescimo),
                        pchar(Desconto),
                        pchar(IndiceDepto),
                        pchar(UN));
   End;
end;

//////////////////////////////////////////////////////////////////
function Daruma_FI_CancelaItemGenerico(NumeroItem:String):Integer;
//////////////////////////////////////////////////////////////////
Var CallDll:function(NumeroItem:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_CancelaItemGenerico');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(NumeroItem);
   End;
end;


////////////////////////////////////////////////////////////
function Daruma_FI_IniciaFechamentoCupom(DescAcres:String;
                                   TipoDescontoAcres:String;
                                   Valor:String):Integer;
////////////////////////////////////////////////////////////
Var CallDll:function(DescAcres:String;
                     TipoDescontoAcres:String;
                     Valor:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_IniciaFechamentoCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(DescAcres,
                        TipoDescontoAcres,
                        Valor);
   End;
end;

///////////////////////////////////////////////////////////////////////////
function Daruma_FI_EfetuaFormaPagamento(Pagto:String;Valor:String):Integer;
///////////////////////////////////////////////////////////////////////////
Var CallDll:function(Pagto:String;Valor:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_EfetuaFormaPagamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Pagto,Valor);
   End;
end;

////////////////////////////////////////////////////////////////
function Daruma_FI_TerminaFechamentoCupom(Texto:String):Integer;
////////////////////////////////////////////////////////////////
Var CallDll:function(Texto:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_TerminaFechamentoCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Texto);
   End;
end;

///////////////////////////////////////////////////
function Daruma_FI_NumeroCupom(COO:String):Integer;
///////////////////////////////////////////////////
Var CallDll:function(COO:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_NumeroCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(COO);
   End;
end;

////////////////////////////////////////
function Daruma_FI_CancelaCupom:Integer;
////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_CancelaCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

/////////////////////////////////////////////////
function Daruma_FI_Sangria(Valor:String):Integer;
/////////////////////////////////////////////////
Var CallDll:function(Valor:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_Sangria');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Valor);
   End;
end;

/////////////////////////////////////////////////////////////////
function Daruma_FI_Suprimento(Valor:String;Pagto:String):Integer;
/////////////////////////////////////////////////////////////////
Var CallDll:function(Valor:String;Pagto:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_Suprimento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Valor,Pagto);
   End;
end;

////////////////////////////////////////
function Daruma_FI_AcionaGaveta:Integer;
////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AcionaGaveta');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

////////////////////////////////////////////////
function Daruma_FI_ProgramaHorarioVerao:Integer;
////////////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_ProgramaHorarioVerao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

////////////////////////////////////////////////////////////////
function Daruma_FI_VersaoFirmware(VersaoFirmware:PChar):Integer;
////////////////////////////////////////////////////////////////
Var CallDll:function(VersaoFirmware:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_VersaoFirmware');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(VersaoFirmware);
   End;
end;

//////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalData(DataInicial,DataFinal:String):Integer;
//////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(DataInicial,DataFinal:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_LeituraMemoriaFiscalData');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(DataInicial,DataFinal);
   End;
end;

////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalSerialData(DataInicial,DataFinal:String):Integer;
////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(DataInicial,DataFinal:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_LeituraMemoriaFiscalSerialData');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(DataInicial,DataFinal);
   End;
end;

//////////////////////////////////////////////////
function Daruma_FI_ProgramaArredondamento:Integer;
//////////////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_ProgramaArredondamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

///////////////////////////////////////////////
function Daruma_FI_ProgramaTruncamento:Integer;
///////////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_ProgramaTruncamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

////////////////////////////////////////////////////////////
function Daruma_FI_VerificaTruncamento(Flag:String):Integer;
////////////////////////////////////////////////////////////
Var CallDll:function(Flag:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_VerificaTruncamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Flag);
   End;
end;

//////////////////////////////////////////////////////////////////////////////
function Daruma_FI_VerificaTipoImpressora(Var TipoImpressora:Integer):Integer;
//////////////////////////////////////////////////////////////////////////////
Var CallDll:function(Var TipoImpressora:Integer):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_VerificaTipoImpressora');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(TipoImpressora);
   End;
end;

////////////////////////////////////////////////////////////////////////
function Daruma_FI_AcionaGuilhotinaMFD(TipoAcionamento:Integer):Integer;
////////////////////////////////////////////////////////////////////////
Var CallDll:function(TipoAcionamento:Integer):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AcionaGuilhotinaMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(TipoAcionamento);
   End;
end;

////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_AbreComprovanteNaoFiscalVinculado(FormaPagamento,
                                                     Valor,
                                                     NumeroCupom:PChar):Integer;
////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(FormaPagamento,
                     Valor,
                     NumeroCupom:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_AbreComprovanteNaoFiscalVinculado');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(FormaPagamento,
                        Valor,
                        NumeroCupom);
   End;
end;

/////////////////////////////////////////////////////////////////////////
function Daruma_FI_UsaComprovanteNaoFiscalVinculado(Texto:PChar):Integer;
/////////////////////////////////////////////////////////////////////////
Var CallDll:function(Texto:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_UsaComprovanteNaoFiscalVinculado');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Texto);
   End;
end;

//////////////////////////////////////////////////////////////
function Daruma_FI_FechaComprovanteNaoFiscalVinculado:Integer;
//////////////////////////////////////////////////////////////
Var CallDll:function():Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_FechaComprovanteNaoFiscalVinculado');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

///////////////////////////////////////////////////////////////////////////
function Daruma_FI_VerificaDescricaoFormasPagamento(FormaPg:PChar):Integer;
///////////////////////////////////////////////////////////////////////////
Var CallDll:function(FormaPg:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_VerificaDescricaoFormasPagamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(FormaPg);
   End;
end;

//////////////////////////////////////////////////////////////////
function Daruma_FI_ProgramaFormasPagamento(FormaPg:PChar):Integer;
//////////////////////////////////////////////////////////////////
Var CallDll:function(FormaPg:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_ProgramaFormasPagamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(FormaPg);
   End;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_RetornoImpressora( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ):Integer;
///////////////////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_RetornoImpressora');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ACK,ST1,ST2);
   End;
end;

///////////////////////////////////////////////////////////
function Daruma_FI_VerificaZPendente(ZPend:String):Integer;
///////////////////////////////////////////////////////////
Var CallDll:function(ZPend:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_VerificaZPendente');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ZPend);
   End;
end;

////////////////////////////////////////////////////////////////////////
function Daruma_FI_DadosUltimaReducao(Var sDadosReducao:String):Integer;
////////////////////////////////////////////////////////////////////////
Var CallDll:function(sDadosReducao:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_DadosUltimaReducao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(sDadosReducao);
   End;
end;

///////////////////////////////////////////////////////////////////////////
function Daruma_FI_DadosUltimaReducaoMFD(Var sDadosReducao:String):Integer;
///////////////////////////////////////////////////////////////////////////
Var CallDll:function(sDadosReducao:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_DadosUltimaReducaoMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(sDadosReducao);
   End;
end;

//////////////////////////////////////////////////////////////////////////////
function Daruma_FIMFD_RetornaInformacao(sIndice:String; Valor:String):Integer;
//////////////////////////////////////////////////////////////////////////////
Var CallDll:function(sIndice:String; Valor:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FIMFD_RetornaInformacao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(sIndice,Valor);
   End;
end;

/////////////////////////////////////////////////////////////////////
Function Daruma_Registry_MFD_LeituraMFCompleta(Param:String):Integer;
/////////////////////////////////////////////////////////////////////
Var CallDll:function(Param:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_Registry_MFD_LeituraMFCompleta');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Param);
   End;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalDataMFD(DataInicial,DataFinal,FlagLeitura:string):Integer;
/////////////////////////////////////////////////////////////////////////////////////////////////
Var sParam:String;
begin
   If ( FlagLeitura = 'C' ) Then begin
      sParam := '1';
   End else begin
      sParam := '0';
   End;

   Daruma_Registry_MFD_LeituraMFCompleta(sParam);

   Result := Daruma_FI_LeituraMemoriaFiscalData(DataInicial,DataFinal);
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalSerialDataMFD(DataInicial,DataFinal,FlagLeitura:string):Integer;
///////////////////////////////////////////////////////////////////////////////////////////////////////
Var sParam:String;
begin
   If ( FlagLeitura = 'C' ) Then begin
      sParam := '1';
   End else begin
      sParam := '0';
   End;

   Daruma_Registry_MFD_LeituraMFCompleta(sParam);

   Result := Daruma_FI_LeituraMemoriaFiscalSerialData(DataInicial,DataFinal);
end;

///////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalReducao(ReducaoInicial,ReducaoFinal:String):Integer;
///////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(DataInicial,DataFinal:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_LeituraMemoriaFiscalReducao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ReducaoInicial,ReducaoFinal);
   End;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;
//////////////////////////////////////////////////////////////////////////////////////////////////////////
Var sParam:String;
begin
   If ( FlagLeitura = 'C' ) Then begin
      sParam := '1';
   End else begin
      sParam := '0';
   End;

   Daruma_Registry_MFD_LeituraMFCompleta(sParam);

   Result := Daruma_FI_LeituraMemoriaFiscalReducao(ReducaoInicial,ReducaoFinal);
end;

/////////////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalSerialReducao(ReducaoInicial,ReducaoFinal:String):Integer;
/////////////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(DataInicial,DataFinal:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Daruma_FI_LeituraMemoriaFiscalSerialReducao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ReducaoInicial,ReducaoFinal);
   End;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Daruma_FI_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Var sParam:String;
begin
   If ( FlagLeitura = 'C' ) Then begin
      sParam := '1';
   End else begin
      sParam := '0';
   End;

   Daruma_Registry_MFD_LeituraMFCompleta(sParam);

   Result := Daruma_FI_LeituraMemoriaFiscalSerialReducao(ReducaoInicial,ReducaoFinal);
end;

////////////////////////////////////////////////
//Função utilizada para retornar a descrição do erro
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////
function Daruma_FI_Erros(Numero:Integer):String;
////////////////////////////////////////////////
begin
   If ( Numero = 0 ) Then begin
      Result := 'Erro de Comunicação';
   End else If ( Numero = -1 ) Then begin
      Result := 'Erro de execução da função.';
   End else If ( Numero = -2 ) Then begin
      Result := 'Parâmetro inválido na função';
   End else If ( Numero = -3 ) Then begin
      Result := 'Alíquota não programada.';
   End else If ( Numero = -4 ) Then begin
      Result := 'O arquivo de inicialização BemaFI32.ini não foi encontrado ' + Chr(13) +
                'no diretório de sistema do Windows.';
   End else If ( Numero = -5 ) Then begin
      Result := 'Erro ao abrir a porta de comunicação.';
   End else If ( Numero = -6 ) Then begin
      Result := 'Impressora desligada ou cabo de comunicação desconectado';
   End else If ( Numero = -8 ) Then begin
      Result := 'Erro ao criar ou gravar no arquivo STATUS.TXT ou RETORNO.TXT.';
   End else If ( Numero = -9 ) Then begin
      Result := 'Erro ao fechar a porta.';
   End else If ( Numero = -25 ) Then begin
      Result := 'Totalizador não fiscal não programado.';
   End else If ( Numero = -24 ) Then begin
      Result := 'Forma de pagamento não programada.';
   End else If ( Numero = -27 ) Then begin
      Result := 'Status da impressora diferente de 6,0,0 (ACK, ST1 e ST2).';
   End else If ( Numero = -30 ) Then begin
      Result := 'Função não compatível com a impressora YANCO';
   End else If ( Numero = -36 ) Then begin
      Result := 'Forma de pagamento não finalizada.';
   End else begin
      Result := 'Erro de número ' + IntToStr(Numero);
   End;
end;

end.
