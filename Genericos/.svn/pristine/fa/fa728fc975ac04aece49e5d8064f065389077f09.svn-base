unit REDFModelo1;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Funcoes;

function AbrirDll:Boolean;
procedure FecharDll;
Function Modelo1_Registro_10(CNPJ:String;
                             DataInicio:String;
                             DataFinal:String):Integer;
Function Modelo1_Registro_20(FuncaoRegistro:String;
                             JustificativaCancelamento:String;
                             DescricaoNaturezaOperacao:String;
                             SerieNota:String;
                             NumeroNota:String;
                             DataEmissao:String;
                             DataSaidaEntrada:String;
                             TipoNota:String;
                             CFOP:String;
                             IEST:String;
                             IM_Emitente:String;
                             CNPJ_CPF_Destinatario:String;
                             IE_Destinatario:String;
                             Nome_Destinatario:String;
                             Logradouro_Destinatario:String;
                             Numero_Destinatario:String;
                             Complemento_Destinatario:String;
                             Bairro_Destinatario:String;
                             Cidade_Destinatario:String;
                             UF_Destinatario:String;
                             CEP_Destinatario:String;
                             Pais_Destinatario:String;
                             Telefone_Destinatario:String):Integer;
Function Modelo1_Registro_30(CodigoProduto:String;
                             DescricaoProduto:String;
                             CodigoNCM:String;
                             Unidade:String;
                             Quantidade:String;
                             ValorUnitario:String;
                             ValorTotal:String;
                             CST:String;
                             AliquotaICMS:String;
                             AliquotaIPI:String;
                             ValorIPI:String):Integer;
Function Modelo1_Registro_40(BaseCalculoICMS:String;
                             ValorTotalICMS:String;
                             BaseCalculoICMSST:String;
                             ValorTotalICMSST:String;
                             ValorTotalProdutosServicos:String;
                             ValorTotalFrete:String;
                             ValorTotalSeguro:String;
                             ValorTotalDesconto:String;
                             ValorTotalIPI:String;
                             OutrasDespesas:String;
                             ValorTotalNotaFiscal:String;
                             ValorTotalServicos:String;
                             AliquotaISS:String;
                             ValorTotalISS:String):Integer;
Function Modelo1_Registro_50(ModalidadeFrete:String;
                             CNPJ_CPF:String;
                             Nome:String;
                             InscricaoEstadual:String;
                             EnderecoCompleto:String;
                             Cidade:String;
                             UF:String;
                             PlacaVeiculo:String;
                             UFPlaca:String;
                             QtdeVolumes:String;
                             EspecieVolumes:String;
                             MarcaVolumes:String;
                             NumeracaoVolumes:String;
                             PesoLiquido:String;
                             PesoBruto:String):Integer;
Function Modelo1_Registro_60(DadosFatura:String;
                             InformacoesFisco:String;
                             InformacoesContribuite:String):Integer;
Function Modelo1_Registro_90(NomeArquivo:String):Integer;

Var HDll:THandle; NomeDll:String;

implementation

///////////////////////////////////////
Function AbrirDll:Boolean;
///////////////////////////////////////
Begin
   HDll := LoadLibrary(PChar('GeraCat.dll'));

   If ( HDll = 0 ) Then begin
      Result := False;
      NomeDll := '';
   End else begin
      Result := True;
      NomeDll := 'GeraCat.dll';
   End;
End;

////////////////////
//Fecha a dll aberta na memória
////////////////////
Procedure FecharDll;
////////////////////
Begin
   FreeLibrary(HDll);
End;

////////////////////////////////////////////////////////////
Function Modelo1_Registro_10(CNPJ:String;
                             DataInicio:String;
                             DataFinal:String):Integer;
////////////////////////////////////////////////////////////
Var
   CallDll:function(CNPJ:String;
                    DataInicio:String;
                    DataFinal:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Modelo1_Registro_10');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(CNPJ,
                        DataInicio,
                        DataFinal);
   End;
end;

////////////////////////////////////////////////////////////////////////
Function Modelo1_Registro_20(FuncaoRegistro:String;
                             JustificativaCancelamento:String;
                             DescricaoNaturezaOperacao:String;
                             SerieNota:String;
                             NumeroNota:String;
                             DataEmissao:String;
                             DataSaidaEntrada:String;
                             TipoNota:String;
                             CFOP:String;
                             IEST:String;
                             IM_Emitente:String;
                             CNPJ_CPF_Destinatario:String;
                             IE_Destinatario:String;
                             Nome_Destinatario:String;
                             Logradouro_Destinatario:String;
                             Numero_Destinatario:String;
                             Complemento_Destinatario:String;
                             Bairro_Destinatario:String;
                             Cidade_Destinatario:String;
                             UF_Destinatario:String;
                             CEP_Destinatario:String;
                             Pais_Destinatario:String;
                             Telefone_Destinatario:String):Integer;
////////////////////////////////////////////////////////////////////////
Var
   CallDll:function(FuncaoRegistro:String;
                    JustificativaCancelamento:String;
                    DescricaoNaturezaOperacao:String;
                    SerieNota:String;
                    NumeroNota:String;
                    DataEmissao:String;
                    DataSaidaEntrada:String;
                    TipoNota:String;
                    CFOP:String;
                    IEST:String;
                    IM_Emitente:String;
                    CNPJ_CPF_Destinatario:String;
                    IE_Destinatario:String;
                    Nome_Destinatario:String;
                    Logradouro_Destinatario:String;
                    Numero_Destinatario:String;
                    Complemento_Destinatario:String;
                    Bairro_Destinatario:String;
                    Cidade_Destinatario:String;
                    UF_Destinatario:String;
                    CEP_Destinatario:String;
                    Pais_Destinatario:String;
                    Telefone_Destinatario:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Modelo1_Registro_20');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(FuncaoRegistro,
                        JustificativaCancelamento,
                        DescricaoNaturezaOperacao,
                        SerieNota,
                        NumeroNota,
                        DataEmissao,
                        DataSaidaEntrada,
                        TipoNota,
                        CFOP,
                        IEST,
                        IM_Emitente,
                        CNPJ_CPF_Destinatario,
                        IE_Destinatario,
                        Nome_Destinatario,
                        Logradouro_Destinatario,
                        Numero_Destinatario,
                        Complemento_Destinatario,
                        Bairro_Destinatario,
                        Cidade_Destinatario,
                        UF_Destinatario,
                        CEP_Destinatario,
                        Pais_Destinatario,
                        Telefone_Destinatario)
   End;
End;


///////////////////////////////////////////////////////////
Function Modelo1_Registro_30(CodigoProduto:String;
                             DescricaoProduto:String;
                             CodigoNCM:String;
                             Unidade:String;
                             Quantidade:String;
                             ValorUnitario:String;
                             ValorTotal:String;
                             CST:String;
                             AliquotaICMS:String;
                             AliquotaIPI:String;
                             ValorIPI:String):Integer;
///////////////////////////////////////////////////////////
Var
   CallDll:function(CodigoProduto:String;
                    DescricaoProduto:String;
                    CodigoNCM:String;
                    Unidade:String;
                    Quantidade:String;
                    ValorUnitario:String;
                    ValorTotal:String;
                    CST:String;
                    AliquotaICMS:String;
                    AliquotaIPI:String;
                    ValorIPI:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Modelo1_Registro_30');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(CodigoProduto,
                        DescricaoProduto,
                        CodigoNCM,
                        Unidade,
                        Quantidade,
                        ValorUnitario,
                        ValorTotal,
                        CST,
                        AliquotaICMS,
                        AliquotaIPI,
                        ValorIPI);
   End;
end;

////////////////////////////////////////////////////////////////////
//Função utilizada para criar o registro tipo 40
////////////////////////////////////////////////////////////////////
Function Modelo1_Registro_40(BaseCalculoICMS:String;
                             ValorTotalICMS:String;
                             BaseCalculoICMSST:String;
                             ValorTotalICMSST:String;
                             ValorTotalProdutosServicos:String;
                             ValorTotalFrete:String;
                             ValorTotalSeguro:String;
                             ValorTotalDesconto:String;
                             ValorTotalIPI:String;
                             OutrasDespesas:String;
                             ValorTotalNotaFiscal:String;
                             ValorTotalServicos:String;
                             AliquotaISS:String;
                             ValorTotalISS:String):Integer;
////////////////////////////////////////////////////////////////////
Var
   CallDll:function(BaseCalculoICMS:String;
                    ValorTotalICMS:String;
                    BaseCalculoICMSST:String;
                    ValorTotalICMSST:String;
                    ValorTotalProdutosServicos:String;
                    ValorTotalFrete:String;
                    ValorTotalSeguro:String;
                    ValorTotalDesconto:String;
                    ValorTotalIPI:String;
                    OutrasDespesas:String;
                    ValorTotalNotaFiscal:String;
                    ValorTotalServicos:String;
                    AliquotaISS:String;
                    ValorTotalISS:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Modelo1_Registro_40');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(BaseCalculoICMS,
                        ValorTotalICMS,
                        BaseCalculoICMSST,
                        ValorTotalICMSST,
                        ValorTotalProdutosServicos,
                        ValorTotalFrete,
                        ValorTotalSeguro,
                        ValorTotalDesconto,
                        ValorTotalIPI,
                        OutrasDespesas,
                        ValorTotalNotaFiscal,
                        ValorTotalServicos,
                        AliquotaISS,
                        ValorTotalISS);
   End;
end;

////////////////////////////////////////////////////////////
//Função Utilizada para gerar o registro tipo 50
////////////////////////////////////////////////////////////
Function Modelo1_Registro_50(ModalidadeFrete:String;
                             CNPJ_CPF:String;
                             Nome:String;
                             InscricaoEstadual:String;
                             EnderecoCompleto:String;
                             Cidade:String;
                             UF:String;
                             PlacaVeiculo:String;
                             UFPlaca:String;
                             QtdeVolumes:String;
                             EspecieVolumes:String;
                             MarcaVolumes:String;
                             NumeracaoVolumes:String;
                             PesoLiquido:String;
                             PesoBruto:String):Integer;
////////////////////////////////////////////////////////////
Var
   CallDll:function(ModalidadeFrete:String;
                    CNPJ_CPF:String;
                    Nome:String;
                    InscricaoEstadual:String;
                    EnderecoCompleto:String;
                    Cidade:String;
                    UF:String;
                    PlacaVeiculo:String;
                    UFPlaca:String;
                    QtdeVolumes:String;
                    EspecieVolumes:String;
                    MarcaVolumes:String;
                    NumeracaoVolumes:String;
                    PesoLiquido:String;
                    PesoBruto:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Modelo1_Registro_50');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(ModalidadeFrete,
                        CNPJ_CPF,
                        Nome,
                        InscricaoEstadual,
                        EnderecoCompleto,
                        Cidade,
                        UF,
                        PlacaVeiculo,
                        UFPlaca,
                        QtdeVolumes,
                        EspecieVolumes,
                        MarcaVolumes,
                        NumeracaoVolumes,
                        PesoLiquido,
                        PesoBruto)
   End;
end;

/////////////////////////////////////////////////////////////////////////
function Modelo1_Registro_60(DadosFatura:String;
                             InformacoesFisco:String;
                             InformacoesContribuite:String):Integer;
/////////////////////////////////////////////////////////////////////////
Var
   CallDll:function(DadosFatura:String;
                    InformacoesFisco:String;
                    InformacoesContribuite:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Modelo1_Registro_60');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(DadosFatura,
                        InformacoesFisco,
                        InformacoesContribuite);
   End;
end;

//////////////////////////////////////////////////////////////
Function Modelo1_Registro_90(NomeArquivo:String):Integer;
//////////////////////////////////////////////////////////////
Var
   CallDll:function(NomeArquivo:String):Integer; stdcall;
begin
   Result := 0;
   @CallDll := GetProcAddress(HDLL,'Modelo1_Registro_90');
   If ( @CallDll <> Nil ) Then begin
      Result := CallDll(NomeArquivo);
   End;
end;


end.
