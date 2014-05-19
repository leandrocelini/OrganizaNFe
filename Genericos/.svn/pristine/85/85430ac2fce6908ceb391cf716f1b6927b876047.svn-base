unit Sweda;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, mbFuncoes;

Const NomeDll = 'CONVECF.dll';

function AbrirDll:Boolean;
procedure FecharDll;
function ECF_AbrePortaSerial:Integer;
function ECF_FechaPortaSerial:Integer;
function ECF_AberturaDoDia( ValorInicioDia:String ; Pagto:String):Integer;
function ECF_LeituraX:Integer;
function ECF_ReducaoZ( cData: String; cHora: String ):Integer;
function ECF_NumeroSerie(NumeroSerie:String):Integer;
function ECF_FlagsFiscais(Var Valor:Integer):Integer;
function ECF_DataHoraImpressora(Data:String; Hora:String):integer;
function ECF_DataHoraReducao(Data:String; Hora:String):Integer;
function ECF_DataMovimento(Data:String):Integer;
function ECF_ProgramaAliquota(Aliquota:PChar;Vinculo:Integer):Integer;
function ECF_NumeroCaixa(Caixa:String):Integer;
function ECF_RetornoAliquotas(Aliquotas:String):Integer;
function ECF_AbreRelatorioGerencialMFD(Indice:String):Integer;
function ECF_RelatorioGerencial(Dados:PChar):Integer;
function ECF_UsaRelatorioGerencialMFD(Dados:PChar):Integer;
function ECF_FechaRelatorioGerencial:Integer;
function ECF_VersaoDll(Versao:String):Integer;
function ECF_StatusRelatorioGerencial(Tipo:String):Integer;

function ECF_AbreCupom(CGC_CPF:String):Integer;
function ECF_VendeItemDepartamento( Codigo: String;
                                    Descricao: String;
                                    Aliquota: String;
                                    Quantidade: String;
                                    ValorUnitario: String;
                                    Acrescimo: String;
                                    Desconto: String;
                                    IndiceDepto: String;
                                    UN:String):Integer;
function ECF_CancelaItemGenerico(NumeroItem:String):Integer;
function ECF_IniciaFechamentoCupom(DescAcres:String;
                                   TipoDescontoAcres:String;
                                   Valor:String):Integer;
function ECF_EfetuaFormaPagamento(Pagto:String;Valor:String):Integer;
function ECF_TerminaFechamentoCupom(Texto:String):Integer;
function ECF_NumeroCupom(COO:String):Integer;
function ECF_CancelaCupom:Integer;
function ECF_Sangria(Valor:String):Integer;
function ECF_Suprimento(Valor:String;Pagto:String):Integer;

function ECF_AcionaGaveta:Integer;
function ECF_ProgramaHorarioVerao:Integer;
function ECF_VersaoFirmware(VersaoFirmware:PChar):Integer;
function ECF_LeituraMemoriaFiscalData(DataInicial,DataFinal:String):Integer;

function ECF_AbreComprovanteNaoFiscalVinculadoMFD(FormaPagamento,
                                                  Valor,
                                                  NumeroCupom,
                                                  CGC,
                                                  Nome,
                                                  Endereco:PChar):Integer;
function ECF_UsaComprovanteNaoFiscalVinculado(Texto:PChar):Integer;
function ECF_FechaComprovanteNaoFiscalVinculado:Integer;

function ECF_VerificaDescricaoFormasPagamento(FormaPg:PChar):Integer;
function ECF_ProgramaFormaPagamentoMFD(FormaPg:PChar;Vinculado:PChar):Integer;
function ECF_VerificaZPendente(ZPend:String):Integer;
function ECF_VerificaTipoImpressora(TipoImpressora:Integer):Integer;
function ECF_ProgramaArredondamento:Integer;
function ECF_VerificaTruncamento(Flag:String):Integer;
function ECF_ProgramaTruncamento:Integer;

function ECF_DadosUltimaReducao(Var sDadosReducao:String):Integer;
function ECF_DadosUltimaReducaoMFD(Var sDadosReducao:String):Integer;

function ECF_LeituraMemoriaFiscalDataMFD(DataInicial, DataFinal, FlagLeitura : string):Integer;
function ECF_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;

function ECF_LeituraMemoriaFiscalSerialDataMFD(DataInicial, DataFinal, FlagLeitura : string):Integer;
function ECF_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;

function ECF_RetornoImpressora( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ):Integer;
function ECF_Erros(Numero:Integer):String;

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

/////////////////////////////////////
//Função utilizada para abrir porta serial da ECF e
//estabelecer comunicação
/////////////////////////////////////
Function ECF_AbrePortaSerial:Integer;
/////////////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_AbrePortaSerial');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll();
   End;
end;

//////////////////////////////////////
//Função utilizada para fechar a porta de comunicação com a ECF
//////////////////////////////////////
Function ECF_FechaPortaSerial:Integer;
//////////////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_FechaPortaSerial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

//////////////////////////////////////////////////////////////////////////
function ECF_AberturaDoDia( ValorInicioDia:String ; Pagto:String):Integer;
//////////////////////////////////////////////////////////////////////////
Var CallDll:function(ValorInicioDia:String; Pagto:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_AberturaDoDia');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ValorInicioDia,Pagto);
   End;
end;

//////////////////////////////
function ECF_LeituraX:Integer;
//////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_LeituraX');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

//////////////////////////////////////////////////////////////
function ECF_ReducaoZ( cData: String; cHora: String ):Integer;
//////////////////////////////////////////////////////////////
Var CallDll:function(cData:String;cHora:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_ReducaoZ');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(cData,cHora);
   End;
end;

/////////////////////////////////////////////////////
function ECF_NumeroSerie(NumeroSerie:String):Integer;
/////////////////////////////////////////////////////
Var CallDll:function(NumeroSerie:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_NumeroSerie');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(NumeroSerie);
   End;
end;

/////////////////////////////////////////////////////
function ECF_FlagsFiscais(Var Valor:Integer):Integer;
/////////////////////////////////////////////////////
Var CallDll:function(Var Valor:Integer):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_FlagsFiscais');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Valor);
   End;
end;

//////////////////////////////////////////////////////////////////
function ECF_DataHoraImpressora(Data:String; Hora:String):integer;
//////////////////////////////////////////////////////////////////
Var CallDll:function(Data:String; Hora:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_DataHoraImpressora');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Data,Hora);
   End;
end;

///////////////////////////////////////////////////////////////
function ECF_DataHoraReducao(Data:String; Hora:String):Integer;
///////////////////////////////////////////////////////////////
Var CallDll:function(Data:String; Hora:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_DataHoraReducao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Data,Hora);
   End;
end;

////////////////////////////////////////////////
function ECF_DataMovimento(Data:String):Integer;
////////////////////////////////////////////////
Var CallDll:function(Data:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_DataMovimento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Data);
   End;
end;

///////////////////////////////////////////////////////////////////////
function ECF_ProgramaAliquota(Aliquota:PChar;Vinculo:Integer):Integer;
///////////////////////////////////////////////////////////////////////
Var CallDll:function(Aliquota:PChar;Vinculo:INteger):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_ProgramaAliquota');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Aliquota,Vinculo);
   End;
end;

///////////////////////////////////////////////
function ECF_NumeroCaixa(Caixa:String):Integer;
///////////////////////////////////////////////
Var CallDll:function(Caixa:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_NumeroCaixa');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Caixa);
   End;
end;

///////////////////////////////////////////////////////
function ECF_RetornoAliquotas(Aliquotas:String):Integer;
///////////////////////////////////////////////////////
Var CallDll:function(Aliquotas:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_RetornoAliquotas');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Aliquotas);
   End;
end;

//////////////////////////////////////////////////////////////
function ECF_AbreRelatorioGerencialMFD(Indice:String):Integer;
//////////////////////////////////////////////////////////////
Var CallDll:function(Indice:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_AbreRelatorioGerencialMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Indice);
   End;
end;

/////////////////////////////////////////////////////
function ECF_RelatorioGerencial(Dados:PChar):Integer;
/////////////////////////////////////////////////////
Var CallDll:function(Dados:PChar):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_RelatorioGerencial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Dados);
   End;
end;

///////////////////////////////////////////////////////////
function ECF_UsaRelatorioGerencialMFD(Dados:PChar):Integer;
///////////////////////////////////////////////////////////
Var CallDll:function(Dados:PChar):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_UsaRelatorioGerencialMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Dados);
   End;
end;

/////////////////////////////////////////////
function ECF_FechaRelatorioGerencial:Integer;
/////////////////////////////////////////////
Var CallDll:function:Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_FechaRelatorioGerencial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

//////////////////////////////////////////////
function ECF_VersaoDll(Versao:String):Integer;
//////////////////////////////////////////////
Var CallDll:function(Versao:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_VersaoDll');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Versao);
   End;
end;

///////////////////////////////////////////////////////////
function ECF_StatusRelatorioGerencial(Tipo:String):Integer;
///////////////////////////////////////////////////////////
Var CallDll:function(Tipo:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_StatusRelatorioGerencial');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Tipo);
   End;
end;

///////////////////////////////////////////////
function ECF_AbreCupom(CGC_CPF:String):Integer;
///////////////////////////////////////////////
Var CallDll:function(CGC_CPF:String):Integer; stdcall;
Begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_AbreCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(CGC_CPF);
   End;
End;

//////////////////////////////////////////////////////////
function ECF_VendeItemDepartamento( Codigo:String;
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
   @CallDll := GetProcAddress(HDLL,'ECF_VendeItemDepartamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Codigo,
                        Descricao,
                        Aliquota,
                        Quantidade,
                        ValorUnitario,
                        Acrescimo,
                        Desconto,
                        IndiceDepto,
                        UN);
   End;
end;

////////////////////////////////////////////////////////////
function ECF_CancelaItemGenerico(NumeroItem:String):Integer;
////////////////////////////////////////////////////////////
Var CallDll:function(NumeroItem:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_CancelaItemGenerico');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(NumeroItem);
   End;
end;


////////////////////////////////////////////////////////////
function ECF_IniciaFechamentoCupom(DescAcres:String;
                                   TipoDescontoAcres:String;
                                   Valor:String):Integer;
////////////////////////////////////////////////////////////
Var CallDll:function(DescAcres:String;
                     TipoDescontoAcres:String;
                     Valor:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_IniciaFechamentoCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(DescAcres,
                        TipoDescontoAcres,
                        Valor);
   End;
end;

/////////////////////////////////////////////////////////////////////
function ECF_EfetuaFormaPagamento(Pagto:String;Valor:String):Integer;
/////////////////////////////////////////////////////////////////////
Var CallDll:function(Pagto:String;Valor:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_EfetuaFormaPagamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Pagto,Valor);
   End;
end;

//////////////////////////////////////////////////////////
function ECF_TerminaFechamentoCupom(Texto:String):Integer;
//////////////////////////////////////////////////////////
Var CallDll:function(Texto:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_TerminaFechamentoCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Texto);
   End;
end;

/////////////////////////////////////////////
function ECF_NumeroCupom(COO:String):Integer;
/////////////////////////////////////////////
Var CallDll:function(COO:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_NumeroCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(COO);
   End;
end;

//////////////////////////////////
function ECF_CancelaCupom:Integer;
//////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_CancelaCupom');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

///////////////////////////////////////////
function ECF_Sangria(Valor:String):Integer;
///////////////////////////////////////////
Var CallDll:function(Valor:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_Sangria');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Valor);
   End;
end;

///////////////////////////////////////////////////////////
function ECF_Suprimento(Valor:String;Pagto:String):Integer;
///////////////////////////////////////////////////////////
Var CallDll:function(Valor:String;Pagto:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_Suprimento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Valor,Pagto);
   End;
end;

//////////////////////////////////
function ECF_AcionaGaveta:Integer;
//////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_AcionaGaveta');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

//////////////////////////////////////////
function ECF_ProgramaHorarioVerao:Integer;
//////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_ProgramaHorarioVerao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

//////////////////////////////////////////////////////////
function ECF_VersaoFirmware(VersaoFirmware:PChar):Integer;
//////////////////////////////////////////////////////////
Var CallDll:function(VersaoFirmware:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_VersaoFirmware');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(VersaoFirmware);
   End;
end;

////////////////////////////////////////////////////////////////////////////
function ECF_LeituraMemoriaFiscalData(DataInicial,DataFinal:String):Integer;
////////////////////////////////////////////////////////////////////////////
Var CallDll:function(DataInicial,DataFinal:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_LeituraMemoriaFiscalData');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(DataInicial,DataFinal);
   End;
end;

//////////////////////////////////////////////////////////////////////////
function ECF_AbreComprovanteNaoFiscalVinculadoMFD(FormaPagamento,
                                                  Valor,
                                                  NumeroCupom,
                                                  CGC,
                                                  Nome,
                                                  Endereco:PChar):Integer;
//////////////////////////////////////////////////////////////////////////
Var CallDll:function(FormaPagamento,
                     Valor,
                     NumeroCupom,
                     CGC,
                     Nome,
                     Endereco:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_AbreComprovanteNaoFiscalVinculadoMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(FormaPagamento,
                        Valor,
                        NumeroCupom,
                        CGC,
                        Nome,
                        Endereco);
   End;
end;

///////////////////////////////////////////////////////////////////
function ECF_UsaComprovanteNaoFiscalVinculado(Texto:PChar):Integer;
///////////////////////////////////////////////////////////////////
Var CallDll:function(Texto:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_UsaComprovanteNaoFiscalVinculado');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Texto);
   End;
end;

////////////////////////////////////////////////////////
function ECF_FechaComprovanteNaoFiscalVinculado:Integer;
////////////////////////////////////////////////////////
Var CallDll:function():Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_FechaComprovanteNaoFiscalVinculado');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

/////////////////////////////////////////////////////////////////////
function ECF_VerificaDescricaoFormasPagamento(FormaPg:PChar):Integer;
/////////////////////////////////////////////////////////////////////
Var CallDll:function(FormaPg:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_VerificaDescricaoFormasPagamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(FormaPg);
   End;
end;

//////////////////////////////////////////////////////////////////////////////
function ECF_ProgramaFormaPagamentoMFD(FormaPg:PChar;Vinculado:PChar):Integer;
//////////////////////////////////////////////////////////////////////////////
Var CallDll:function(FormaPg:PChar;Vinculado:PChar):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_ProgramaFormaPagamentoMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(FormaPg,Vinculado);
   End;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////
function ECF_RetornoImpressora( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ):Integer;
/////////////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_RetornoImpressora');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ACK,ST1,ST2);
   End;
end;

/////////////////////////////////////////////////////
function ECF_VerificaZPendente(ZPend:String):Integer;
/////////////////////////////////////////////////////
Var CallDll:function(ZPend:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_VerificaZPendente');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ZPend);
   End;
end;

//////////////////////////////////////////////////////////////////
function ECF_DadosUltimaReducao(Var sDadosReducao:String):Integer;
//////////////////////////////////////////////////////////////////
Var CallDll:function(sDadosReducao:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_DadosUltimaReducao');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(sDadosReducao);
   End;
end;

/////////////////////////////////////////////////////////////////////
function ECF_DadosUltimaReducaoMFD(Var sDadosReducao:String):Integer;
/////////////////////////////////////////////////////////////////////
Var CallDll:function(sDadosReducao:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_DadosUltimaReducaoMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(sDadosReducao);
   End;
end;

////////////////////////////////////////////////////////////////////
function ECF_VerificaTipoImpressora(TipoImpressora:Integer):Integer;
////////////////////////////////////////////////////////////////////
Var CallDll:function(TipoImpressora:Integer):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_VerificaTipoImpressora');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(TipoImpressora);
   End;
end;

////////////////////////////////////////////
function ECF_ProgramaArredondamento:Integer;
////////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_ProgramaArredondamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

//////////////////////////////////////////////////////
function ECF_VerificaTruncamento(Flag:String):Integer;
//////////////////////////////////////////////////////
Var CallDll:function(Flag:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_VerificaTruncamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(Flag);
   End;
end;

/////////////////////////////////////////
function ECF_ProgramaTruncamento:Integer;
/////////////////////////////////////////
Var CallDll:function:Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_ProgramaTruncamento');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll();
   End;
end;

///////////////////////////////////////////////////////////////////////////////////////////
function ECF_LeituraMemoriaFiscalDataMFD(DataInicial,DataFinal,FlagLeitura:string):Integer;
///////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(DataInicial,DataFinal,FlagLeitura:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_LeituraMemoriaFiscalDataMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(DataInicial,DataFinal,FlagLeitura);
   End;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
function ECF_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;
////////////////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(ReducaoInicial,ReducaoFinal,FlagLeitura:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_LeituraMemoriaFiscalReducaoMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ReducaoInicial,ReducaoFinal,FlagLeitura);
   End;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////
function ECF_LeituraMemoriaFiscalSerialDataMFD(DataInicial,DataFinal,FlagLeitura:string):Integer;
/////////////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(DataInicial,DataFinal,FlagLeitura:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_LeituraMemoriaFiscalSerialDataMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(DataInicial,DataFinal,FlagLeitura);
   End;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////
function ECF_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial,ReducaoFinal,FlagLeitura:string):Integer;
//////////////////////////////////////////////////////////////////////////////////////////////////////////
Var CallDll:function(ReducaoInicial,ReducaoFinal,FlagLeitura:String):Integer stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'ECF_LeituraMemoriaFiscalSerialReducaoMFD');
   If ( @CallDll <> Nil ) then begin
      Result := CallDll(ReducaoInicial,ReducaoFinal,FlagLeitura);
   End;
end;

//////////////////////////////////////////
//Função utilizada para retornar a descrição do erro
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////
function ECF_Erros(Numero:Integer):String;
//////////////////////////////////////////
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
