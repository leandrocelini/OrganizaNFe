unit ECF;

interface

uses Windows, SysUtils, Bematech, mbFuncoes, Classes, Dialogs,
     mbDialogo, Forms, Sweda, Daruma;

Type TTipoECF = (teNenhum,teBematech,teYanco,teSweda,teDaruma);

Type TFlagsFiscais = Record
                        CupomAberto:Boolean;
                        FechamentoIniciado:Boolean;
                        HorarioVerao:Boolean;
                        ReducaoZEmitida:Boolean;
                        PermiteCancelarCupom:Boolean;
                        SemMemoriaFiscal:Boolean;
                     End;

Type TDadosComprovante = Record
                            FormaPg:String;
                            Valor:Currency;
                            NumeroCupom:String;
                            CGC:String;
                            Nome:String;
                            Endereco:String;
                         End;

Type TAliquota = Record
                    Aliquota:Currency;
                    ValorTributado:Currency;
                 End;

Type TDadosUltimaReducao = Record
                              ModoReducao:String;
                              DataMovimento:TDateTime;
                              COO:String;
                              GrandeTotal:Currency;
                              Cancelamentos:Currency;
                              Descontos:Currency;
                              Tributos:Array[1..16] of TAliquota;
                              Isencao:Currency;
                              NaoIncidencia:Currency;
                              SubstTributaria:Currency;
                              Sangrias:Currency;
                              Suprimentos:Currency;
                              Acrescimos:Currency;
                           End;

Type TDadosUltimaReducaoMFD = Record
                                 ModoReducao:String;
                                 ContadorCRO:String;
                                 ContadorReducaoZ:String;
                                 COO:String;
                                 ContadorGeralOperacaoNaoFiscal:String;
                                 ContadorCupomFiscal:String;
                                 ContadorGeralRelatorioGerencial:String;
                                 ContadorFitaDetalheEmitida:String;
                                 ContadorOperacaoNaoFiscalCancelada:String;
                                 ContadorCupomFiscalCancelado:String;
                                 ContadorCDCsEmitidos:String;
                                 ContadorCDCsNaoEmitidos:String;
                                 ContadorCDCsCancelados:String;
                                 TotalizadorGeral:Currency;
                                 Tributos:Array[1..16] of TAliquota;
                                 IsencaoICMS:Currency;
                                 NaoIncidenciaICMS:Currency;
                                 SubstTributariaICMS:Currency;
                                 IsencaoISSQN:Currency;
                                 NaoIncidenciaISSQN:Currency;
                                 SubstTributariaISSQN:Currency;
                                 DescontosICMS:Currency;
                                 DescontosISSQN:Currency;
                                 AcrescimosICMS:Currency;
                                 AcrescimosISSQN:Currency;
                                 CancelamentosICMS:Currency;
                                 CancelamentosISSQN:Currency;
                                 Sangrias:Currency;
                                 Suprimentos:Currency;
                                 CancelamentosNaoFiscais:Currency;
                                 DescontosNaoFiscais:Currency;
                                 AcrescimosNaoFiscais:Currency;
                                 DataMovimento:TDateTime;
                              End;

Function AssinarArquivo(sFile:String):Boolean;
Function Inicializa_ECF(Tipo_ECF:TTipoECF;Var Erro:String):Boolean;
Function Verifica_ECF_Ok:Boolean;
Function Finaliza_ECF(Var Erro:String):Boolean;
Function Leitura_X(Var Erro:String):Boolean;
Function Reducao_Z(Var Erro:String):Boolean;
Function Ler_Aliquotas_ECF(Var Aliquotas:TStringList;Var Erro:String):Boolean;
Function DataHora_ECF(Var DataHora:TDateTime;Var Erro:String):Boolean;
Function DataHora_Reducao_Z(Var DataHora:TDateTime;Var Erro:String):Boolean;
Function Data_Ultimo_Movimento(Var DataHora:TDateTime;Var Erro:String):Boolean;
Function Valida_DataHora_ECF(Var Erro:String):Boolean;
Function Programa_Aliquota_ECF(Aliquota:Currency;Vinculo:Integer;Var Erro:String):Boolean;
Function Numero_Caixa(Var NumeroCaixa:Integer;Var Erro:String):Boolean;
Function Numero_Serie_ECF(Var NumeroSerie:String;Var Erro:String):Boolean;
Function Programa_Simbolo_Moeda_ECF(Simbolo:String;Var Erro:String):Boolean;
Function Ler_Simbolo_Moeda_ECF(Var Simbolo:String;Var Erro:String):Boolean;
Function Imprime_Nao_Fiscal(Dados:TStringList;Var Erro:String;
                            IniciaNovo:Boolean=True;
                            FechaRelatorio:Boolean=True):Boolean;
Function Ler_Memoria_Fiscal_Data(dInicio,dFinal:TDateTime;Var Erro:String):Boolean;
Function Programa_Arredondamento(Var Erro:String):Boolean;
Function Programa_Truncamento(Var Erro:String):Boolean;
Function Verifica_Truncamento(Var Tipo:Integer;Var Erro:String):Boolean;
Function Ler_Versao_Firmware(Var Versao:String;Var Erro:String):Boolean;
Function FlagsFiscais(Var Flags:TFlagsFiscais;Var Erro:String):Boolean;
Function Retorno_ECF:Boolean;
Function Programa_Horario_Verao(Var Erro:String):Boolean;
Function Abre_Cupom(CNPJ_CPF:String;Var Erro:String):Boolean;
Function Vende_Item(Codigo,Descricao:String;Aliquota:Integer;Quantidade:Currency;
                    UnidadeMedida:String;ValorUnitario,ValorDesconto:Currency;
                    Var Erro:String):Boolean;
Function Cancela_Item(Item:Integer;Var Erro:String):Boolean;
Function Inicia_Fechamento_Cupom(AcrescimoDesconto,TipoAcrescimoDesconto:String;
                                 Valor:Currency;Var Erro:String):Boolean;
Function Efetua_Forma_Pagamento(FormaPagamento:String;Valor:Currency;Var Erro:String):Boolean;
Function Termina_Fechamento_Cupom(Mensagem:String; Var Erro:String):Boolean;
Function Numero_Cupom_Fiscal(Var NumeroCupom:String;Var Erro:String):Boolean;
Function Cancela_Cupom_Fiscal(Var Erro:String):Boolean;
Function Imprime_Comprovante_Vinculado(DadosComprovante:TDadosComprovante;
         Var Texto:TStringList; Var Erro:String):Boolean;
Function Sangria_ECF(Valor:Currency; Var Erro:String):Boolean;
Function Suprimento_ECF(Valor:Currency;Tipo:String;Var Erro:String):Boolean;
Function Abrir_Gaveta_ECF(Var Erro:String):Boolean;
Function Retorna_Sn_Ecf_Txt:String;
Function Aciona_Guilhotina(Var Erro:String):Boolean;
Procedure Inicia_Modo_TEF;
Procedure Finaliza_Modo_TEF;
Function Gera_CAT52(Data:TDateTime;Var Erro:String):Boolean;
Function Versao_Dll_ECF:String;
Function Configura_Linhas_Entre_Cupons(iLinhas:Integer;Var Erro:String):Boolean;
Function Configura_Espaco_Entre_Linhas(iDots:Integer;Var Erro:String):Boolean;
Function Verifica_Formas_Pagamento(FormaPg:TStringList;Var Erro:String):Boolean;
Function Programa_Forma_Pagamento(FormaPg:String;Vinculado:Boolean;Var Erro:String):Boolean;
Function Verifica_Z_Pendente(Var Pendente:Boolean;Var Erro:String):Boolean;
Function Pega_Dados_Ultima_Reducao(Var DadosUltimaReducao:TDadosUltimaReducao;
                                   Var Erro:String):Boolean;
Function Pega_Dados_Ultima_ReducaoMFD(Var DadosUltimaReducao:TDadosUltimaReducaoMFD;
                                      Var Erro:String):Boolean;
Function Imprime_Leitura_Memoria_Fiscal_Data_MFD(dInicio,dFinal:TDateTime;
                                                 sTipo:String;Var Erro:String):Boolean;
Function Salvar_Leitura_Memoria_Fiscal_Data_MFD(dInicio,dFinal:TDateTime;
                                                sTipo:String;
                                                sLocal:String;Var Erro:String):Boolean;
Function Imprime_Leitura_Memoria_Fiscal_Reducao_MFD(sInicio,sFinal,sTipo:String;
                                                    Var Erro:String):Boolean;
Function Salvar_Leitura_Memoria_Fiscal_Reducao_MFD(sInicio,sFinal:String;
                                                   sTipo:String;
                                                   sLocal:String;Var Erro:String):Boolean;
Procedure VerificaFechaNaoFiscalAberto;

Var TipoECF:TTipoECF;
    ModeloECF:String;
    ModoFiscal:String;
    LocalRetorno:String;
    FL_ECF:String;
    NumeroLinhasNaoFiscal:Integer;
    ShowMsgEcf:Boolean;
    AvisoPoucoPapel:Boolean;
    RetornouMsgEcf:Boolean;
    ModoTEFLigado:Boolean;
    UltimaMsgEcf:String;
    MsgPromocional:String;
    DecimaisPrecoVenda:Integer;
    DecimaisQuantidade:Integer;
    ChavePrivada:TResourceStream;
    ChavePublica:TResourceStream;
    UltimoCupomCancelado:Boolean;

implementation

Uses TEF;

//////////////////////////////////////////////
//Função Utilizada para assinar o arquivo digitalmente
//
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////
Function AssinarArquivo(sFile:String):Boolean;
//////////////////////////////////////////////
Var ResultMD5, RegistroEAD:String;
    FArquivo:TextFile;
begin
   Result := False;
{
   If FileExists(sFile) Then begin
      ResultMD5 := GeraMD5Cotepe(sFile);
      If ( ResultMD5 <> '' ) Then begin
         RegistroEAD := Sign_RSA_MD5_Stream(ChavePrivada,ResultMD5);

         //Verifica se foi gerado corretamente
         If ( RegistroEAD <> '' ) Then begin
            //Inclui o identificador do registro
            RegistroEAD := 'EAD' + RegistroEAD;
            Try
               AssignFile(FArquivo,sFile);
               Append(FArquivo);
               WriteLn(FArquivo,RegistroEAD);
               CloseFile(FArquivo);
               Result := True;
            Except
               Result := False;
            End;
         End;
      End;
   End;
}
end;


///////////////////////////////////////////////////////////////////
//Função utilizada para inicializar a ECF
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////
Function Inicializa_Ecf(Tipo_ECF:TTipoECF;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////
Var Retorno:Integer;
begin
   //Inicializa as variáveis
   Result := True;
   ShowMsgEcf := True;
   RetornouMsgEcf := False;
   ModoTEFLigado := False;
   UltimaMsgEcf := '';
   LocalRetorno := 'C:\';
   UltimoCupomCancelado := False;

   If ( Tipo_ECF = teBematech ) Then begin
      Retorno := Bematech_FI_AbrePortaSerial;
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;

      Try
         //Verifica se a ECF esta ligada
         Retorno := Bematech_FI_VerificaImpressoraLigada();

         If Retorno_ECF Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Bematech_Erros(Retorno);
            Result := False;
         End;
      Except
         On E:Exception do begin
            Erro :=  'Erro ao executar o camando: Bematech_FI_VerificaImpressoraLigada()' + #13 +
                     E.Message;
            Result := False;
            Exit;
         End;
      End;

      //Informa a quantidade de casas decimais da ECF
      ECF.DecimaisPrecoVenda := 3;
      ECF.DecimaisQuantidade := 3;

      //Se possuir algum relatório não fiscal aberto fecha
      Bematech_FI_FechaRelatorioGerencial();
   End else If ( Tipo_ECF = teSweda ) Then begin
      If Sweda.AbrirDll() Then begin
         Retorno := Sweda.ECF_AbrePortaSerial;
         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Sweda.ECF_Erros(Retorno);
            Result := False;
         End;

         If Result Then begin
            //Informa a quantidade de casas decimais da ECF
            ECF.DecimaisPrecoVenda := 3;
            ECF.DecimaisQuantidade := 3;
         End else begin
            Sweda.ECF_FechaPortaSerial();
            Sweda.FecharDll();
         End;
      End else begin
         Erro := 'CONVECF.DLL não encontrado!!!';
         Result := False;
      End;
   End else If ( Tipo_ECF = teDaruma ) Then begin
      If Daruma.AbrirDll() Then begin
         Retorno := Daruma_FI_AbrePortaSerial();
         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Daruma_FI_Erros(Retorno);
            Result := False;
         End;

         If Result Then begin
            //Informa a quantidade de casas decimais da ECF
            ECF.DecimaisPrecoVenda := 3;
            ECF.DecimaisQuantidade := 3;
         End else begin
            Daruma_FI_FechaPortaSerial();
            Daruma.FecharDll();
         End;
      End else begin
         Erro := 'Daruma32.DLL não encontrado!!!';
         Result := False;
      End;
   End;

   If Result Then begin
      TipoECF := Tipo_ECF;
   End else begin
      TipoECF := teNenhum;
   End;
end;

/////////////////////////////////
//Função Utilizada para verificar se o ECF esta ok
// Se estiver Ok = True
/////////////////////////////////
Function Verifica_ECF_Ok:Boolean;
/////////////////////////////////
Var Retorno:Integer;
begin
   Result := True;

   If ( TipoECF = teBematech ) Then begin
      //Verifica se a ECF esta ligada
      Retorno := Bematech_FI_VerificaImpressoraLigada();

      If Retorno_ECF() Then begin
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin

   End;
end;

///////////////////////////////////////////////
//Função Utilizada para Finalizar a Ecf
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////
Function Finaliza_Ecf(Var Erro:String):Boolean;
///////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_FechaPortaSerial();
      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_FechaPortaSerial();
      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;

      Sweda.FecharDll();
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_FechaPortaSerial();
      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;

      Daruma.FecharDll();
   End;
End;

////////////////////////////////////////////
//Função Utilizada para emitir a leitura X
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////
Function Leitura_X(Var Erro:String):Boolean;
////////////////////////////////////////////
Var Retorno:Integer;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_LeituraX();
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_LeituraX();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_LeituraX();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

////////////////////////////////////////////
//Emite a redução z na ECF
//Parametros:
// Erro - Retorna a descrição do erro se houve
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////
function Reducao_Z(Var Erro:String):Boolean;
////////////////////////////////////////////
Var Retorno:Integer; Data,Hora:String;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Data := FormatDateTime('dd/mm/yyyy',Date());
      Hora := FormatDateTime('hh:nn:ss',Time());
      Retorno := Bematech_FI_ReducaoZ(pchar(Data),
                                      pchar(Hora));
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Data := FormatDateTime('dd/mm/yyyy',Date());
      Hora := FormatDateTime('hh:nn:ss',Time());
      Retorno := Sweda.ECF_ReducaoZ(pchar(Data),pchar(Hora));
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Data := FormatDateTime('dd/mm/yyyy',Date());
      Hora := FormatDateTime('hh:nn:ss',Time());
      Retorno := Daruma_FI_ReducaoZ(pchar(Data),pchar(Hora));
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////////////////////////////////
//Função utilizad apara leitura de aliquotas da ECF
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////////////
Function Ler_Aliquotas_ECF(Var Aliquotas:TStringList;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; RetAliq,Valor:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      RetAliq := mbFuncoes.Space(79);
      Retorno := Bematech_FI_RetornoAliquotas(RetAliq);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End else begin
         Aliquotas := TStringList.Create;

         While ( RetAliq <> '' ) do begin
            If ( Pos(',',RetAliq) > 0 ) Then begin
               Valor := Copy(RetAliq,1,Pos(',',RetAliq)-1);
            End else begin
               Valor := Copy(RetAliq,1,4);
            End;

            If ( Valor <> '' ) Then begin
               Valor := Copy(Valor,1,2) + DecimalSeparator + Copy(Valor,3,2);
               Aliquotas.Add(Valor);
            End;

            If ( Pos(',',RetAliq) > 0 ) Then begin
               RetAliq := Copy(RetAliq,Pos(',',RetAliq)+1,Length(RetAliq));
            End else begin
               RetAliq := '';
            End;
         End;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      RetAliq := mbFuncoes.Space(79);
      Retorno := Sweda.ECF_RetornoAliquotas(RetAliq);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End else begin
         Aliquotas := TStringList.Create;

         While ( RetAliq <> '' ) do begin
            If ( Pos(',',RetAliq) > 0 ) Then begin
               Valor := Copy(RetAliq,1,Pos(',',RetAliq)-1);
            End else begin
               Valor := Copy(RetAliq,1,4);
            End;

            If ( Valor <> '' ) Then begin
               Valor := Copy(Valor,1,2) + DecimalSeparator + Copy(Valor,3,2);
               Aliquotas.Add(Valor);
            End;

            If ( Pos(',',RetAliq) > 0 ) Then begin
               RetAliq := Copy(RetAliq,Pos(',',RetAliq)+1,Length(RetAliq));
            End else begin
               RetAliq := '';
            End;
         End;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      RetAliq := mbFuncoes.Space(79);
      Retorno := Daruma_FI_RetornoAliquotas(RetAliq);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End else begin
         Aliquotas := TStringList.Create;

         While ( RetAliq <> '' ) do begin
            If ( Pos(',',RetAliq) > 0 ) Then begin
               Valor := Copy(RetAliq,1,Pos(',',RetAliq)-1);
            End else begin
               Valor := Copy(RetAliq,1,4);
            End;

            If ( Valor <> '' ) Then begin
               Valor := Copy(Valor,1,2) + DecimalSeparator + Copy(Valor,3,2);
               Aliquotas.Add(Valor);
            End;

            If ( Pos(',',RetAliq) > 0 ) Then begin
               RetAliq := Copy(RetAliq,Pos(',',RetAliq)+1,Length(RetAliq));
            End else begin
               RetAliq := '';
            End;
         End;
      End;
   End;
End;

//////////////////////////////////////////////////////////////////////
//Função Utilizada para retorna data e hora da ECF
//
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////
Function DataHora_ECF(Var DataHora:TDateTime;Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////
Var Retorno:Integer; Data,Hora:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Data := Space(6);
      Hora := Space(6);

      Retorno := Bematech_FI_DataHoraImpressora(Data,Hora);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         Hora := Copy(Hora,1,2) + ':' +
                 Copy(Hora,3,2) + ':' +
                 Copy(Hora,5,2);
         DataHora := StrToDateTimeDef(Data + ' ' + Hora,Now());
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Data := Space(6);
      Hora := Space(6);

      Retorno := Sweda.ECF_DataHoraImpressora(Data,Hora);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         Hora := Copy(Hora,1,2) + ':' +
                 Copy(Hora,3,2) + ':' +
                 Copy(Hora,5,2);
         DataHora := StrToDateTimeDef(Data + ' ' + Hora,Now());
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Data := Space(6);
      Hora := Space(6);

      Retorno := Daruma_FI_DataHoraImpressora(Data,Hora);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         Hora := Copy(Hora,1,2) + ':' +
                 Copy(Hora,3,2) + ':' +
                 Copy(Hora,5,2);
         DataHora := StrToDateTimeDef(Data + ' ' + Hora,Now());
      End;
   End;
End;

///////////////////////////////////////////////////////////////////////////
//Função Utilizada para retorna data e hora da Redução Z
//
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////
Function DataHora_Reducao_Z(Var DataHora:TDateTime;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; Data,Hora:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Data := Space(6);
      Hora := Space(6);

      Retorno := Bematech_FI_DataHoraReducao(Data,Hora);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         Hora := Copy(Hora,1,2) + ':' +
                 Copy(Hora,3,2) + ':' +
                 Copy(Hora,5,2);
         DataHora := StrToDateTimeDef(Data + ' ' + Hora,0);
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Data := Space(6);
      Hora := Space(6);

      Retorno := Sweda.ECF_DataHoraReducao(Data,Hora);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         Hora := Copy(Hora,1,2) + ':' +
                 Copy(Hora,3,2) + ':' +
                 Copy(Hora,5,2);
         DataHora := StrToDateTimeDef(Data + ' ' + Hora,0);
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Data := Space(6);
      Hora := Space(6);

      Retorno := Daruma_FI_DataHoraReducao(Data,Hora);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         Hora := Copy(Hora,1,2) + ':' +
                 Copy(Hora,3,2) + ':' +
                 Copy(Hora,5,2);
         DataHora := StrToDateTimeDef(Data + ' ' + Hora,0);
      End;
   End;
end;

///////////////////////////////////////////////////////////////////////////////
//Função utilizada para retornar a data e hora do ultimo movimento
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////////////
Function Data_Ultimo_Movimento(Var DataHora:TDateTime;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; Data:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Data := Space(6);

      Retorno := Bematech_FI_DataMovimento(Data);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         DataHora := StrToDateTimeDef(Data,0);
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Data := Space(6);

      Retorno := Sweda.ECF_DataMovimento(Data);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         DataHora := StrToDateTimeDef(Data,0);
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Data := Space(6);

      Retorno := Daruma_FI_DataMovimento(Data);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End else begin
         Data := Copy(Data,1,2) + '/' +
                 Copy(Data,3,2) + '/' +
                 Copy(Data,5,2);
         DataHora := StrToDateTimeDef(Data,0);
      End;
   End;
end;

//////////////////////////////////////////////////////
//Função Utilizada para validar a data e a hora do ECF com a do sistema
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////
Function Valida_DataHora_ECF(Var Erro:String):Boolean;
//////////////////////////////////////////////////////
Var DataHoraECF:TDateTime;
    sTempo:String;
    Tempo:TDateTime;
begin
   Result := DataHora_ECF(DataHoraECF,Erro);
   sTempo := mbFuncoes.IntervaloDateTimeToTime(DataHoraECF,Now());
   sTempo := sTempo + ':00';
   Tempo := StrToTimeDef(sTempo,StrToTime('23:59:59'));

   //Se a diferença do tempo for maior que 10 minutos retorna falso
   If ( TimeToMinutes(Tempo) > 10 ) Or
         ( TimeToMinutes(Tempo) < -10 ) Then begin
      Erro := 'Data e hora do ECF errada!!!' + #13 +
              'Data do ECF: ' + DateTimeToStr(DataHoraECF) + #13 +
              'Data do Sistema: ' + DateTimeToStr(Now());
      Result := False;
   End;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//Função utilizada para programar a aliquota na ECF
//Parametros:
// TipoECF:TTIPOECF conectado
// Aliquota:CURRENCY com o valor da Aliquota a ser programada
// Vinculo:INTEIRO com o valor 0 (zero) para vincular a alíquota ao ICMS e 1 (um) para vincular ao ISS.
// Erro:String que retorna a mensage do erro se houver
//
//Retorno:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo F. Bellucci
//////////////////////////////////////////////////////////////////////////////////////////
Function Programa_Aliquota_ECF(Aliquota:Currency;Vinculo:Integer;Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; sAliquota:String;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      sAliquota := mbFuncoes.Transform('00.00',Aliquota);
      sAliquota := Copy(sAliquota,1,2) + Copy(sAliquota,4,2);
      Retorno := Bematech_FI_ProgramaAliquota(PChar(sAliquota),Vinculo);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sAliquota := mbFuncoes.Transform('00.00',Aliquota);
      sAliquota := Copy(sAliquota,1,2) + Copy(sAliquota,4,2);
      Retorno := Sweda.ECF_ProgramaAliquota(PChar(sAliquota),Vinculo);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sAliquota := mbFuncoes.Transform('00.00',Aliquota);
      sAliquota := Copy(sAliquota,1,2) + Copy(sAliquota,4,2);
      Retorno := Daruma_FI_ProgramaAliquota(PChar(sAliquota),Vinculo);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////////////////////////
//Função utilizada para retornar o número do caixa que esta cadastrado na ECF
//Parametros:
//
//Retornos:
// BOOLEAN - True para operção Ok
//           False para operação com erro
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////
Function Numero_Caixa(Var NumeroCaixa:Integer;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////
Var Retorno:Integer; sNumeroCaixa:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      sNumeroCaixa := Space(6);
      Retorno := Bematech_FI_NumeroCaixa(sNumeroCaixa);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End else begin
         NumeroCaixa := StrToIntDef(sNumeroCaixa,0);
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sNumeroCaixa := Space(6);
      Retorno := Sweda.ECF_NumeroCaixa(sNumeroCaixa);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End else begin
         NumeroCaixa := StrToIntDef(sNumeroCaixa,0);
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sNumeroCaixa := Space(6);
      Retorno := Daruma_FI_NumeroCaixa(sNumeroCaixa);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End else begin
         NumeroCaixa := StrToIntDef(sNumeroCaixa,0);
      End;
   End;
End;

//////////////////////////////////////////////////////////////////////////
//Função Utilizada para retornar o número de série da ECF
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////
Function Numero_Serie_ECF(Var NumeroSerie:String;Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      If ( ModeloECF = 'Termica' ) Then begin
         NumeroSerie := Space(20);
         Retorno := Bematech_FI_NumeroSerieMFD(NumeroSerie);
      End else begin
         NumeroSerie := Space(15);
         Retorno := Bematech_FI_NumeroSerie(NumeroSerie);
      End;

      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      NumeroSerie := Space(20);
      Retorno := Sweda.ECF_NumeroSerie(NumeroSerie);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      NumeroSerie := Space(20);
      Retorno := Daruma_FI_NumeroSerie(NumeroSerie);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

////////////////////////////////////////////////////////////////////////////
Function Programa_Simbolo_Moeda_ECF(Simbolo:String;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      If Length(Simbolo) = 1 Then Simbolo := ' ' + Simbolo;
      Retorno := Bematech_FI_AlteraSimboloMoeda(PChar(Simbolo));
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////////////////////////////
Function Ler_Simbolo_Moeda_ECF(Var Simbolo:String;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Simbolo := Space(2);
      Retorno := Bematech_FI_SimboloMoeda(Simbolo);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////////////////////////
//Imprime documento não fiscal no ECF
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////
Function Imprime_Nao_Fiscal(Dados:TStringList;Var Erro:String;
                            IniciaNovo:Boolean=True;
                            FechaRelatorio:Boolean=True):Boolean;
///////////////////////////////////////////////////////////////////////
Var Retorno,i,n,nLinhas:Integer;
    sIndice,sDados,sTipo:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      //Verifica se deve sempre iniciar um novo relatório gerencial
      If IniciaNovo Then begin
         If ( ModeloECF = 'Termica' ) Then begin
            //Abre o relatório gerencial
            sIndice := '1';
            Retorno := Bematech_FI_AbreRelatorioGerencialMFD( pchar(sIndice) );

            If Retorno_ECF() Then begin
               Erro := 'Comando não executado!!!';
               Result := False;
               Exit;
            End;

            If ( Retorno <= 0 ) Then begin
               Erro := Bematech_Erros(Retorno);
               Result := False;
               Exit
            End;
         End else begin
            //Se for impressora matricial tenta enviar comando para fechar
            //relatório gerencial mas não retorna erro
            Bematech_FI_FechaRelatorioGerencial();
         End;
      End;

      n := Dados.Count-1;
      For i := 0 to n do begin
         If ( Dados.Strings[i] = '***Funcao_Aciona_Guilhotina***' ) Then begin
            //Aciona a guilhotina
            ECF.Aciona_Guilhotina(Erro);
         End else begin
            Retorno := Bematech_FI_RelatorioGerencial(PChar(Dados.Strings[i]+FL_ECF));

            If Retorno_ECF() Then begin
               Erro := 'Comando não executado!!!';
               Result := False;
               Exit;
            End;
            If ( Retorno <= 0 ) Then begin
               Erro := Bematech_Erros(Retorno);
               Result := False;
               Exit;
            End;
         End;
      End;

      If ( Result ) And ( FechaRelatorio ) Then begin
         Retorno := Bematech_FI_FechaRelatorioGerencial();
         If Retorno_ECF Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
            Exit;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Bematech_Erros(Retorno);
            Result := False;
            Exit;
         End;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      //Verifica se deve sempre iniciar um novo relatório gerencial
      If IniciaNovo Then begin
         //Se o relatório gerencial estiver aberto fecha
         sTipo := #0; SetLength(sTipo,1);
         Sweda.ECF_StatusRelatorioGerencial(sTipo);
         If ( sTipo = '1' ) Then begin
            Sweda.ECF_FechaRelatorioGerencial();
         End;

         //Abre o relatório gerencial
         sIndice := '1';
         Retorno := Sweda.ECF_AbreRelatorioGerencialMFD( pchar(sIndice) );

         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
            Exit;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Sweda.ECF_Erros(Retorno);
            Result := False;
            Exit
         End;
      End;

      nLinhas := 0;
      sDados := '';
      n := Dados.Count-1;
      For i := 0 to n do begin
         Inc(nLinhas);

         If ( Dados.Strings[i] = '***Funcao_Aciona_Guilhotina***' ) Then begin
            //Se houver dados no buffer imprime primeiro para depois assionar a guilhotina
            If ( sDados <> '' ) Then begin
               Retorno := Sweda.ECF_UsaRelatorioGerencialMFD(PChar(sDados));

               If Retorno_ECF() Then begin
                  Erro := 'Comando não executado!!!';
                  Result := False;
                  Exit;
               End;
               If ( Retorno <= 0 ) Then begin
                  Erro := Sweda.ECF_Erros(Retorno);
                  Result := False;
                  Exit;
               End;
            End;

            //Aciona a guilhotina
            ECF.Aciona_Guilhotina(Erro);

            nLinhas := 0;
            sDados  := '';
         End else begin
            sDados := sDados + Dados.Strings[i]+FL_ECF;

            //Se atingiu o numero de linhas manda para a impressora
            If ( nLinhas = NumeroLinhasNaoFiscal ) Or ( i = n ) Then begin
               Retorno := Sweda.ECF_UsaRelatorioGerencialMFD(PChar(sDados));

               If Retorno_ECF() Then begin
                  Erro := 'Comando não executado!!!';
                  Result := False;
                  Exit;
               End;
               If ( Retorno <= 0 ) Then begin
                  Erro := Sweda.ECF_Erros(Retorno);
                  Result := False;
                  Exit;
               End;

               nLinhas := 0;
               sDados  := '';
            End;
         End;
      End;

      If ( Result ) And ( FechaRelatorio ) Then begin
         Retorno := Sweda.ECF_FechaRelatorioGerencial();
         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
            Exit;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Sweda.ECF_Erros(Retorno);
            Result := False;
            Exit;
         End;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      //Verifica se deve sempre iniciar um novo relatório gerencial
      If IniciaNovo Then begin
         //Força fechar relatório rerencial se possuir algum aberto
         Daruma_FI_FechaRelatorioGerencial();

         //Abre o relatório gerencial
         sIndice := '1';
         Retorno := Daruma_FI_AbreRelatorioGerencial();

         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
            Exit;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Daruma_FI_Erros(Retorno);
            Result := False;
            Exit
         End;
      End;

      n := Dados.Count-1;
      For i := 0 to n do begin
         If ( Dados.Strings[i] = '***Funcao_Aciona_Guilhotina***' ) Then begin
            //Aciona a guilhotina
            ECF.Aciona_Guilhotina(Erro);
         End else begin
            Retorno := Daruma_FI_RelatorioGerencial(PChar(Dados.Strings[i]+FL_ECF));

            If Retorno_ECF() Then begin
               Erro := 'Comando não executado!!!';
               Result := False;
               Exit;
            End;
            If ( Retorno <= 0 ) Then begin
               Erro := Daruma_FI_Erros(Retorno);
               Result := False;
               Exit;
            End;
         End;
      End;

      If ( Result ) And ( FechaRelatorio ) Then begin
         Retorno := Daruma_FI_FechaRelatorioGerencial();
         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
            Exit;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Daruma_FI_Erros(Retorno);
            Result := False;
            Exit;
         End;
      End;
   End;
End;

///////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para imprimir os dados da memória fiscal por periodo
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////////////////
Function Ler_Memoria_Fiscal_Data(dInicio,dFinal:TDateTime;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; sInicio,sFinal:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      sInicio := DateToStr(dInicio);
      sFinal := DateToStr(dFinal);
      Retorno := Bematech_FI_LeituraMemoriaFiscalData(PChar(sInicio),PChar(sFinal));
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sInicio := DateToStr(dInicio);
      sFinal := DateToStr(dFinal);
      Retorno := Sweda.ECF_LeituraMemoriaFiscalData(PChar(sInicio),PChar(sFinal));
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sInicio := DateToStr(dInicio);
      sFinal := DateToStr(dFinal);
      Retorno := Daruma_FI_LeituraMemoriaFiscalData(PChar(sInicio),PChar(sFinal));
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

//////////////////////////////////////////////////////////
//Função Utilizada para Programar Arredondamento na ECF
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////
Function Programa_Arredondamento(Var Erro:String):Boolean;
//////////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_ProgramaArredondamento();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_ProgramaArredondamento();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_ProgramaArredondamento();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////////
//Função Utilizada para programa Truncamento na ECF
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////
Function Programa_Truncamento(Var Erro:String):Boolean;
///////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_ProgramaTruncamento();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_ProgramaTruncamento();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_ProgramaTruncamento();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

////////////////////////////////////////////////////////////////////////
//Função Utilizada para verificar o truncamento da ECF
//Parametros:
// Tipo - Retorna 1 se a impressora estiver no modo truncamento
//        Retorna 2 se a impressora estiver no modo arredondamento
// Erro - Retorna a descrição do Erro
//Retorno:
// True - Função Executada
// False - Função não executada
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////
Function Verifica_Truncamento(Var Tipo:Integer;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; sTipo:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      sTipo := Space(2);
      Retorno := Bematech_FI_VerificaTruncamento(sTipo);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End else begin
         Tipo := StrToInt(Copy(sTipo,1,1));
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sTipo := Space(2);
      Retorno := Sweda.ECF_VerificaTruncamento(sTipo);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End else begin
         Tipo := StrToInt(Copy(sTipo,1,1));
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sTipo := Space(2);
      Retorno := Daruma_FI_VerificaTruncamento(sTipo);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End else begin
         Tipo := StrToInt(Copy(sTipo,1,1));
      End;
   End;
End;

////////////////////////////////////////////////////////////////////////
//Função que retorna a versão do firmware da ECF
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////
Function Ler_Versao_Firmware(Var Versao:String;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Versao := Space(4);
      Retorno := Bematech_FI_VersaoFirmware(Versao);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Versao := Space(10);
      Retorno := Sweda.ECF_VersaoFirmware(PChar(Versao));
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Versao := Space(10);
      Retorno := Daruma_FI_VersaoFirmware(PChar(Versao));
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////////////////////////
//Função utilizada para retornar as flags fiscais do ECF
//Parametros:
//      Flags.CupomAberto = True - Indica que o ECF contem um cupom Aberto
//      Flags.FechamentoIniciado = True - Indica que foi iniciada a forma de pagamento
//      Flags.HorarioVerao = True - Indica que a ecf esta trabalhando com horário de verão
//      Flags.ReducaoZEmitida = True - Indica que já foi emitida a redução Z do dia
//      Flags.PermiteCancelarCupom = True - Indica que é possivel cancelar o cupom fical
//      Flags.SemMemoriaFiscal = True - Indica que a ECF esta sem memória fiscal
//Retorno:
//      True - Se a função foi executada
//      False - Se houve algum erro
//Autor: João Paulo F. Bellucci
///////////////////////////////////////////////////////////////////////
Function FlagsFiscais(Var Flags:TFlagsFiscais;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////
Var Retorno,iFlags:Integer; sFlags:String;
Begin
   Result := True;
   Flags.CupomAberto := False;
   Flags.FechamentoIniciado := False;
   Flags.HorarioVerao := False;
   Flags.ReducaoZEmitida := False;
   Flags.PermiteCancelarCupom := False;
   Flags.SemMemoriaFiscal := False;

   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_FlagsFiscais(iFlags);
      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End else begin
         sFlags := mbFuncoes.IntToBin(iFlags,8);

         If ( sFlags[8] = '1' ) Then begin
            Flags.CupomAberto := True;
         End;
         If ( sFlags[7] = '1' ) Then begin
            Flags.FechamentoIniciado := True;
         End;
         If ( sFlags[6] = '1' ) Then begin
            Flags.HorarioVerao := True;
         End;
         If ( sFlags[5] = '1' ) Then begin
            Flags.ReducaoZEmitida := True;
         End;
         If ( sFlags[4] = '1' ) Then begin
            //Reservado
         End;
         If ( sFlags[3] = '1' ) Then begin
            Flags.PermiteCancelarCupom := True;
         End;
         If ( sFlags[2] = '1' ) Then begin
            //Reservado
         End;
         If ( sFlags[1] = '1' ) Then begin
            Flags.SemMemoriaFiscal := True;
         End;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_FlagsFiscais(iFlags);
      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End else begin
         sFlags := mbFuncoes.IntToBin(iFlags,8);

         If ( sFlags[8] = '1' ) Then begin
            Flags.CupomAberto := True;
         End;
         If ( sFlags[7] = '1' ) Then begin
            Flags.FechamentoIniciado := True;
         End;
         If ( sFlags[6] = '1' ) Then begin
            Flags.HorarioVerao := True;
         End;
         If ( sFlags[5] = '1' ) Then begin
            Flags.ReducaoZEmitida := True;
         End;
         If ( sFlags[4] = '1' ) Then begin
            //Reservado
         End;
         If ( sFlags[3] = '1' ) Then begin
            Flags.PermiteCancelarCupom := True;
         End;
         If ( sFlags[2] = '1' ) Then begin
            //Reservado
         End;
         If ( sFlags[1] = '1' ) Then begin
            Flags.SemMemoriaFiscal := True;
         End;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_FlagsFiscais(iFlags);
      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End else begin
         sFlags := mbFuncoes.IntToBin(iFlags,8);

         If ( sFlags[8] = '1' ) Then begin
            Flags.CupomAberto := True;
         End;
         If ( sFlags[7] = '1' ) Then begin
            Flags.FechamentoIniciado := True;
         End;
         If ( sFlags[6] = '1' ) Then begin
            Flags.HorarioVerao := True;
         End;
         If ( sFlags[5] = '1' ) Then begin
            Flags.ReducaoZEmitida := True;
         End;
         If ( sFlags[4] = '1' ) Then begin
            //Reservado
         End;
         If ( sFlags[3] = '1' ) Then begin
            Flags.PermiteCancelarCupom := True;
         End;
         If ( sFlags[2] = '1' ) Then begin
            //Reservado
         End;
         If ( sFlags[1] = '1' ) Then begin
            Flags.SemMemoriaFiscal := True;
         End;
      End;
   End;
End;

/////////////////////////////
//Função Utilizada para informar o retorna da ECF apos o camando
//Retorno:
//       True - Se houve retorno e o ultimo comando não foi executado
//       False - Quando não houve retorno
/////////////////////////////
Function Retorno_ECF:Boolean;
/////////////////////////////
Var iACK,iST1,iST2,i,n:Integer; sST1,sST2:String; Retorno:TStringList;
    SalvaModoTEF:Boolean;
    ListaRetorno:String;
Begin
   Result := False;
   Retorno := TStringList.Create;
   iACK := 0; iST1 := 0; iST2 := 0;

   If ( TipoECF = teBematech ) Then begin
      Bematech_FI_RetornoImpressora(iACK, iST1, iST2);

      If iACK = 6 then begin
         sST1 := mbFuncoes.IntToBin(iST1,8);
         If ( sST1[1] = '1' ) Then Retorno.Add('ST1 Bit 7 - Fim de Papel');
         If ( sST1[2] = '1' ) Then Retorno.Add('ST1 Bit 6 - Pouco Papel');
         If ( sST1[3] = '1' ) Then Retorno.Add('ST1 Bit 5 - Erro no Relógio');
         If ( sST1[4] = '1' ) Then Retorno.Add('ST1 Bit 4 - Impressora em Erro');
         If ( sST1[5] = '1' ) Then Retorno.Add('ST1 Bit 3 - CMD não iniciado com ESC');
         If ( sST1[6] = '1' ) Then Retorno.Add('ST1 Bit 2 - Comando Inexistente');
         If ( sST1[7] = '1' ) Then Retorno.Add('ST1 Bit 1 - Cupom Aberto');
         If ( sST1[8] = '1' ) Then Retorno.Add('ST1 Bit 0 - Número de paramêtros Invalidos');

         sST2 := mbFuncoes.IntToBin(iST2,8);
         If ( sST2[1] = '1' ) Then Retorno.Add('ST2 Bit 7 - Tipo de parametro inválido');
         If ( sST2[2] = '1' ) Then Retorno.Add('ST2 Bit 6 - Memória Fiscal lotada');
         If ( sST2[3] = '1' ) Then Retorno.Add('ST2 Bit 5 - CMOS não volátil');
         If ( sST2[4] = '1' ) Then Retorno.Add('ST2 Bit 4 - Aliquota não programada');
         If ( sST2[5] = '1' ) Then Retorno.Add('ST2 Bit 3 - Aliquotas lotadas');
         If ( sST2[6] = '1' ) Then Retorno.Add('ST2 Bit 2 - Cancelamento não permitido');
         If ( sST2[7] = '1' ) Then Retorno.Add('ST2 Bit 1 - CGC/IE não programdos');
         If ( sST2[8] = '1' ) Then begin
            Retorno.Add('ST2 Bit 0 - Comando não executado');
            Result := True;
         End;
      End;

      If ( iACK = 21 ) Then begin
         Finaliza_Modo_TEF();

         MessageDlg('Atenção!!!' + #13 + #10 +
                    'A Impressora retornou NAK. O programa será abortado.',
                    mtInformation,[mbOk],0);
         Application.Terminate;
         Abort;
      End;

      If ( iACK = 6 ) And ( (iST1+iST2) <> 0 ) Then begin
         n := Retorno.Count-1;
         ListaRetorno := 'O ECF retornou as seguintes mensagens:';
         For i := 0 to n do begin
            ListaRetorno := ListaRetorno + Chr(13) + Retorno.Strings[i];
         End;

         //Salva a ultima msg
         UltimaMsgEcf := ListaRetorno;
         RetornouMsgEcf := True;

         //Verifica se é retorno de aviso de pouco papel
         If ( iSt1 = 64 ) And ( iSt2 = 0 ) Then begin
            If AvisoPoucoPapel Then begin
               SalvaModoTEF := ModoTEFLigado;
               Finaliza_Modo_TEF();
               mbFuncoes.EmptyKeyQueue();
               MessageDlg(ListaRetorno,mtInformation,[mbOk],0);
               If SalvaModoTEF Then begin
                  Inicia_Modo_TEF();
               End;
            End;
         End else begin
            If ( ShowMsgEcf ) Then begin
               SalvaModoTEF := ModoTEFLigado;
               Finaliza_Modo_TEF();
               mbFuncoes.EmptyKeyQueue();
               MessageDlg(ListaRetorno,mtInformation,[mbOk],0);
               If SalvaModoTEF Then begin
                  Inicia_Modo_TEF();
               End;
            End;
         End;
      End else begin
         RetornouMsgEcf := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Sweda.ECF_RetornoImpressora(iACK, iST1, iST2);

      If iACK = 6 then begin
         sST1 := mbFuncoes.IntToBin(iST1,8);
         If ( sST1[1] = '1' ) Then Retorno.Add('ST1 Bit 7 - Fim de Papel');
         If ( sST1[2] = '1' ) Then Retorno.Add('ST1 Bit 6 - Pouco Papel');
         If ( sST1[3] = '1' ) Then Retorno.Add('ST1 Bit 5 - Erro no Relógio');
         If ( sST1[4] = '1' ) Then Retorno.Add('ST1 Bit 4 - Impressora em Erro');
         If ( sST1[5] = '1' ) Then Retorno.Add('ST1 Bit 3 - CMD não iniciado com ESC');
         If ( sST1[6] = '1' ) Then Retorno.Add('ST1 Bit 2 - Comando Inexistente');
         If ( sST1[7] = '1' ) Then Retorno.Add('ST1 Bit 1 - Cupom Aberto');
         If ( sST1[8] = '1' ) Then Retorno.Add('ST1 Bit 0 - Número de paramêtros Invalidos');

         sST2 := mbFuncoes.IntToBin(iST2,8);
         If ( sST2[1] = '1' ) Then Retorno.Add('ST2 Bit 7 - Tipo de parametro inválido');
         If ( sST2[2] = '1' ) Then Retorno.Add('ST2 Bit 6 - Memória Fiscal lotada');
         If ( sST2[3] = '1' ) Then Retorno.Add('ST2 Bit 5 - CMOS não volátil');
         If ( sST2[4] = '1' ) Then Retorno.Add('ST2 Bit 4 - Aliquota não programada');
         If ( sST2[5] = '1' ) Then Retorno.Add('ST2 Bit 3 - Aliquotas lotadas');
         If ( sST2[6] = '1' ) Then Retorno.Add('ST2 Bit 2 - Cancelamento não permitido');
         If ( sST2[7] = '1' ) Then Retorno.Add('ST2 Bit 1 - CGC/IE não programdos');
         If ( sST2[8] = '1' ) Then begin
            Retorno.Add('ST2 Bit 0 - Comando não executado');
            Result := True;
         End;
      End;

      If ( iACK = 21 ) Then begin
         Finaliza_Modo_TEF();

         MessageDlg('Atenção!!!' + #13 + #10 +
                    'A Impressora retornou NAK. O programa será abortado.',
                    mtInformation,[mbOk],0);
         Application.Terminate;
         Abort;
      End;

      If ( iACK = 6 ) And ( (iST1+iST2) <> 0 ) Then begin
         n := Retorno.Count-1;
         ListaRetorno := 'O ECF retornou as seguintes mensagens:';
         For i := 0 to n do begin
            ListaRetorno := ListaRetorno + Chr(13) + Retorno.Strings[i];
         End;

         //Salva a ultima msg
         UltimaMsgEcf := ListaRetorno;
         RetornouMsgEcf := True;

         //Verifica se é retorno de aviso de pouco papel
         If ( iSt1 = 64 ) And ( iSt2 = 0 ) Then begin
            If AvisoPoucoPapel Then begin
               SalvaModoTEF := ModoTEFLigado;
               Finaliza_Modo_TEF();
               mbFuncoes.EmptyKeyQueue();
               MessageDlg(ListaRetorno,mtInformation,[mbOk],0);
               If SalvaModoTEF Then begin
                  Inicia_Modo_TEF();
               End;
            End;
         End else begin
            If ( ShowMsgEcf ) Then begin
               SalvaModoTEF := ModoTEFLigado;
               Finaliza_Modo_TEF();
               mbFuncoes.EmptyKeyQueue();
               MessageDlg(ListaRetorno,mtInformation,[mbOk],0);
               If SalvaModoTEF Then begin
                  Inicia_Modo_TEF();
               End;
            End;
         End;
      End else begin
         RetornouMsgEcf := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Daruma_FI_RetornoImpressora(iACK, iST1, iST2);

      If iACK = 6 then begin
         sST1 := mbFuncoes.IntToBin(iST1,8);
         If ( sST1[1] = '1' ) Then Retorno.Add('ST1 Bit 7 - Fim de Papel');
         If ( sST1[2] = '1' ) Then Retorno.Add('ST1 Bit 6 - Pouco Papel');
         If ( sST1[3] = '1' ) Then Retorno.Add('ST1 Bit 5 - Erro no Relógio');
         If ( sST1[4] = '1' ) Then Retorno.Add('ST1 Bit 4 - Impressora em Erro');
         If ( sST1[5] = '1' ) Then Retorno.Add('ST1 Bit 3 - CMD não iniciado com ESC');
         If ( sST1[6] = '1' ) Then Retorno.Add('ST1 Bit 2 - Comando Inexistente');
         If ( sST1[7] = '1' ) Then Retorno.Add('ST1 Bit 1 - Cupom Aberto');
         If ( sST1[8] = '1' ) Then Retorno.Add('ST1 Bit 0 - Número de paramêtros Invalidos');

         sST2 := mbFuncoes.IntToBin(iST2,8);
         If ( sST2[1] = '1' ) Then Retorno.Add('ST2 Bit 7 - Tipo de parametro inválido');
         If ( sST2[2] = '1' ) Then Retorno.Add('ST2 Bit 6 - Memória Fiscal lotada');
         If ( sST2[3] = '1' ) Then Retorno.Add('ST2 Bit 5 - CMOS não volátil');
         If ( sST2[4] = '1' ) Then Retorno.Add('ST2 Bit 4 - Aliquota não programada');
         If ( sST2[5] = '1' ) Then Retorno.Add('ST2 Bit 3 - Aliquotas lotadas');
         If ( sST2[6] = '1' ) Then Retorno.Add('ST2 Bit 2 - Cancelamento não permitido');
         If ( sST2[7] = '1' ) Then Retorno.Add('ST2 Bit 1 - CGC/IE não programdos');
         If ( sST2[8] = '1' ) Then begin
            Retorno.Add('ST2 Bit 0 - Comando não executado');
            Result := True;
         End;
      End;

      If ( iACK = 21 ) Then begin
         Finaliza_Modo_TEF();

         MessageDlg('Atenção!!!' + #13 + #10 +
                    'A Impressora retornou NAK. O programa será abortado.',
                    mtInformation,[mbOk],0);
         Application.Terminate;
         Abort;
      End;

      If ( iACK = 6 ) And ( (iST1+iST2) <> 0 ) Then begin
         n := Retorno.Count-1;
         ListaRetorno := 'O ECF retornou as seguintes mensagens:';
         For i := 0 to n do begin
            ListaRetorno := ListaRetorno + Chr(13) + Retorno.Strings[i];
         End;

         //Salva a ultima msg
         UltimaMsgEcf := ListaRetorno;
         RetornouMsgEcf := True;

         //Verifica se é retorno de aviso de pouco papel
         If ( iSt1 = 64 ) And ( iSt2 = 0 ) Then begin
            If AvisoPoucoPapel Then begin
               SalvaModoTEF := ModoTEFLigado;
               Finaliza_Modo_TEF();
               mbFuncoes.EmptyKeyQueue();
               MessageDlg(ListaRetorno,mtInformation,[mbOk],0);
               If SalvaModoTEF Then begin
                  Inicia_Modo_TEF();
               End;
            End;
         End else begin
            If ( ShowMsgEcf ) Then begin
               SalvaModoTEF := ModoTEFLigado;
               Finaliza_Modo_TEF();
               mbFuncoes.EmptyKeyQueue();
               MessageDlg(ListaRetorno,mtInformation,[mbOk],0);
               If SalvaModoTEF Then begin
                  Inicia_Modo_TEF();
               End;
            End;
         End;
      End else begin
         RetornouMsgEcf := False;
      End;
   End;
End;

/////////////////////////////////////////////////////////
//Função Utilizada para programar o Horário de Verão
//Parametros:
//
//Retorno:
//
//Autor: João Paulo Francisco Bellucci
/////////////////////////////////////////////////////////
Function Programa_Horario_Verao(Var Erro:String):Boolean;
/////////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_ProgramaHorarioVerao();
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_ProgramaHorarioVerao();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_ProgramaHorarioVerao();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

/////////////////////////////////////////////////////////////
//Função Utilizada para abertura do cupom fiscal
//Parametros:
//
//Retorno:
//
//Autor: João Paulo Francisco Bellucci
/////////////////////////////////////////////////////////////
Function Abre_Cupom(CNPJ_CPF:String;Var Erro:String):Boolean;
/////////////////////////////////////////////////////////////
Var Retorno:Integer; Flags:TFlagsFiscais;
    cArquivo:TextFile;
Begin
   Result := True;

   //Le as flags da ECF
   If Not FlagsFiscais(Flags,Erro) Then begin
      Result := False;
      Exit;
   End;

   //Verifica se possui cupom aberto se possuir cancela
   If Flags.CupomAberto Then begin
      If Cancela_Cupom_Fiscal(Erro) Then begin
         Result := False;
         Exit;
      End;
   End;

   If ( TipoECF = teBematech ) Then begin
      //Força o fechamento do comprovante não fiscal vinculado se tiver aberto
      Bematech_FI_FechaComprovanteNaoFiscalVinculado();

      Retorno := Bematech_FI_AbreCupom(CNPJ_CPF);
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      //Força o fechamento do comprovante não fiscal vinculado se tiver aberto
      Sweda.ECF_FechaComprovanteNaoFiscalVinculado();

      Retorno := Sweda.ECF_AbreCupom(CNPJ_CPF);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      //Força o fechamento do comprovante não fiscal vinculado se tiver aberto
      Daruma_FI_FechaComprovanteNaoFiscalVinculado();

      Retorno := Daruma_FI_AbreCupom(CNPJ_CPF);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;

   If ( Result ) And ( TEF.TEFAtivo ) And ( TEF.TipoTEF = ttSitef ) Then begin
      AssignFile( cArquivo, 'CUPOMABERTO.TXT' );
      ReWrite( cArquivo );
      WriteLn( cArquivo, 1 );
      CloseFile( cArquivo );
   End;
End;

//////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para venda de item
//Paramentros:
//
//Retorno:
//
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////////////
Function Vende_Item(Codigo,Descricao:String;Aliquota:Integer;Quantidade:Currency;
                    UnidadeMedida:String;ValorUnitario,ValorDesconto:Currency;
                    Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
    sAliquota,sQtde,sValorUnitario,sTipoDesconto:String;
    sDesconto:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      If ( Aliquota = -1 ) Then begin
         sAliquota := 'FF';
      End else If ( Aliquota = -2 ) Then begin
         sAliquota := 'II';
      End else If ( Aliquota = -3 ) Then begin
         sAliquota := 'NN';
      End else begin
         sAliquota := mbFuncoes.IntToStrZero(Aliquota,2);
      End;

      //Formata a Descrição
      Descricao := RemoveAcento(Copy(Descricao,1,50));

      sQtde := FormatFloat('###0.000',Quantidade);

      sValorUnitario := FormatFloat('##########0.000',ValorUnitario);

      //Configura o desconto
      sTipoDesconto := '$';
      sDesconto := FormatFloat('######0.00',ValorDesconto);

      Retorno := Bematech_FI_VendeItemDepartamento(PChar(Trim(Copy(Codigo,1,49))),  //Codigo
                                                   PChar(Descricao),                //Descricao
                                                   PChar(sAliquota),                //Aliquota
                                                   PChar(sValorUnitario),           //Valor Unitário
                                                   PChar(sQtde),                    //Qtde
                                                   '0',                             //Acrescimo
                                                   PChar(sDesconto),                //Desconto
                                                   '01',                            //Indice Departamento
                                                   PChar(Copy(UnidadeMedida,1,2))); //UnidadeMedida


      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      If ( Aliquota = -1 ) Then begin
         sAliquota := 'FF';
      End else If ( Aliquota = -2 ) Then begin
         sAliquota := 'II';
      End else If ( Aliquota = -3 ) Then begin
         sAliquota := 'NN';
      End else begin
         sAliquota := mbFuncoes.IntToStrZero(Aliquota,2);
      End;

      //Formata a Descrição
      Descricao := RemoveAcento(Copy(Descricao,1,50));

      sQtde := FormatFloat('###0.000',Quantidade);

      sValorUnitario := FormatFloat('##########0.000',ValorUnitario);

      //Configura o desconto
      sTipoDesconto := '$';
      sDesconto := FormatFloat('######0.00',ValorDesconto);

      Retorno := Sweda.ECF_VendeItemDepartamento(Trim(Copy(Codigo,1,49)),  //Codigo
                                                 Descricao,                //Descricao
                                                 sAliquota,                //Aliquota
                                                 sValorUnitario,           //Valor Unitário
                                                 sQtde,                    //Qtde
                                                 '0',                      //Acrescimo
                                                 sDesconto,                //Desconto
                                                 '01',                     //Indice Departamento
                                                 Copy(UnidadeMedida,1,2)); //UnidadeMedida


      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      If ( Aliquota = -1 ) Then begin
         sAliquota := 'FF';
      End else If ( Aliquota = -2 ) Then begin
         sAliquota := 'II';
      End else If ( Aliquota = -3 ) Then begin
         sAliquota := 'NN';
      End else begin
         sAliquota := mbFuncoes.IntToStrZero(Aliquota,2);
      End;

      //Formata a Descrição
      Descricao := RemoveAcento(Copy(Descricao,1,50));

      sQtde := FormatFloat('###0.000',Quantidade);

      sValorUnitario := FormatFloat('##########0.000',ValorUnitario);

      //Configura o desconto
      sTipoDesconto := '$';
      sDesconto := FormatFloat('######0.00',ValorDesconto);

      Retorno := Daruma_FI_VendeItemDepartamento(Trim(Copy(Codigo,1,49)),  //Codigo
                                                 Descricao,                //Descricao
                                                 sAliquota,                //Aliquota
                                                 sValorUnitario,           //Valor Unitário
                                                 sQtde,                    //Qtde
                                                 '0',                      //Acrescimo
                                                 sDesconto,                //Desconto
                                                 '01',                     //Indice Departamento
                                                 Copy(UnidadeMedida,1,2)); //UnidadeMedida


      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

////////////////////////////////////////////////////////////
//Função Utilizada para cancelar item
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////
Function Cancela_Item(Item:Integer;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////
Var Retorno:Integer;
    cItem:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      cItem := IntToStrZero(Item,3);
      Retorno := Bematech_FI_CancelaItemGenerico(PChar(cItem));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      cItem := IntToStrZero(Item,3);
      Retorno := Sweda.ECF_CancelaItemGenerico(cItem);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      cItem := IntToStrZero(Item,3);
      Retorno := Daruma_FI_CancelaItemGenerico(cItem);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

//////////////////////////////////////////////////////////////////////////////
//Função Utilizada para iniciar o fechamento do cupom fiscal
//Parametros:
// AcrescimoDesconto: Indica se haverá acréscimo ou desconto no cupom.
//                    'A' para acréscimo e 'D' para desconto.
// TipoAcrescimoDesconto: Indica se o acréscimo ou desconto é por valor ou por percentual.
//                       '$' para desconto por valor e '%' para percentual.
// Valor:  Valor do acrescimo ou desconto
//Retorno:
//
//Autor: João Paulo F. Bellucci
////////////////////////////////////////////////////////////////////////////////
Function Inicia_Fechamento_Cupom(AcrescimoDesconto,TipoAcrescimoDesconto:String;
                                 Valor:Currency;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; sValor:String;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      If ( TipoAcrescimoDesconto = '$' ) Then begin
         sValor := FormatFloat('##########0.00',Valor);
      End else If TipoAcrescimoDesconto = '%' Then begin
         sValor := FormatFloat('00.00',Valor);
         sValor := Copy(sValor,1,2) + Copy(sValor,3,2);
      End;

      Retorno := Bematech_FI_IniciaFechamentoCupom(PChar(AcrescimoDesconto),
                                                   PChar(TipoAcrescimoDesconto),
                                                   PChar(sValor));

      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      If ( TipoAcrescimoDesconto = '$' ) Then begin
         sValor := FormatFloat('##########0.00',Valor);
      End else If TipoAcrescimoDesconto = '%' Then begin
         sValor := FormatFloat('00.00',Valor);
         sValor := Copy(sValor,1,2) + Copy(sValor,3,2);
      End;

      Retorno :=  Sweda.ECF_IniciaFechamentoCupom(AcrescimoDesconto,
                                                  TipoAcrescimoDesconto,
                                                  sValor);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      If ( TipoAcrescimoDesconto = '$' ) Then begin
         sValor := FormatFloat('##########0.00',Valor);
      End else If TipoAcrescimoDesconto = '%' Then begin
         sValor := FormatFloat('00.00',Valor);
         sValor := Copy(sValor,1,2) + Copy(sValor,3,2);
      End;

      Retorno :=  Daruma_FI_IniciaFechamentoCupom(AcrescimoDesconto,
                                                  TipoAcrescimoDesconto,
                                                  sValor);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

//////////////////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para lançar as formas de pagamentos utilizadas
//Paramentros:
//
//Retorno:
//
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////////////////////////
Function Efetua_Forma_Pagamento(FormaPagamento:String;Valor:Currency;Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; sValor:String;
Begin
   Result := True;

   //Se o valor for zero não envia para ecf
   If ( Valor = 0 ) Then begin
      Exit;
   End;

   If ( TipoECF = teBematech ) Then begin
      sValor := FormatFloat('##########0.00',Valor);
      FormaPagamento := Copy(RemoveAcento(FormaPagamento),1,16);

      If ( ModeloECF = 'Matricial 98' ) Then begin
         Retorno := Bematech_FI_EfetuaFormaPagamentoImpAntiga(PChar(FormaPagamento),
                                                              PChar(sValor));
      End else begin
         Retorno := Bematech_FI_EfetuaFormaPagamento(PChar(FormaPagamento),
                                                     PChar(sValor));
      End;

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sValor := FormatFloat('##########0.00',Valor);
      FormaPagamento := Copy(RemoveAcento(FormaPagamento),1,16);

      Retorno := Sweda.ECF_EfetuaFormaPagamento(FormaPagamento,
                                                sValor);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sValor := FormatFloat('##########0.00',Valor);
      FormaPagamento := Copy(RemoveAcento(FormaPagamento),1,16);

      Retorno := Daruma_FI_EfetuaFormaPagamento(FormaPagamento,
                                                sValor);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

////////////////////////////////////////////////////////////////////////////
//Função Utilizada para terminar o fechamento do cupom fiscal
//Parametros:
//
//Retornos:
//
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////
Function Termina_Fechamento_Cupom(Mensagem:String; Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
    Flags:TFlagsFiscais;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      IF ( Mensagem = '' ) Then begin
         Mensagem := MsgPromocional;
      End;

      Retorno := Bematech_FI_TerminaFechamentoCupom(PChar(Mensagem));

      If Retorno_ECF() Then begin
         If FlagsFiscais(Flags,Erro) Then begin
            If Not Flags.FechamentoIniciado Then Exit;
         End;

         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      IF ( Mensagem = '' ) Then begin
         Mensagem := MsgPromocional;
      End;

      Retorno := Sweda.ECF_TerminaFechamentoCupom(Mensagem);

      If Retorno_ECF() Then begin
         If FlagsFiscais(Flags,Erro) Then begin
            If Not Flags.FechamentoIniciado Then Exit;
         End;

         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      IF ( Mensagem = '' ) Then begin
         Mensagem := MsgPromocional;
      End;

      Retorno := Daruma_FI_TerminaFechamentoCupom(Mensagem);

      If Retorno_ECF() Then begin
         If FlagsFiscais(Flags,Erro) Then begin
            If Not Flags.FechamentoIniciado Then Exit;
         End;

         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;

   If ( Result ) And ( TEF.TEFAtivo ) And ( TEF.TipoTEF = ttSitef ) Then begin
      //Apaga o arquivo que informa que possui um cupom aberto
      If ( FileExists( 'CUPOMABERTO.TXT' ) ) then DeleteFile( 'CUPOMABERTO.TXT' );
   End;
End;

/////////////////////////////////////////////////////////////////////////////
//Função utilizada para retornar o número do cupom fiscal
//Paramentros:
//
//Retorno:
//
//Autor: João Paulo Francisco Bellucci
/////////////////////////////////////////////////////////////////////////////
Function Numero_Cupom_Fiscal(Var NumeroCupom:String;Var Erro:String):Boolean;
/////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      NumeroCupom := mbFuncoes.Space(6);
      Retorno := Bematech_FI_NumeroCupom(NumeroCupom);

      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      NumeroCupom := mbFuncoes.Space(6);
      Retorno := Sweda.ECF_NumeroCupom(NumeroCupom);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      NumeroCupom := mbFuncoes.Space(6);
      Retorno := Daruma_FI_NumeroCupom(NumeroCupom);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////////
//Função utilizada para o cancelamento do ultimo cupom
//Paramentros:
//
//Retorno:
//
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////
Function Cancela_Cupom_Fiscal(Var Erro:String):Boolean;
///////////////////////////////////////////////////////
Var Retorno:Integer; FlagsECF:TFlagsFiscais;
Begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      If ( ModeloECF = 'Matricial 98' ) Then begin
         If Not FlagsFiscais(FlagsECF,Erro) Then begin
            Result := False;
         End;
         If FlagsECF.CupomAberto Then begin
            If FlagsECF.FechamentoIniciado Then begin
               If Not ECF.Termina_Fechamento_Cupom('',Erro) Then begin
                  Result := False;
                  Exit;
               End;
            End else begin
               If Not ECF.Inicia_Fechamento_Cupom('A','$',0,Erro) Then begin
                  Result := False;
                  Exit;
               End;
               If Not ECF.Termina_Fechamento_Cupom('',Erro) Then begin
                  Result := False;
                  Exit;
               End;
            End;

            //Verifica se permite cancelar o ultimo cupom
            If Not FlagsFiscais(FlagsECF,Erro) Then begin
               Result := False;
            End;
            If FlagsECF.PermiteCancelarCupom Then begin
               Retorno := Bematech_FI_CancelaCupom();
               If Retorno_ECF Then begin
                  Erro := 'Comando não executado!!!';
                  Result := False;
               End;
               If ( Retorno <= 0 ) Then begin
                  Erro := Bematech_Erros(Retorno);
                  Result := False;
               End;
            End;
         End;
      End else begin
         If Not FlagsFiscais(FlagsECF,Erro) Then begin
            Result := False;
            Exit;
         End;

         If FlagsECF.PermiteCancelarCupom Then begin
            Retorno := Bematech_FI_CancelaCupom();
            If Retorno_ECF Then begin
               Erro := 'Comando não executado!!!';
               Result := False;
            End;
            If ( Retorno <= 0 ) Then begin
               Erro := Bematech_Erros(Retorno);
               Result := False;
            End;
         End;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      If Not FlagsFiscais(FlagsECF,Erro) Then begin
         Result := False;
         Exit;
      End;

      If FlagsECF.PermiteCancelarCupom Then begin
         Retorno := Sweda.ECF_CancelaCupom();
         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
         End;
         If ( Retorno <= 0 ) Then begin
            Erro := Sweda.ECF_Erros(Retorno);
            Result := False;
         End;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      If Not FlagsFiscais(FlagsECF,Erro) Then begin
         Result := False;
         Exit;
      End;

      If FlagsECF.PermiteCancelarCupom Then begin
         Retorno := Daruma_FI_CancelaCupom();
         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
         End;
         If ( Retorno <= 0 ) Then begin
            Erro := Daruma_FI_Erros(Retorno);
            Result := False;
         End;
      End;
   End;

   If ( Result ) And ( TEF.TEFAtivo ) And ( TEF.TipoTEF = ttSitef ) Then begin
      //Apaga o arquivo que informa que possui um cupom aberto
      If ( FileExists( 'CUPOMABERTO.TXT' ) ) then DeleteFile( 'CUPOMABERTO.TXT' );
   End;

   If Result Then UltimoCupomCancelado := True;
End;

/////////////////////////////////////////////////////////////////////
//Função utilizada para imprimir comprovante não fiscal vinculado
//Parametros:
//
//Retorno:
//
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////
Function Imprime_Comprovante_Vinculado(DadosComprovante:TDadosComprovante;
                                       Var Texto:TStringList;
                                       Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////
Var Retorno,i,n,nLinhas:Integer;
    sValor,FormaPg,NumeroCupom,sDados,sTipo:String;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      //Formata os campos
      FormaPg     := Copy(RemoveAcento(DadosComprovante.FormaPg),1,16);
      sValor      := FormatFloat('##########0.00',DadosComprovante.Valor);
      sValor      := StringReplace(sValor,DecimalSeparator,'.',[]);
      NumeroCupom := Copy(DadosComprovante.NumeroCupom,1,6);

      If ( NumeroCupom = '' ) Then begin
         NumeroCupom := '000000';
      End;

      If ( ModeloECF = 'Termica' ) Then begin
         Retorno := Bematech_FI_AbreComprovanteNaoFiscalVinculadoMFD(
                    PChar(FormaPg),
                    PChar(sValor),
                    PChar(NumeroCupom),
                    PChar(Copy(DadosComprovante.CGC,1,29)),
                    PChar(Copy(DadosComprovante.Nome,1,30)),
                    PChar(Copy(DadosComprovante.Endereco,1,80)) );
      End else begin
         Retorno := Bematech_FI_AbreComprovanteNaoFiscalVinculado(PChar(FormaPg),
                                                                  PChar(sValor),
                                                                  PChar(NumeroCupom) );
      End;
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;
      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
         Exit
      End;

      //Imprime o texto do comprovante vinculado
      n := Texto.Count-1;
      For i := 0 to n do begin
         If ( Texto.Strings[i] = '***Funcao_Aciona_Guilhotina***' ) Then begin
            //Aciona a guilhotina
            ECF.Aciona_Guilhotina(Erro);
         End else begin
            Retorno := Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto.Strings[i]+FL_ECF);
            If Retorno_ECF Then begin
               Erro := 'Comando não executado!!!';
               Result := False;
               Exit;
            End;
            If ( Retorno <= 0 ) Then begin
               Erro := Bematech_Erros(Retorno);
               Result := False;
               Exit
            End;
         End;
      End;

      //Fecha o comprovante não fiscal vinculado
      Retorno := Bematech_FI_FechaComprovanteNaoFiscalVinculado();
      If Retorno_ECF Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;
      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
         Exit
      End;
   End else If ( TipoECF = teSweda ) Then begin
      //Formata os campos
      FormaPg     := Copy(RemoveAcento(DadosComprovante.FormaPg),1,16);
      sValor      := FormatFloat('##########0.00',DadosComprovante.Valor);
      sValor      := StringReplace(sValor,DecimalSeparator,'.',[]);
      NumeroCupom := Copy(DadosComprovante.NumeroCupom,1,6);

      If ( NumeroCupom = '' ) Then begin
         NumeroCupom := '000000';
      End;

      //Se o relatório gerencial estiver aberto fecha
      sTipo := #0; SetLength(sTipo,1);
      Sweda.ECF_StatusRelatorioGerencial(sTipo);
      If ( sTipo = '1' ) Then begin
         Sweda.ECF_FechaRelatorioGerencial();
      End;

      Retorno := Sweda.ECF_AbreComprovanteNaoFiscalVinculadoMFD(PChar(FormaPg),
                                                                PChar(sValor),
                                                                PChar(NumeroCupom),
                                                                PChar(Copy(DadosComprovante.CGC,1,29)),
                                                                PChar(Copy(DadosComprovante.Nome,1,30)),
                                                                PChar(Copy(DadosComprovante.Endereco,1,80)) );

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
         Exit
      End;

      //Imprime o texto do comprovante vinculado
      nLinhas := 0;
      sDados := '';
      n := Texto.Count-1;
      For i := 0 to n do begin
         Inc(nLinhas);
         If ( Texto.Strings[i] = '***Funcao_Aciona_Guilhotina***' ) Then begin
            If ( sDados <> '' ) Then begin
               Retorno := Sweda.ECF_UsaComprovanteNaoFiscalVinculado(PChar(sDados));
               If Retorno_ECF() Then begin
                  Erro := 'Comando não executado!!!';
                  Result := False;
                  Exit;
               End;
               If ( Retorno <= 0 ) Then begin
                  Erro := Sweda.ECF_Erros(Retorno);
                  Result := False;
                  Exit
               End;
            End;

            //Aciona a guilhotina
            ECF.Aciona_Guilhotina(Erro);

            nLinhas := 0;
            sDados  := '';
         End else begin
            sDados := sDados + Texto.Strings[i]+FL_ECF;

            //Se atingiu o numero de linhas manda para a impressora
            If ( nLinhas = NumeroLinhasNaoFiscal ) Or ( i = n ) Then begin
               Retorno := Sweda.ECF_UsaComprovanteNaoFiscalVinculado(PChar(sDados));
               If Retorno_ECF() Then begin
                  Erro := 'Comando não executado!!!';
                  Result := False;
                  Exit;
               End;
               If ( Retorno <= 0 ) Then begin
                  Erro := Sweda.ECF_Erros(Retorno);
                  Result := False;
                  Exit
               End;

               nLinhas := 0;
               sDados  := '';
            End;
         End;
      End;

      //Fecha o comprovante não fiscal vinculado
      Retorno := Sweda.ECF_FechaComprovanteNaoFiscalVinculado();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;
      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
         Exit
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      //Formata os campos
      FormaPg     := Copy(RemoveAcento(DadosComprovante.FormaPg),1,16);
      sValor      := FormatFloat('##########0.00',DadosComprovante.Valor);
      sValor      := StringReplace(sValor,DecimalSeparator,'.',[]);
      NumeroCupom := Copy(DadosComprovante.NumeroCupom,1,6);

      If ( NumeroCupom = '' ) Then begin
         NumeroCupom := '000000';
      End;

      //Força o fechamento do comprovante não fiscal vinculado se tiver aberto
      Daruma_FI_FechaComprovanteNaoFiscalVinculado();

      Retorno := Daruma_FI_AbreComprovanteNaoFiscalVinculado(PChar(FormaPg),
                                                             PChar(sValor),
                                                             PChar(NumeroCupom));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
         Exit
      End;

      //Imprime o texto do comprovante vinculado
      n := Texto.Count-1;
      For i := 0 to n do begin
         If ( Texto.Strings[i] = '***Funcao_Aciona_Guilhotina***' ) Then begin
            //Aciona a guilhotina
            ECF.Aciona_Guilhotina(Erro);
         End else begin
            Retorno := Daruma_FI_UsaComprovanteNaoFiscalVinculado(PChar(Texto.Strings[i]+FL_ECF));
            If Retorno_ECF() Then begin
               Erro := 'Comando não executado!!!';
               Result := False;
               Exit;
            End;
            If ( Retorno <= 0 ) Then begin
               Erro := Daruma_FI_Erros(Retorno);
               Result := False;
               Exit
            End;
         End;
      End;

      //Fecha o comprovante não fiscal vinculado
      Retorno := Daruma_FI_FechaComprovanteNaoFiscalVinculado();
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;
      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
         Exit
      End;
   End;
End;

/////////////////////////////////////////////////////////////
Function Sangria_ECF(Valor:Currency;Var Erro:String):Boolean;
/////////////////////////////////////////////////////////////
Var Retorno:Integer; sValor:String;
begin
   sValor := '';
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      sValor := FormatFloat('###,###,##0.00',Valor);
      Retorno := Bematech.Bematech_FI_Sangria(PChar(sValor));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sValor := FormatFloat('###,###,##0.00',Valor);
      Retorno := Sweda.ECF_Sangria(sValor);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sValor := FormatFloat('###,###,##0.00',Valor);
      Retorno := Daruma_FI_Sangria(sValor);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

////////////////////////////////////////////////////////////////////////////
//Função utilizada para imprimir suprimento na ECF
//Parametros:
//            Valor - Valor do Suprimento
//            Tipo - Tipo do suprimento (Dinheiro, cheque...)
//            Erro - Retorna a mensagem de erro se o retorno da função for false
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////
Function Suprimento_ECF(Valor:Currency;Tipo:String;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer; sValor:String;
begin
   sValor := '';
   Result := True;

   //Se o valor do suprimento for zero retorna verdadeiro
   If ( Valor = 0 ) Then begin
      Exit;
   End;

   If ( TipoECF = teBematech ) And ( ModeloECF <> 'Matricial 98' ) Then begin
      sValor := FormatFloat('###,###,##0.00',Valor);
      Retorno := Bematech.Bematech_FI_Suprimento(PChar(sValor),PChar(Tipo));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sValor := FormatFloat('###,###,##0.00',Valor);
      Retorno := Sweda.ECF_Suprimento(sValor,Tipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sValor := FormatFloat('###,###,##0.00',Valor);
      Retorno := Daruma_FI_Suprimento(sValor,Tipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////////////////////
//Função Utilizada para abrir a gaveta que esta conectada na ECF
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////
Function Abrir_Gaveta_ECF(Var Erro:String):Boolean;
///////////////////////////////////////////////////
Var Retorno:Integer;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_AcionaGaveta();

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_AcionaGaveta();

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_AcionaGaveta();

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
End;

///////////////////////////////////
//Função utilizada para retornar o número de série
// do ecf registrado no computador
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////
Function Retorna_Sn_Ecf_Txt:String;
///////////////////////////////////
Var NomeArquivo, Dir, Dados:String;
    Arquivo:TextFile;

begin
   //Pega o diretório corrente
   GetDir(0,Dir);

   //Monta o nome do arquivo
   NomeArquivo := Dir + '\sn_ecf.txt';

   Result := '';
   If Not FileExists(NomeArquivo) Then begin
      Exit;
   End;

   //Abre o arquivo
   AssignFile(Arquivo,NomeArquivo);
   Reset(Arquivo);

   //Le os dados
   ReadLn(Arquivo, Dados);

   Dados := mbFuncoes.Criptografia(Dados,
                                 'DPNQMFZVTK',
                                 2,False);

   Result := Trim(Dados);

   //Fecha o arquivo texto
   CloseFile(Arquivo);
end;

////////////////////////////////////////////////////
//Função utilizada para acionar a guilhotina de corte de papel da ECF
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////
Function Aciona_Guilhotina(Var Erro:String):Boolean;
////////////////////////////////////////////////////
Var Retorno,TipoImpressora:Integer;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      // Função que verifica o tipo da impressora fiscal.
      // Se for a impressora com cutter, é acionado o corte do papel (guilhotina).
      TipoImpressora := 0;
      Retorno := Bematech_FI_VerificaTipoImpressora( TipoImpressora );

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;

      //Se houve erro sai da rotina
      If Not Result Then Exit;

      //Verifica se o tipode impressora conectada possui Guilhotina
      If ( ( TipoImpressora = 2 ) or
           ( TipoImpressora = 4 ) or
           ( TipoImpressora = 6 ) or
           ( TipoImpressora = 8 ) ) then begin

         Retorno := Bematech_FI_AcionaGuilhotinaMFD( 0 );

         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Bematech_Erros(Retorno);
            Result := False;
         End;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      // Função que verifica o tipo da impressora fiscal.
      // Se for a impressora com cutter, é acionado o corte do papel (guilhotina).
      //TipoImpressora := 0;
      //Retorno := Sweda.ECF_VerificaTipoImpressora(TipoImpressora);

      //If Retorno_ECF() Then begin
      //   Erro := 'Comando não executado!!!';
      //   Result := False;
      //End;

      //If ( Retorno <= 0 ) Then begin
      //   Erro := Sweda.ECF_Erros(Retorno);
      //   Result := False;
      //End;

      //Se houve erro sai da rotina
      //If Not Result Then Exit;
   End else If ( TipoECF = teDaruma ) Then begin
      // Função que verifica o tipo da impressora fiscal.
      // Se for a impressora com cutter, é acionado o corte do papel (guilhotina).
      TipoImpressora := 0;
      Retorno := Daruma_FI_VerificaTipoImpressora( TipoImpressora );

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;

      //Se houve erro sai da rotina
      If Not Result Then Exit;

      //Verifica se o tipode impressora conectada possui Guilhotina
      If ( ( TipoImpressora = 2 ) or
           ( TipoImpressora = 4 ) or
           ( TipoImpressora = 6 ) or
           ( TipoImpressora = 8 ) ) then begin

         Retorno := Daruma_FI_AcionaGuilhotinaMFD( 0 );

         If Retorno_ECF() Then begin
            Erro := 'Comando não executado!!!';
            Result := False;
         End;

         If ( Retorno <= 0 ) Then begin
            Erro := Daruma_FI_Erros(Retorno);
            Result := False;
         End;
      End;
   End;
end;

//////////////////////////
procedure Inicia_Modo_TEF;
//////////////////////////
begin
   ShowMsgEcf := False;
   Bematech_FI_IniciaModoTEF();
   ModoTEFLigado := True;
end;

////////////////////////////
procedure Finaliza_Modo_TEF;
////////////////////////////
begin
   ShowMsgEcf := True;
   Bematech_FI_FinalizaModoTEF();
   Application.ProcessMessages;
   ModoTEFLigado := False;
end;

////////////////////////////////////////////////////////////
//Função Utilizada para gerar o arquivo da CAT52
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////
Function Gera_CAT52(Data:TDateTime;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////
Var sData, sArquivo:String;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      sData := FormatDateTime('dd/mm/yyyy',Data);
      sArquivo := '';

      //sData := '';
      //sArquivo := 'C:\CAT52\BE650749.SB7.rfd';

      If Bematech_FI_GeraRegistrosCAT52MFD(sArquivo,sData) = 0 Then begin
         Erro := 'Erro ao criar CAT52 impressora Bematech.';
         Result := False;
      End;
   End;
end;

/////////////////////////////
//Função utilizada para retornar a versão da Dll
//Autor: João Paulo Francisco Bellucci
///////////////////////////////
Function Versao_Dll_ECF:String;
///////////////////////////////
Var cVersao:String;
begin
   Result := '';
   If ( TipoECF = teBematech ) Then begin
      cVersao := mbFuncoes.Space(10);

      If Bematech_FI_VersaoDll(cVersao) <> 0 Then begin
         Result := cVersao;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      cVersao := mbFuncoes.Space(10);

      If Sweda.ECF_VersaoDll(cVersao) <> 0 Then begin
         Result := cVersao;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      cVersao := mbFuncoes.Space(10);

      If Daruma_FI_VersaoDll(cVersao) <> 0 Then begin
         Result := cVersao;
      End;
   End;
end;

////////////////////////////////////////////////////////////////////////////////
//Função utilizada para configurar linhas entre os cupons
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////////
Function Configura_Linhas_Entre_Cupons(iLinhas:Integer;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_LinhasEntreCupons(iLinhas);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End;
end;

//////////////////////////////////////////////////////////////////////////////
//Função utilizada para configurar espaço entre linhas
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////////
Function Configura_Espaco_Entre_Linhas(iDots:Integer;Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_EspacoEntreLinhas(iDots);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End;
end;

////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para verificar as formas de pagamento cadastras na Impressora
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////////
Function Verifica_Formas_Pagamento(FormaPg:TStringList;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
    sFormaPg,sAux:String;
begin
   If ( FormaPg = Nil ) Then begin
      FormaPg := TStringList.Create;
   End;

   Result := True;

   If ( TipoECF = teBematech ) Then begin
      sFormaPg := Space(3016);
      Retorno := Bematech_FI_VerificaFormasPagamento(sFormaPg);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;

      sFormaPg := Trim(sFormaPg);
      While ( sFormaPg <> '' ) do begin
         sAux := Trim(Copy(sFormaPg,1,16));

         //Adiciona a forma de pagamento na lista
         If ( sAux <> '' ) Then begin
            FormaPg.Add(sAux);
         End;

         sFormaPg := Copy(sFormaPg,59,Length(sFormaPg));
      End;
   End else If ( TipoECF = teSweda ) Then begin
      sFormaPg := Space(275);
      Retorno := Sweda.ECF_VerificaDescricaoFormasPagamento(PChar(sFormaPg));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;

      sFormaPg := Trim(sFormaPg);
      While ( sFormaPg <> '' ) do begin
         sAux := Trim(Copy(sFormaPg,1,16));

         //Adiciona a forma de pagamento na lista
         If ( sAux <> '' ) Then begin
            FormaPg.Add(sAux);
         End;

         sFormaPg := Copy(sFormaPg,18,Length(sFormaPg));
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sFormaPg := Space(275);
      Retorno := Daruma_FI_VerificaDescricaoFormasPagamento(PChar(sFormaPg));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;

      sFormaPg := Trim(sFormaPg);
      While ( sFormaPg <> '' ) do begin
         sAux := Trim(Copy(sFormaPg,1,16));

         //Adiciona a forma de pagamento na lista
         If ( sAux <> '' ) Then begin
            FormaPg.Add(sAux);
         End;

         sFormaPg := Copy(sFormaPg,18,Length(sFormaPg));
      End;
   End;
end;

////////////////////////////////////////////////////////////////////////////////////////////
//Função utilizada para programa forma de pagamento na ECF
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////////////////////
Function Programa_Forma_Pagamento(FormaPg:String;Vinculado:Boolean;Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
    sVincula:String;
begin

   If Vinculado Then begin
      sVincula := '1';
   End else begin
      sVincula := '0';
   End;

   //Remove os acentos
   FormaPg := RemoveAcento(FormaPg);

   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_ProgramaFormaPagamentoMFD(FormaPg,sVincula);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_ProgramaFormaPagamentoMFD(PChar(FormaPg),PChar(sVincula));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_ProgramaFormasPagamento(PChar(FormaPg));

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
end;

///////////////////////////////////////////////////////////////////////////
//Função utilizada para verificar se tem redução Z pendente na impressora
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////////
Function Verifica_Z_Pendente(Var Pendente:Boolean;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
    sZPend:String;
    DataMovimento, DataECF:TDateTime;
begin
   Pendente := False;
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      If Not Data_Ultimo_Movimento(DataMovimento,Erro) Then begin
         Result := False;
         Exit;
      End;

      If Not DataHora_ECF(DataECF,Erro) Then begin
         Result := False;
         Exit;
      End;

      //Data Zerada , significa Z emitida
      If ( DataMovimento = 0 ) Then begin
         Exit;
      End;

      //Data do movimento diferente que a data da ecf significa Z pendente
      If ( DataMovimento <> Int(DataECF) ) Then begin
         Pendente := True;
      End;

   End else If ( TipoECF = teSweda ) Then begin
      sZPend := Space(2);
      Retorno := Sweda.ECF_VerificaZPendente(sZPend);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;

      If Result Then begin
         If ( sZPend[1] = '1' ) Then Pendente := True;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      sZPend := Space(2);
      Retorno := Daruma_FI_VerificaZPendente(sZPend);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;

      If Result Then begin
         If ( sZPend[1] = '1' ) Then Pendente := True;
      End;
   End;
end;

//////////////////////////////////////////////////////////////////////////////
//Função utilizada para pegar os dados da ultima redução Z da ecf
//Retorno:
//        Se retorno = True funcão executada com sucesso
//           retorno = False ocorreu falha na execução a mensagem do erro
//                     será retornada no parametro Erro
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////////
Function Pega_Dados_Ultima_Reducao(Var DadosUltimaReducao:TDadosUltimaReducao;
                                   Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
    Dados,sModoReducao,sGrandeTotal,sCancelamentos,sDescontos,sTributos,
    sSangrias,sSuprimentos,sCOO,sDataMov:String;
    sValorAliquota:Array[1..19] of String;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Dados := Space(631);

      Retorno := Bematech_FI_DadosUltimaReducao(Dados);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;

      //Formatação da string
      //00, - Modo Reducao - 0-3
      //000000000000000000, - Grande Total - 4-22
      //00000000000000, - Cancelamentos - 23-37
      //00000000000000, - Descontos - 38-52
      //00...000000000, - Tributos - 53-117
      //00...000000000, - Valores registrado nas Aliquotas - 118-384
      //00000000000000, - Sangrias - 385-399
      //00000000000000, - Suprimentos - 400-414
      //00...000000000, - Totalizadores não sujeitos ao ICMS - 415-541
      //00...000000000, - Contadores dos TP's não sujeitos ao ICMS - 542-578
      //000000, - COO - 579-585
      //000000, - Contador de operações não sujeitas ao ICMS - 586-592
      //00, - Número de Alíquotas cadastradas - 593-595
      //000000, - Data do movimento - 596-602
      //00000000000000, - Acréscimos - 603-617
      //00000000000000 - Acréscimo financeiro - 618-631

      sModoReducao := Copy(Dados,1,2);
      sGrandeTotal := Copy(Dados,4,18);
      sCancelamentos := Copy(Dados,23,14);
      sDescontos := Copy(Dados,38,14);
      sTributos := Copy(Dados,53,64);
      sValorAliquota[1] := Copy(Dados,118,14);
      sValorAliquota[2] := Copy(Dados,132,14);
      sValorAliquota[3] := Copy(Dados,146,14);
      sValorAliquota[4] := Copy(Dados,160,14);
      sValorAliquota[5] := Copy(Dados,174,14);
      sValorAliquota[6] := Copy(Dados,188,14);
      sValorAliquota[7] := Copy(Dados,202,14);
      sValorAliquota[8] := Copy(Dados,216,14);
      sValorAliquota[9] := Copy(Dados,230,14);
      sValorAliquota[10] := Copy(Dados,244,14);
      sValorAliquota[11] := Copy(Dados,258,14);
      sValorAliquota[12] := Copy(Dados,272,14);
      sValorAliquota[13] := Copy(Dados,286,14);
      sValorAliquota[14] := Copy(Dados,300,14);
      sValorAliquota[15] := Copy(Dados,314,14);
      sValorAliquota[16] := Copy(Dados,328,14);
      sValorAliquota[17] := Copy(Dados,342,14);
      sValorAliquota[18] := Copy(Dados,356,14);
      sValorAliquota[19] := Copy(Dados,370,14);
      sSangrias := Copy(Dados,385,14);
      sSuprimentos := Copy(Dados,400,14);
      sCOO := Copy(Dados,579,6);
      sDataMov := Copy(Dados,596,6);

      DadosUltimaReducao.ModoReducao := sModoReducao;
      DadosUltimaReducao.GrandeTotal := StrToCurrDef(Copy(sGrandeTotal,1,16)+DecimalSeparator+Copy(sGrandeTotal,17,2),0);
      DadosUltimaReducao.Cancelamentos := StrToCurrDef(Copy(sCancelamentos,1,12)+DecimalSeparator+Copy(sCancelamentos,13,2),0);
      DadosUltimaReducao.Descontos := StrToCurrDef(Copy(sDescontos,1,12)+DecimalSeparator+Copy(sDescontos,13,2),0);
      DadosUltimaReducao.Tributos[1].Aliquota := StrToCurrDef(Copy(sTributos,1,2)+DecimalSeparator+Copy(sTributos,3,2),0);
      DadosUltimaReducao.Tributos[1].ValorTributado := StrToCurrDef(Copy(sValorAliquota[1],1,12)+DecimalSeparator+Copy(sValorAliquota[1],13,2),0);
      DadosUltimaReducao.Tributos[2].Aliquota := StrToCurrDef(Copy(sTributos,5,2)+DecimalSeparator+Copy(sTributos,7,2),0);
      DadosUltimaReducao.Tributos[2].ValorTributado := StrToCurrDef(Copy(sValorAliquota[2],1,12)+DecimalSeparator+Copy(sValorAliquota[2],13,2),0);
      DadosUltimaReducao.Tributos[3].Aliquota := StrToCurrDef(Copy(sTributos,9,2)+DecimalSeparator+Copy(sTributos,11,2),0);
      DadosUltimaReducao.Tributos[3].ValorTributado := StrToCurrDef(Copy(sValorAliquota[3],1,12)+DecimalSeparator+Copy(sValorAliquota[3],13,2),0);
      DadosUltimaReducao.Tributos[4].Aliquota := StrToCurrDef(Copy(sTributos,13,2)+DecimalSeparator+Copy(sTributos,15,2),0);
      DadosUltimaReducao.Tributos[4].ValorTributado := StrToCurrDef(Copy(sValorAliquota[4],1,12)+DecimalSeparator+Copy(sValorAliquota[4],13,2),0);
      DadosUltimaReducao.Tributos[5].Aliquota := StrToCurrDef(Copy(sTributos,17,2)+DecimalSeparator+Copy(sTributos,19,2),0);
      DadosUltimaReducao.Tributos[5].ValorTributado := StrToCurrDef(Copy(sValorAliquota[5],1,12)+DecimalSeparator+Copy(sValorAliquota[5],13,2),0);
      DadosUltimaReducao.Tributos[6].Aliquota := StrToCurrDef(Copy(sTributos,21,2)+DecimalSeparator+Copy(sTributos,23,2),0);
      DadosUltimaReducao.Tributos[6].ValorTributado := StrToCurrDef(Copy(sValorAliquota[6],1,12)+DecimalSeparator+Copy(sValorAliquota[6],13,2),0);
      DadosUltimaReducao.Tributos[7].Aliquota := StrToCurrDef(Copy(sTributos,25,2)+DecimalSeparator+Copy(sTributos,27,2),0);
      DadosUltimaReducao.Tributos[7].ValorTributado := StrToCurrDef(Copy(sValorAliquota[7],1,12)+DecimalSeparator+Copy(sValorAliquota[7],13,2),0);
      DadosUltimaReducao.Tributos[8].Aliquota := StrToCurrDef(Copy(sTributos,29,2)+DecimalSeparator+Copy(sTributos,31,2),0);
      DadosUltimaReducao.Tributos[8].ValorTributado := StrToCurrDef(Copy(sValorAliquota[8],1,12)+DecimalSeparator+Copy(sValorAliquota[8],13,2),0);
      DadosUltimaReducao.Tributos[9].Aliquota := StrToCurrDef(Copy(sTributos,33,2)+DecimalSeparator+Copy(sTributos,35,2),0);
      DadosUltimaReducao.Tributos[9].ValorTributado := StrToCurrDef(Copy(sValorAliquota[9],1,12)+DecimalSeparator+Copy(sValorAliquota[9],13,2),0);
      DadosUltimaReducao.Tributos[10].Aliquota := StrToCurrDef(Copy(sTributos,37,2)+DecimalSeparator+Copy(sTributos,39,2),0);
      DadosUltimaReducao.Tributos[10].ValorTributado := StrToCurrDef(Copy(sValorAliquota[10],1,12)+DecimalSeparator+Copy(sValorAliquota[10],13,2),0);
      DadosUltimaReducao.Tributos[11].Aliquota := StrToCurrDef(Copy(sTributos,41,2)+DecimalSeparator+Copy(sTributos,43,2),0);
      DadosUltimaReducao.Tributos[11].ValorTributado := StrToCurrDef(Copy(sValorAliquota[11],1,12)+DecimalSeparator+Copy(sValorAliquota[11],13,2),0);
      DadosUltimaReducao.Tributos[12].Aliquota := StrToCurrDef(Copy(sTributos,45,2)+DecimalSeparator+Copy(sTributos,47,2),0);
      DadosUltimaReducao.Tributos[12].ValorTributado := StrToCurrDef(Copy(sValorAliquota[12],1,12)+DecimalSeparator+Copy(sValorAliquota[12],13,2),0);
      DadosUltimaReducao.Tributos[13].Aliquota := StrToCurrDef(Copy(sTributos,49,2)+DecimalSeparator+Copy(sTributos,51,2),0);
      DadosUltimaReducao.Tributos[13].ValorTributado := StrToCurrDef(Copy(sValorAliquota[13],1,12)+DecimalSeparator+Copy(sValorAliquota[13],13,2),0);
      DadosUltimaReducao.Tributos[14].Aliquota := StrToCurrDef(Copy(sTributos,53,2)+DecimalSeparator+Copy(sTributos,55,2),0);
      DadosUltimaReducao.Tributos[14].ValorTributado := StrToCurrDef(Copy(sValorAliquota[14],1,12)+DecimalSeparator+Copy(sValorAliquota[14],13,2),0);
      DadosUltimaReducao.Tributos[15].Aliquota := StrToCurrDef(Copy(sTributos,57,2)+DecimalSeparator+Copy(sTributos,59,2),0);
      DadosUltimaReducao.Tributos[15].ValorTributado := StrToCurrDef(Copy(sValorAliquota[15],1,12)+DecimalSeparator+Copy(sValorAliquota[15],13,2),0);
      DadosUltimaReducao.Tributos[16].Aliquota := StrToCurrDef(Copy(sTributos,61,2)+DecimalSeparator+Copy(sTributos,63,2),0);
      DadosUltimaReducao.Tributos[16].ValorTributado := StrToCurrDef(Copy(sValorAliquota[16],1,12)+DecimalSeparator+Copy(sValorAliquota[16],13,2),0);
      DadosUltimaReducao.Isencao := StrToCurrDef(Copy(sValorAliquota[17],1,12)+DecimalSeparator+Copy(sValorAliquota[17],13,2),0);
      DadosUltimaReducao.NaoIncidencia := StrToCurrDef(Copy(sValorAliquota[18],1,12)+DecimalSeparator+Copy(sValorAliquota[18],13,2),0);
      DadosUltimaReducao.SubstTributaria := StrToCurrDef(Copy(sValorAliquota[19],1,12)+DecimalSeparator+Copy(sValorAliquota[19],13,2),0);
      DadosUltimaReducao.Sangrias := StrToCurrDef(Copy(sSangrias,1,12)+DecimalSeparator+Copy(sSangrias,13,2),0);
      DadosUltimaReducao.Suprimentos := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      DadosUltimaReducao.COO := sCOO;
      DadosUltimaReducao.DataMovimento := StrToDate(Copy(sDataMov,1,2) + '/' +
                                                    Copy(sDataMov,3,2) + '/' +
                                                    Copy(sDataMov,5,2));
   End else If ( TipoECF = teSweda ) Then begin
      Dados := Space(631);

      Retorno := ECF_DadosUltimaReducao(Dados);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;

      //Formatação da string
      //00, - Modo Reducao - 0-3
      //000000000000000000, - Grande Total - 4-22
      //00000000000000, - Cancelamentos - 23-37
      //00000000000000, - Descontos - 38-52
      //00...000000000, - Tributos - 53-117
      //00...000000000, - Valores registrado nas Aliquotas - 118-384
      //00000000000000, - Sangrias - 385-399
      //00000000000000, - Suprimentos - 400-414
      //00...000000000, - Totalizadores não sujeitos ao ICMS - 415-541
      //00...000000000, - Contadores dos TP's não sujeitos ao ICMS - 542-578
      //000000, - COO - 579-585
      //000000, - Contador de operações não sujeitas ao ICMS - 586-592
      //00, - Número de Alíquotas cadastradas - 593-595
      //000000, - Data do movimento - 596-602
      //00000000000000, - Acréscimos - 603-617
      //00000000000000 - Acréscimo financeiro - 618-631

      sModoReducao := Copy(Dados,1,2);
      sGrandeTotal := Copy(Dados,4,18);
      sCancelamentos := Copy(Dados,23,14);
      sDescontos := Copy(Dados,38,14);
      sTributos := Copy(Dados,53,64);
      sValorAliquota[1] := Copy(Dados,118,14);
      sValorAliquota[2] := Copy(Dados,132,14);
      sValorAliquota[3] := Copy(Dados,146,14);
      sValorAliquota[4] := Copy(Dados,160,14);
      sValorAliquota[5] := Copy(Dados,174,14);
      sValorAliquota[6] := Copy(Dados,188,14);
      sValorAliquota[7] := Copy(Dados,202,14);
      sValorAliquota[8] := Copy(Dados,216,14);
      sValorAliquota[9] := Copy(Dados,230,14);
      sValorAliquota[10] := Copy(Dados,244,14);
      sValorAliquota[11] := Copy(Dados,258,14);
      sValorAliquota[12] := Copy(Dados,272,14);
      sValorAliquota[13] := Copy(Dados,286,14);
      sValorAliquota[14] := Copy(Dados,300,14);
      sValorAliquota[15] := Copy(Dados,314,14);
      sValorAliquota[16] := Copy(Dados,328,14);
      sValorAliquota[17] := Copy(Dados,342,14);
      sValorAliquota[18] := Copy(Dados,356,14);
      sValorAliquota[19] := Copy(Dados,370,14);
      sSangrias := Copy(Dados,385,14);
      sSuprimentos := Copy(Dados,400,14);
      sCOO := Copy(Dados,579,6);
      sDataMov := Copy(Dados,596,6);

      DadosUltimaReducao.ModoReducao := sModoReducao;
      DadosUltimaReducao.GrandeTotal := StrToCurrDef(Copy(sGrandeTotal,1,16)+DecimalSeparator+Copy(sGrandeTotal,17,2),0);
      DadosUltimaReducao.Cancelamentos := StrToCurrDef(Copy(sCancelamentos,1,12)+DecimalSeparator+Copy(sCancelamentos,13,2),0);
      DadosUltimaReducao.Descontos := StrToCurrDef(Copy(sDescontos,1,12)+DecimalSeparator+Copy(sDescontos,13,2),0);
      DadosUltimaReducao.Tributos[1].Aliquota := StrToCurrDef(Copy(sTributos,1,2)+DecimalSeparator+Copy(sTributos,3,2),0);
      DadosUltimaReducao.Tributos[1].ValorTributado := StrToCurrDef(Copy(sValorAliquota[1],1,12)+DecimalSeparator+Copy(sValorAliquota[1],13,2),0);
      DadosUltimaReducao.Tributos[2].Aliquota := StrToCurrDef(Copy(sTributos,5,2)+DecimalSeparator+Copy(sTributos,7,2),0);
      DadosUltimaReducao.Tributos[2].ValorTributado := StrToCurrDef(Copy(sValorAliquota[2],1,12)+DecimalSeparator+Copy(sValorAliquota[2],13,2),0);
      DadosUltimaReducao.Tributos[3].Aliquota := StrToCurrDef(Copy(sTributos,9,2)+DecimalSeparator+Copy(sTributos,11,2),0);
      DadosUltimaReducao.Tributos[3].ValorTributado := StrToCurrDef(Copy(sValorAliquota[3],1,12)+DecimalSeparator+Copy(sValorAliquota[3],13,2),0);
      DadosUltimaReducao.Tributos[4].Aliquota := StrToCurrDef(Copy(sTributos,13,2)+DecimalSeparator+Copy(sTributos,15,2),0);
      DadosUltimaReducao.Tributos[4].ValorTributado := StrToCurrDef(Copy(sValorAliquota[4],1,12)+DecimalSeparator+Copy(sValorAliquota[4],13,2),0);
      DadosUltimaReducao.Tributos[5].Aliquota := StrToCurrDef(Copy(sTributos,17,2)+DecimalSeparator+Copy(sTributos,19,2),0);
      DadosUltimaReducao.Tributos[5].ValorTributado := StrToCurrDef(Copy(sValorAliquota[5],1,12)+DecimalSeparator+Copy(sValorAliquota[5],13,2),0);
      DadosUltimaReducao.Tributos[6].Aliquota := StrToCurrDef(Copy(sTributos,21,2)+DecimalSeparator+Copy(sTributos,23,2),0);
      DadosUltimaReducao.Tributos[6].ValorTributado := StrToCurrDef(Copy(sValorAliquota[6],1,12)+DecimalSeparator+Copy(sValorAliquota[6],13,2),0);
      DadosUltimaReducao.Tributos[7].Aliquota := StrToCurrDef(Copy(sTributos,25,2)+DecimalSeparator+Copy(sTributos,27,2),0);
      DadosUltimaReducao.Tributos[7].ValorTributado := StrToCurrDef(Copy(sValorAliquota[7],1,12)+DecimalSeparator+Copy(sValorAliquota[7],13,2),0);
      DadosUltimaReducao.Tributos[8].Aliquota := StrToCurrDef(Copy(sTributos,29,2)+DecimalSeparator+Copy(sTributos,31,2),0);
      DadosUltimaReducao.Tributos[8].ValorTributado := StrToCurrDef(Copy(sValorAliquota[8],1,12)+DecimalSeparator+Copy(sValorAliquota[8],13,2),0);
      DadosUltimaReducao.Tributos[9].Aliquota := StrToCurrDef(Copy(sTributos,33,2)+DecimalSeparator+Copy(sTributos,35,2),0);
      DadosUltimaReducao.Tributos[9].ValorTributado := StrToCurrDef(Copy(sValorAliquota[9],1,12)+DecimalSeparator+Copy(sValorAliquota[9],13,2),0);
      DadosUltimaReducao.Tributos[10].Aliquota := StrToCurrDef(Copy(sTributos,37,2)+DecimalSeparator+Copy(sTributos,39,2),0);
      DadosUltimaReducao.Tributos[10].ValorTributado := StrToCurrDef(Copy(sValorAliquota[10],1,12)+DecimalSeparator+Copy(sValorAliquota[10],13,2),0);
      DadosUltimaReducao.Tributos[11].Aliquota := StrToCurrDef(Copy(sTributos,41,2)+DecimalSeparator+Copy(sTributos,43,2),0);
      DadosUltimaReducao.Tributos[11].ValorTributado := StrToCurrDef(Copy(sValorAliquota[11],1,12)+DecimalSeparator+Copy(sValorAliquota[11],13,2),0);
      DadosUltimaReducao.Tributos[12].Aliquota := StrToCurrDef(Copy(sTributos,45,2)+DecimalSeparator+Copy(sTributos,47,2),0);
      DadosUltimaReducao.Tributos[12].ValorTributado := StrToCurrDef(Copy(sValorAliquota[12],1,12)+DecimalSeparator+Copy(sValorAliquota[12],13,2),0);
      DadosUltimaReducao.Tributos[13].Aliquota := StrToCurrDef(Copy(sTributos,49,2)+DecimalSeparator+Copy(sTributos,51,2),0);
      DadosUltimaReducao.Tributos[13].ValorTributado := StrToCurrDef(Copy(sValorAliquota[13],1,12)+DecimalSeparator+Copy(sValorAliquota[13],13,2),0);
      DadosUltimaReducao.Tributos[14].Aliquota := StrToCurrDef(Copy(sTributos,53,2)+DecimalSeparator+Copy(sTributos,55,2),0);
      DadosUltimaReducao.Tributos[14].ValorTributado := StrToCurrDef(Copy(sValorAliquota[14],1,12)+DecimalSeparator+Copy(sValorAliquota[14],13,2),0);
      DadosUltimaReducao.Tributos[15].Aliquota := StrToCurrDef(Copy(sTributos,57,2)+DecimalSeparator+Copy(sTributos,59,2),0);
      DadosUltimaReducao.Tributos[15].ValorTributado := StrToCurrDef(Copy(sValorAliquota[15],1,12)+DecimalSeparator+Copy(sValorAliquota[15],13,2),0);
      DadosUltimaReducao.Tributos[16].Aliquota := StrToCurrDef(Copy(sTributos,61,2)+DecimalSeparator+Copy(sTributos,63,2),0);
      DadosUltimaReducao.Tributos[16].ValorTributado := StrToCurrDef(Copy(sValorAliquota[16],1,12)+DecimalSeparator+Copy(sValorAliquota[16],13,2),0);
      DadosUltimaReducao.Isencao := StrToCurrDef(Copy(sValorAliquota[17],1,12)+DecimalSeparator+Copy(sValorAliquota[17],13,2),0);
      DadosUltimaReducao.NaoIncidencia := StrToCurrDef(Copy(sValorAliquota[18],1,12)+DecimalSeparator+Copy(sValorAliquota[18],13,2),0);
      DadosUltimaReducao.SubstTributaria := StrToCurrDef(Copy(sValorAliquota[19],1,12)+DecimalSeparator+Copy(sValorAliquota[19],13,2),0);
      DadosUltimaReducao.Sangrias := StrToCurrDef(Copy(sSangrias,1,12)+DecimalSeparator+Copy(sSangrias,13,2),0);
      DadosUltimaReducao.Suprimentos := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      DadosUltimaReducao.COO := sCOO;
      DadosUltimaReducao.DataMovimento := StrToDate(Copy(sDataMov,1,2) + '/' +
                                                    Copy(sDataMov,3,2) + '/' +
                                                    Copy(sDataMov,5,2));
   End else If ( TipoECF = teDaruma ) Then begin
      Dados := Space(631);

      Retorno := Daruma_FI_DadosUltimaReducao(Dados);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;

      //Formatação da string
      //00, - Modo Reducao - 0-3
      //000000000000000000, - Grande Total - 4-22
      //00000000000000, - Cancelamentos - 23-37
      //00000000000000, - Descontos - 38-52
      //00...000000000, - Tributos - 53-117
      //00...000000000, - Valores registrado nas Aliquotas - 118-384
      //00000000000000, - Sangrias - 385-399
      //00000000000000, - Suprimentos - 400-414
      //00...000000000, - Totalizadores não sujeitos ao ICMS - 415-541
      //00...000000000, - Contadores dos TP's não sujeitos ao ICMS - 542-578
      //000000, - COO - 579-585
      //000000, - Contador de operações não sujeitas ao ICMS - 586-592
      //00, - Número de Alíquotas cadastradas - 593-595
      //000000, - Data do movimento - 596-602
      //00000000000000, - Acréscimos - 603-617
      //00000000000000 - Acréscimo financeiro - 618-631

      sModoReducao := Copy(Dados,1,2);
      sGrandeTotal := Copy(Dados,4,18);
      sCancelamentos := Copy(Dados,23,14);
      sDescontos := Copy(Dados,38,14);
      sTributos := Copy(Dados,53,64);
      sValorAliquota[1] := Copy(Dados,118,14);
      sValorAliquota[2] := Copy(Dados,132,14);
      sValorAliquota[3] := Copy(Dados,146,14);
      sValorAliquota[4] := Copy(Dados,160,14);
      sValorAliquota[5] := Copy(Dados,174,14);
      sValorAliquota[6] := Copy(Dados,188,14);
      sValorAliquota[7] := Copy(Dados,202,14);
      sValorAliquota[8] := Copy(Dados,216,14);
      sValorAliquota[9] := Copy(Dados,230,14);
      sValorAliquota[10] := Copy(Dados,244,14);
      sValorAliquota[11] := Copy(Dados,258,14);
      sValorAliquota[12] := Copy(Dados,272,14);
      sValorAliquota[13] := Copy(Dados,286,14);
      sValorAliquota[14] := Copy(Dados,300,14);
      sValorAliquota[15] := Copy(Dados,314,14);
      sValorAliquota[16] := Copy(Dados,328,14);
      sValorAliquota[17] := Copy(Dados,342,14);
      sValorAliquota[18] := Copy(Dados,356,14);
      sValorAliquota[19] := Copy(Dados,370,14);
      sSangrias := Copy(Dados,385,14);
      sSuprimentos := Copy(Dados,400,14);
      sCOO := Copy(Dados,579,6);
      sDataMov := Copy(Dados,596,6);

      DadosUltimaReducao.ModoReducao := sModoReducao;
      DadosUltimaReducao.GrandeTotal := StrToCurrDef(Copy(sGrandeTotal,1,16)+DecimalSeparator+Copy(sGrandeTotal,17,2),0);
      DadosUltimaReducao.Cancelamentos := StrToCurrDef(Copy(sCancelamentos,1,12)+DecimalSeparator+Copy(sCancelamentos,13,2),0);
      DadosUltimaReducao.Descontos := StrToCurrDef(Copy(sDescontos,1,12)+DecimalSeparator+Copy(sDescontos,13,2),0);
      DadosUltimaReducao.Tributos[1].Aliquota := StrToCurrDef(Copy(sTributos,1,2)+DecimalSeparator+Copy(sTributos,3,2),0);
      DadosUltimaReducao.Tributos[1].ValorTributado := StrToCurrDef(Copy(sValorAliquota[1],1,12)+DecimalSeparator+Copy(sValorAliquota[1],13,2),0);
      DadosUltimaReducao.Tributos[2].Aliquota := StrToCurrDef(Copy(sTributos,5,2)+DecimalSeparator+Copy(sTributos,7,2),0);
      DadosUltimaReducao.Tributos[2].ValorTributado := StrToCurrDef(Copy(sValorAliquota[2],1,12)+DecimalSeparator+Copy(sValorAliquota[2],13,2),0);
      DadosUltimaReducao.Tributos[3].Aliquota := StrToCurrDef(Copy(sTributos,9,2)+DecimalSeparator+Copy(sTributos,11,2),0);
      DadosUltimaReducao.Tributos[3].ValorTributado := StrToCurrDef(Copy(sValorAliquota[3],1,12)+DecimalSeparator+Copy(sValorAliquota[3],13,2),0);
      DadosUltimaReducao.Tributos[4].Aliquota := StrToCurrDef(Copy(sTributos,13,2)+DecimalSeparator+Copy(sTributos,15,2),0);
      DadosUltimaReducao.Tributos[4].ValorTributado := StrToCurrDef(Copy(sValorAliquota[4],1,12)+DecimalSeparator+Copy(sValorAliquota[4],13,2),0);
      DadosUltimaReducao.Tributos[5].Aliquota := StrToCurrDef(Copy(sTributos,17,2)+DecimalSeparator+Copy(sTributos,19,2),0);
      DadosUltimaReducao.Tributos[5].ValorTributado := StrToCurrDef(Copy(sValorAliquota[5],1,12)+DecimalSeparator+Copy(sValorAliquota[5],13,2),0);
      DadosUltimaReducao.Tributos[6].Aliquota := StrToCurrDef(Copy(sTributos,21,2)+DecimalSeparator+Copy(sTributos,23,2),0);
      DadosUltimaReducao.Tributos[6].ValorTributado := StrToCurrDef(Copy(sValorAliquota[6],1,12)+DecimalSeparator+Copy(sValorAliquota[6],13,2),0);
      DadosUltimaReducao.Tributos[7].Aliquota := StrToCurrDef(Copy(sTributos,25,2)+DecimalSeparator+Copy(sTributos,27,2),0);
      DadosUltimaReducao.Tributos[7].ValorTributado := StrToCurrDef(Copy(sValorAliquota[7],1,12)+DecimalSeparator+Copy(sValorAliquota[7],13,2),0);
      DadosUltimaReducao.Tributos[8].Aliquota := StrToCurrDef(Copy(sTributos,29,2)+DecimalSeparator+Copy(sTributos,31,2),0);
      DadosUltimaReducao.Tributos[8].ValorTributado := StrToCurrDef(Copy(sValorAliquota[8],1,12)+DecimalSeparator+Copy(sValorAliquota[8],13,2),0);
      DadosUltimaReducao.Tributos[9].Aliquota := StrToCurrDef(Copy(sTributos,33,2)+DecimalSeparator+Copy(sTributos,35,2),0);
      DadosUltimaReducao.Tributos[9].ValorTributado := StrToCurrDef(Copy(sValorAliquota[9],1,12)+DecimalSeparator+Copy(sValorAliquota[9],13,2),0);
      DadosUltimaReducao.Tributos[10].Aliquota := StrToCurrDef(Copy(sTributos,37,2)+DecimalSeparator+Copy(sTributos,39,2),0);
      DadosUltimaReducao.Tributos[10].ValorTributado := StrToCurrDef(Copy(sValorAliquota[10],1,12)+DecimalSeparator+Copy(sValorAliquota[10],13,2),0);
      DadosUltimaReducao.Tributos[11].Aliquota := StrToCurrDef(Copy(sTributos,41,2)+DecimalSeparator+Copy(sTributos,43,2),0);
      DadosUltimaReducao.Tributos[11].ValorTributado := StrToCurrDef(Copy(sValorAliquota[11],1,12)+DecimalSeparator+Copy(sValorAliquota[11],13,2),0);
      DadosUltimaReducao.Tributos[12].Aliquota := StrToCurrDef(Copy(sTributos,45,2)+DecimalSeparator+Copy(sTributos,47,2),0);
      DadosUltimaReducao.Tributos[12].ValorTributado := StrToCurrDef(Copy(sValorAliquota[12],1,12)+DecimalSeparator+Copy(sValorAliquota[12],13,2),0);
      DadosUltimaReducao.Tributos[13].Aliquota := StrToCurrDef(Copy(sTributos,49,2)+DecimalSeparator+Copy(sTributos,51,2),0);
      DadosUltimaReducao.Tributos[13].ValorTributado := StrToCurrDef(Copy(sValorAliquota[13],1,12)+DecimalSeparator+Copy(sValorAliquota[13],13,2),0);
      DadosUltimaReducao.Tributos[14].Aliquota := StrToCurrDef(Copy(sTributos,53,2)+DecimalSeparator+Copy(sTributos,55,2),0);
      DadosUltimaReducao.Tributos[14].ValorTributado := StrToCurrDef(Copy(sValorAliquota[14],1,12)+DecimalSeparator+Copy(sValorAliquota[14],13,2),0);
      DadosUltimaReducao.Tributos[15].Aliquota := StrToCurrDef(Copy(sTributos,57,2)+DecimalSeparator+Copy(sTributos,59,2),0);
      DadosUltimaReducao.Tributos[15].ValorTributado := StrToCurrDef(Copy(sValorAliquota[15],1,12)+DecimalSeparator+Copy(sValorAliquota[15],13,2),0);
      DadosUltimaReducao.Tributos[16].Aliquota := StrToCurrDef(Copy(sTributos,61,2)+DecimalSeparator+Copy(sTributos,63,2),0);
      DadosUltimaReducao.Tributos[16].ValorTributado := StrToCurrDef(Copy(sValorAliquota[16],1,12)+DecimalSeparator+Copy(sValorAliquota[16],13,2),0);
      DadosUltimaReducao.Isencao := StrToCurrDef(Copy(sValorAliquota[17],1,12)+DecimalSeparator+Copy(sValorAliquota[17],13,2),0);
      DadosUltimaReducao.NaoIncidencia := StrToCurrDef(Copy(sValorAliquota[18],1,12)+DecimalSeparator+Copy(sValorAliquota[18],13,2),0);
      DadosUltimaReducao.SubstTributaria := StrToCurrDef(Copy(sValorAliquota[19],1,12)+DecimalSeparator+Copy(sValorAliquota[19],13,2),0);
      DadosUltimaReducao.Sangrias := StrToCurrDef(Copy(sSangrias,1,12)+DecimalSeparator+Copy(sSangrias,13,2),0);
      DadosUltimaReducao.Suprimentos := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      DadosUltimaReducao.COO := sCOO;
      DadosUltimaReducao.DataMovimento := StrToDate(Copy(sDataMov,1,2) + '/' +
                                                    Copy(sDataMov,3,2) + '/' +
                                                    Copy(sDataMov,5,2));
   End;
end;

//////////////////////////////////////////////////////////////////////////////
//Função utilizada para pegar os dados da ultima redução Z da ecf com mfd
//Retorno:
//        Se retorno = True funcão executada com sucesso
//           retorno = False ocorreu falha na execução a mensagem do erro
//                     será retornada no parametro Erro
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////////////
Function Pega_Dados_Ultima_ReducaoMFD(Var DadosUltimaReducao:TDadosUltimaReducaoMFD;
                                      Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////////////
Var Dados,sTotalizadorGeral,sIsencaoICMS,sNaoIncidenciaICMS,sSubstTributariaICMS,
    sIsencaoISSQN,sNaoIncidenciaISSQN,sSubstTributariaISSQN,sTributos,
    sDescontosICMS,sDescontosISSQN,sAcrescimosICMS,sAcrescimosISSQN,
    sCancelamentosICMS,sCancelamentosISSQN,sSangrias,sSuprimentos,
    sCancelamentosNaoFiscais,sDescontosNaoFiscais,sAcrescimosNaoFiscais,
    sAliquotas,sDataMovimento:String;
    sValorAliquota:Array[1..16] of String;
    Retorno:Integer;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Dados := Space(1278);

      Retorno := Bematech_FI_DadosUltimaReducaoMFD(Dados);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
         Exit;
      End;

      DadosUltimaReducao.ModoReducao                        := Copy(Dados,1,2);
      DadosUltimaReducao.ContadorCRO                        := Copy(Dados,4,4);
      DadosUltimaReducao.ContadorReducaoZ                   := Copy(Dados,9,4);
      DadosUltimaReducao.COO                                := Copy(Dados,14,6);
      DadosUltimaReducao.ContadorGeralOperacaoNaoFiscal     := Copy(Dados,21,6);
      DadosUltimaReducao.ContadorCupomFiscal                := Copy(Dados,28,6);
      DadosUltimaReducao.ContadorGeralRelatorioGerencial    := Copy(Dados,35,6);
      DadosUltimaReducao.ContadorFitaDetalheEmitida         := Copy(Dados,42,6);
      DadosUltimaReducao.ContadorOperacaoNaoFiscalCancelada := Copy(Dados,49,4);
      DadosUltimaReducao.ContadorCupomFiscalCancelado       := Copy(Dados,54,4);
      //sContadoresEspecificosOperacoesNaoFiscais           := Copy(Dados,59,120);
      //sContadoresEspecificosRelatoriosGerenciais          := Copy(Dados,180,120);
      DadosUltimaReducao.ContadorCDCsEmitidos               := Copy(Dados,301,4);
      DadosUltimaReducao.ContadorCDCsNaoEmitidos            := Copy(Dados,306,4);
      DadosUltimaReducao.ContadorCDCsCancelados             := Copy(Dados,311,4);
      sTotaLizadorGeral                                     := Copy(Dados,316,18);
      DadosUltimaReducao.TotalizadorGeral                   := StrToCurrDef(Copy(sTotalizadorGeral,1,16)+DecimalSeparator+Copy(sTotalizadorGeral,17,2),0);
      sTributos                                             := Copy(Dados,335,224);
      sIsencaoICMS                                          := Copy(Dados,560,14);
      DadosUltimaReducao.IsencaoICMS                        := StrToCurrDef(Copy(sIsencaoICMS,1,12)+DecimalSeparator+Copy(sIsencaoICMS,13,2),0);
      sNaoIncidenciaICMS                                    := Copy(Dados,575,14);
      DadosUltimaReducao.NaoIncidenciaICMS                  := StrToCurrDef(Copy(sNaoIncidenciaICMS,1,12)+DecimalSeparator+Copy(sNaoIncidenciaICMS,13,2),0);
      sSubstTributariaICMS                                  := Copy(Dados,590,14);
      DadosUltimaReducao.SubstTributariaICMS                := StrToCurrDef(Copy(sSubstTributariaICMS,1,12)+DecimalSeparator+Copy(sSubstTributariaICMS,13,2),0);
      sIsencaoISSQN                                         := Copy(Dados,605,14);
      DadosUltimaReducao.IsencaoISSQN                       := StrToCurrDef(Copy(sIsencaoISSQN,1,12)+DecimalSeparator+Copy(sIsencaoISSQN,13,2),0);
      sNaoIncidenciaISSQN                                   := Copy(Dados,620,14);
      DadosUltimaReducao.NaoIncidenciaISSQN                 := StrToCurrDef(Copy(sNaoIncidenciaISSQN,1,12)+DecimalSeparator+Copy(sNaoIncidenciaISSQN,13,2),0);
      sSubstTributariaISSQN                                 := Copy(Dados,635,14);
      DadosUltimaReducao.SubstTributariaISSQN               := StrToCurrDef(Copy(sSubstTributariaISSQN,1,12)+DecimalSeparator+Copy(sSubstTributariaISSQN,13,2),0);
      sDescontosICMS                                        := Copy(Dados,650,14);
      DadosUltimaReducao.DescontosICMS                      := StrToCurrDef(Copy(sDescontosICMS,1,12)+DecimalSeparator+Copy(sDescontosICMS,13,2),0);
      sDescontosISSQN                                       := Copy(Dados,665,14);
      DadosUltimaReducao.DescontosISSQN                     := StrToCurrDef(Copy(sDescontosISSQN,1,12)+DecimalSeparator+Copy(sDescontosISSQN,13,2),0);
      sAcrescimosICMS                                       := Copy(Dados,680,14);
      DadosUltimaReducao.AcrescimosICMS                     := StrToCurrDef(Copy(sAcrescimosICMS,1,12)+DecimalSeparator+Copy(sAcrescimosICMS,13,2),0);
      sAcrescimosISSQN                                      := Copy(Dados,695,14);
      DadosUltimaReducao.AcrescimosISSQN                    := StrToCurrDef(Copy(sAcrescimosISSQN,1,12)+DecimalSeparator+Copy(sAcrescimosISSQN,13,2),0);
      sCancelamentosICMS                                    := Copy(Dados,710,14);
      DadosUltimaReducao.CancelamentosICMS                  := StrToCurrDef(Copy(sCancelamentosICMS,1,12)+DecimalSeparator+Copy(sCancelamentosICMS,13,2),0);
      sCancelamentosISSQN                                   := Copy(Dados,725,14);
      DadosUltimaReducao.CancelamentosISSQN                 := StrToCurrDef(Copy(sCancelamentosISSQN,1,12)+DecimalSeparator+Copy(sCancelamentosISSQN,13,2),0);
      //sTotalizadoresParciaisNaoSujeitosICMS               := Copy(Dados,740,392);
      sSangrias                                             := Copy(Dados,1133,14);
      DadosUltimaReducao.Sangrias                           := StrToCurrDef(Copy(sSangrias,1,12)+DecimalSeparator+Copy(sSangrias,13,2),0);
      sSuprimentos                                          := Copy(Dados,1148,14);
      DadosUltimaReducao.Suprimentos                        := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      sCancelamentosNaoFiscais                              := Copy(Dados,1163,14);
      DadosUltimaReducao.CancelamentosNaoFiscais            := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      sDescontosNaoFiscais                                  := Copy(Dados,1178,14);
      DadosUltimaReducao.DescontosNaoFiscais                := StrToCurrDef(Copy(sDescontosNaoFiscais,1,12)+DecimalSeparator+Copy(sDescontosNaoFiscais,13,2),0);
      sAcrescimosNaoFiscais                                 := Copy(Dados,1193,14);
      DadosUltimaReducao.AcrescimosNaoFiscais               := StrToCurrDef(Copy(sAcrescimosNaoFiscais,1,12)+DecimalSeparator+Copy(sAcrescimosNaoFiscais,13,2),0);
      sAliquotas                                            := Copy(Dados,1208,64);
      sDataMovimento                                        := Copy(Dados,1273,6);

      //Converta para data
      DadosUltimaReducao.DataMovimento := StrToDateDef(Copy(sDataMovimento,1,2) + '/' +
                                                       Copy(sDataMovimento,3,2) + '/' +
                                                       Copy(sDataMovimento,5,2),0);

      //Se não houver data do último movimento retorna
      //Modo redução = 99
      If ( DadosUltimaReducao.DataMovimento = 0 ) Then begin
         DadosUltimaReducao.ModoReducao := '99';
         Exit;
      End;

      //Monta as Aliquotas
      sValorAliquota[01] := Copy(sTributos,1,14);
      sValorAliquota[02] := Copy(sTributos,15,14);
      sValorAliquota[03] := Copy(sTributos,29,14);
      sValorAliquota[04] := Copy(sTributos,43,14);
      sValorAliquota[05] := Copy(sTributos,57,14);
      sValorAliquota[06] := Copy(sTributos,71,14);
      sValorAliquota[07] := Copy(sTributos,85,14);
      sValorAliquota[08] := Copy(sTributos,99,14);
      sValorAliquota[09] := Copy(sTributos,113,14);
      sValorAliquota[10] := Copy(sTributos,127,14);
      sValorAliquota[11] := Copy(sTributos,141,14);
      sValorAliquota[12] := Copy(sTributos,155,14);
      sValorAliquota[13] := Copy(sTributos,169,14);
      sValorAliquota[14] := Copy(sTributos,183,14);
      sValorAliquota[15] := Copy(sTributos,197,14);
      sValorAliquota[16] := Copy(sTributos,211,14);

      DadosUltimaReducao.Tributos[1].Aliquota := StrToCurrDef(Copy(sAliquotas,1,2)+DecimalSeparator+Copy(sAliquotas,3,2),0);
      DadosUltimaReducao.Tributos[1].ValorTributado := StrToCurrDef(Copy(sValorAliquota[1],1,12)+DecimalSeparator+Copy(sValorAliquota[1],13,2),0);
      DadosUltimaReducao.Tributos[2].Aliquota := StrToCurrDef(Copy(sAliquotas,5,2)+DecimalSeparator+Copy(sAliquotas,7,2),0);
      DadosUltimaReducao.Tributos[2].ValorTributado := StrToCurrDef(Copy(sValorAliquota[2],1,12)+DecimalSeparator+Copy(sValorAliquota[2],13,2),0);
      DadosUltimaReducao.Tributos[3].Aliquota := StrToCurrDef(Copy(sAliquotas,9,2)+DecimalSeparator+Copy(sAliquotas,11,2),0);
      DadosUltimaReducao.Tributos[3].ValorTributado := StrToCurrDef(Copy(sValorAliquota[3],1,12)+DecimalSeparator+Copy(sValorAliquota[3],13,2),0);
      DadosUltimaReducao.Tributos[4].Aliquota := StrToCurrDef(Copy(sAliquotas,13,2)+DecimalSeparator+Copy(sAliquotas,15,2),0);
      DadosUltimaReducao.Tributos[4].ValorTributado := StrToCurrDef(Copy(sValorAliquota[4],1,12)+DecimalSeparator+Copy(sValorAliquota[4],13,2),0);
      DadosUltimaReducao.Tributos[5].Aliquota := StrToCurrDef(Copy(sAliquotas,17,2)+DecimalSeparator+Copy(sAliquotas,19,2),0);
      DadosUltimaReducao.Tributos[5].ValorTributado := StrToCurrDef(Copy(sValorAliquota[5],1,12)+DecimalSeparator+Copy(sValorAliquota[5],13,2),0);
      DadosUltimaReducao.Tributos[6].Aliquota := StrToCurrDef(Copy(sAliquotas,21,2)+DecimalSeparator+Copy(sAliquotas,23,2),0);
      DadosUltimaReducao.Tributos[6].ValorTributado := StrToCurrDef(Copy(sValorAliquota[6],1,12)+DecimalSeparator+Copy(sValorAliquota[6],13,2),0);
      DadosUltimaReducao.Tributos[7].Aliquota := StrToCurrDef(Copy(sAliquotas,25,2)+DecimalSeparator+Copy(sAliquotas,27,2),0);
      DadosUltimaReducao.Tributos[7].ValorTributado := StrToCurrDef(Copy(sValorAliquota[7],1,12)+DecimalSeparator+Copy(sValorAliquota[7],13,2),0);
      DadosUltimaReducao.Tributos[8].Aliquota := StrToCurrDef(Copy(sAliquotas,29,2)+DecimalSeparator+Copy(sAliquotas,31,2),0);
      DadosUltimaReducao.Tributos[8].ValorTributado := StrToCurrDef(Copy(sValorAliquota[8],1,12)+DecimalSeparator+Copy(sValorAliquota[8],13,2),0);
      DadosUltimaReducao.Tributos[9].Aliquota := StrToCurrDef(Copy(sAliquotas,33,2)+DecimalSeparator+Copy(sAliquotas,35,2),0);
      DadosUltimaReducao.Tributos[9].ValorTributado := StrToCurrDef(Copy(sValorAliquota[9],1,12)+DecimalSeparator+Copy(sValorAliquota[9],13,2),0);
      DadosUltimaReducao.Tributos[10].Aliquota := StrToCurrDef(Copy(sAliquotas,37,2)+DecimalSeparator+Copy(sAliquotas,39,2),0);
      DadosUltimaReducao.Tributos[10].ValorTributado := StrToCurrDef(Copy(sValorAliquota[10],1,12)+DecimalSeparator+Copy(sValorAliquota[10],13,2),0);
      DadosUltimaReducao.Tributos[11].Aliquota := StrToCurrDef(Copy(sAliquotas,41,2)+DecimalSeparator+Copy(sAliquotas,43,2),0);
      DadosUltimaReducao.Tributos[11].ValorTributado := StrToCurrDef(Copy(sValorAliquota[11],1,12)+DecimalSeparator+Copy(sValorAliquota[11],13,2),0);
      DadosUltimaReducao.Tributos[12].Aliquota := StrToCurrDef(Copy(sAliquotas,45,2)+DecimalSeparator+Copy(sAliquotas,47,2),0);
      DadosUltimaReducao.Tributos[12].ValorTributado := StrToCurrDef(Copy(sValorAliquota[12],1,12)+DecimalSeparator+Copy(sValorAliquota[12],13,2),0);
      DadosUltimaReducao.Tributos[13].Aliquota := StrToCurrDef(Copy(sAliquotas,49,2)+DecimalSeparator+Copy(sAliquotas,51,2),0);
      DadosUltimaReducao.Tributos[13].ValorTributado := StrToCurrDef(Copy(sValorAliquota[13],1,12)+DecimalSeparator+Copy(sValorAliquota[13],13,2),0);
      DadosUltimaReducao.Tributos[14].Aliquota := StrToCurrDef(Copy(sAliquotas,53,2)+DecimalSeparator+Copy(sAliquotas,55,2),0);
      DadosUltimaReducao.Tributos[14].ValorTributado := StrToCurrDef(Copy(sValorAliquota[14],1,12)+DecimalSeparator+Copy(sValorAliquota[14],13,2),0);
      DadosUltimaReducao.Tributos[15].Aliquota := StrToCurrDef(Copy(sAliquotas,57,2)+DecimalSeparator+Copy(sAliquotas,59,2),0);
      DadosUltimaReducao.Tributos[15].ValorTributado := StrToCurrDef(Copy(sValorAliquota[15],1,12)+DecimalSeparator+Copy(sValorAliquota[15],13,2),0);
      DadosUltimaReducao.Tributos[16].Aliquota := StrToCurrDef(Copy(sAliquotas,61,2)+DecimalSeparator+Copy(sAliquotas,63,2),0);
      DadosUltimaReducao.Tributos[16].ValorTributado := StrToCurrDef(Copy(sValorAliquota[16],1,12)+DecimalSeparator+Copy(sValorAliquota[16],13,2),0);
   End else If ( TipoECF = teSweda ) Then begin
      Dados := Space(1278);

      Retorno := Sweda.ECF_DadosUltimaReducaoMFD(Dados);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
         Exit;
      End;

      DadosUltimaReducao.ModoReducao                        := Copy(Dados,1,2);
      DadosUltimaReducao.ContadorCRO                        := Copy(Dados,4,4);
      DadosUltimaReducao.ContadorReducaoZ                   := Copy(Dados,9,4);
      DadosUltimaReducao.COO                                := Copy(Dados,14,6);
      DadosUltimaReducao.ContadorGeralOperacaoNaoFiscal     := Copy(Dados,21,6);
      DadosUltimaReducao.ContadorCupomFiscal                := Copy(Dados,28,6);
      DadosUltimaReducao.ContadorGeralRelatorioGerencial    := Copy(Dados,35,6);
      DadosUltimaReducao.ContadorFitaDetalheEmitida         := Copy(Dados,42,6);
      DadosUltimaReducao.ContadorOperacaoNaoFiscalCancelada := Copy(Dados,49,4);
      DadosUltimaReducao.ContadorCupomFiscalCancelado       := Copy(Dados,54,4);
      //sContadoresEspecificosOperacoesNaoFiscais           := Copy(Dados,59,120);
      //sContadoresEspecificosRelatoriosGerenciais          := Copy(Dados,180,120);
      DadosUltimaReducao.ContadorCDCsEmitidos               := Copy(Dados,301,4);
      DadosUltimaReducao.ContadorCDCsNaoEmitidos            := Copy(Dados,306,4);
      DadosUltimaReducao.ContadorCDCsCancelados             := Copy(Dados,311,4);
      sTotaLizadorGeral                                     := Copy(Dados,316,18);
      DadosUltimaReducao.TotalizadorGeral                   := StrToCurrDef(Copy(sTotalizadorGeral,1,16)+DecimalSeparator+Copy(sTotalizadorGeral,17,2),0);
      sTributos                                             := Copy(Dados,335,224);
      sIsencaoICMS                                          := Copy(Dados,560,14);
      DadosUltimaReducao.IsencaoICMS                        := StrToCurrDef(Copy(sIsencaoICMS,1,12)+DecimalSeparator+Copy(sIsencaoICMS,13,2),0);
      sNaoIncidenciaICMS                                    := Copy(Dados,575,14);
      DadosUltimaReducao.NaoIncidenciaICMS                  := StrToCurrDef(Copy(sNaoIncidenciaICMS,1,12)+DecimalSeparator+Copy(sNaoIncidenciaICMS,13,2),0);
      sSubstTributariaICMS                                  := Copy(Dados,590,14);
      DadosUltimaReducao.SubstTributariaICMS                := StrToCurrDef(Copy(sSubstTributariaICMS,1,12)+DecimalSeparator+Copy(sSubstTributariaICMS,13,2),0);
      sIsencaoISSQN                                         := Copy(Dados,605,14);
      DadosUltimaReducao.IsencaoISSQN                       := StrToCurrDef(Copy(sIsencaoISSQN,1,12)+DecimalSeparator+Copy(sIsencaoISSQN,13,2),0);
      sNaoIncidenciaISSQN                                   := Copy(Dados,620,14);
      DadosUltimaReducao.NaoIncidenciaISSQN                 := StrToCurrDef(Copy(sNaoIncidenciaISSQN,1,12)+DecimalSeparator+Copy(sNaoIncidenciaISSQN,13,2),0);
      sSubstTributariaISSQN                                 := Copy(Dados,635,14);
      DadosUltimaReducao.SubstTributariaISSQN               := StrToCurrDef(Copy(sSubstTributariaISSQN,1,12)+DecimalSeparator+Copy(sSubstTributariaISSQN,13,2),0);
      sDescontosICMS                                        := Copy(Dados,650,14);
      DadosUltimaReducao.DescontosICMS                      := StrToCurrDef(Copy(sDescontosICMS,1,12)+DecimalSeparator+Copy(sDescontosICMS,13,2),0);
      sDescontosISSQN                                       := Copy(Dados,665,14);
      DadosUltimaReducao.DescontosISSQN                     := StrToCurrDef(Copy(sDescontosISSQN,1,12)+DecimalSeparator+Copy(sDescontosISSQN,13,2),0);
      sAcrescimosICMS                                       := Copy(Dados,680,14);
      DadosUltimaReducao.AcrescimosICMS                     := StrToCurrDef(Copy(sAcrescimosICMS,1,12)+DecimalSeparator+Copy(sAcrescimosICMS,13,2),0);
      sAcrescimosISSQN                                      := Copy(Dados,695,14);
      DadosUltimaReducao.AcrescimosISSQN                    := StrToCurrDef(Copy(sAcrescimosISSQN,1,12)+DecimalSeparator+Copy(sAcrescimosISSQN,13,2),0);
      sCancelamentosICMS                                    := Copy(Dados,710,14);
      DadosUltimaReducao.CancelamentosICMS                  := StrToCurrDef(Copy(sCancelamentosICMS,1,12)+DecimalSeparator+Copy(sCancelamentosICMS,13,2),0);
      sCancelamentosISSQN                                   := Copy(Dados,725,14);
      DadosUltimaReducao.CancelamentosISSQN                 := StrToCurrDef(Copy(sCancelamentosISSQN,1,12)+DecimalSeparator+Copy(sCancelamentosISSQN,13,2),0);
      //sTotalizadoresParciaisNaoSujeitosICMS               := Copy(Dados,740,392);
      sSangrias                                             := Copy(Dados,1133,14);
      DadosUltimaReducao.Sangrias                           := StrToCurrDef(Copy(sSangrias,1,12)+DecimalSeparator+Copy(sSangrias,13,2),0);
      sSuprimentos                                          := Copy(Dados,1148,14);
      DadosUltimaReducao.Suprimentos                        := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      sCancelamentosNaoFiscais                              := Copy(Dados,1163,14);
      DadosUltimaReducao.CancelamentosNaoFiscais            := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      sDescontosNaoFiscais                                  := Copy(Dados,1178,14);
      DadosUltimaReducao.DescontosNaoFiscais                := StrToCurrDef(Copy(sDescontosNaoFiscais,1,12)+DecimalSeparator+Copy(sDescontosNaoFiscais,13,2),0);
      sAcrescimosNaoFiscais                                 := Copy(Dados,1193,14);
      DadosUltimaReducao.AcrescimosNaoFiscais               := StrToCurrDef(Copy(sAcrescimosNaoFiscais,1,12)+DecimalSeparator+Copy(sAcrescimosNaoFiscais,13,2),0);
      sAliquotas                                            := Copy(Dados,1208,64);
      sDataMovimento                                        := Copy(Dados,1273,6);

      //Converta para data
      DadosUltimaReducao.DataMovimento := StrToDateDef(Copy(sDataMovimento,1,2) + '/' +
                                                       Copy(sDataMovimento,3,2) + '/' +
                                                       Copy(sDataMovimento,5,2),0);

      //Se não houver data da último movimento retorna
      //Modo redução = 99
      If ( DadosUltimaReducao.DataMovimento = 0 ) Then begin
         DadosUltimaReducao.ModoReducao := '99';
         Exit;
      End;

      //Monta as Aliquotas
      sValorAliquota[01] := Copy(sTributos,1,14);
      sValorAliquota[02] := Copy(sTributos,15,14);
      sValorAliquota[03] := Copy(sTributos,29,14);
      sValorAliquota[04] := Copy(sTributos,43,14);
      sValorAliquota[05] := Copy(sTributos,57,14);
      sValorAliquota[06] := Copy(sTributos,71,14);
      sValorAliquota[07] := Copy(sTributos,85,14);
      sValorAliquota[08] := Copy(sTributos,99,14);
      sValorAliquota[09] := Copy(sTributos,113,14);
      sValorAliquota[10] := Copy(sTributos,127,14);
      sValorAliquota[11] := Copy(sTributos,141,14);
      sValorAliquota[12] := Copy(sTributos,155,14);
      sValorAliquota[13] := Copy(sTributos,169,14);
      sValorAliquota[14] := Copy(sTributos,183,14);
      sValorAliquota[15] := Copy(sTributos,197,14);
      sValorAliquota[16] := Copy(sTributos,211,14);

      DadosUltimaReducao.Tributos[1].Aliquota := StrToCurrDef(Copy(sAliquotas,1,2)+DecimalSeparator+Copy(sAliquotas,3,2),0);
      DadosUltimaReducao.Tributos[1].ValorTributado := StrToCurrDef(Copy(sValorAliquota[1],1,12)+DecimalSeparator+Copy(sValorAliquota[1],13,2),0);
      DadosUltimaReducao.Tributos[2].Aliquota := StrToCurrDef(Copy(sAliquotas,5,2)+DecimalSeparator+Copy(sAliquotas,7,2),0);
      DadosUltimaReducao.Tributos[2].ValorTributado := StrToCurrDef(Copy(sValorAliquota[2],1,12)+DecimalSeparator+Copy(sValorAliquota[2],13,2),0);
      DadosUltimaReducao.Tributos[3].Aliquota := StrToCurrDef(Copy(sAliquotas,9,2)+DecimalSeparator+Copy(sAliquotas,11,2),0);
      DadosUltimaReducao.Tributos[3].ValorTributado := StrToCurrDef(Copy(sValorAliquota[3],1,12)+DecimalSeparator+Copy(sValorAliquota[3],13,2),0);
      DadosUltimaReducao.Tributos[4].Aliquota := StrToCurrDef(Copy(sAliquotas,13,2)+DecimalSeparator+Copy(sAliquotas,15,2),0);
      DadosUltimaReducao.Tributos[4].ValorTributado := StrToCurrDef(Copy(sValorAliquota[4],1,12)+DecimalSeparator+Copy(sValorAliquota[4],13,2),0);
      DadosUltimaReducao.Tributos[5].Aliquota := StrToCurrDef(Copy(sAliquotas,17,2)+DecimalSeparator+Copy(sAliquotas,19,2),0);
      DadosUltimaReducao.Tributos[5].ValorTributado := StrToCurrDef(Copy(sValorAliquota[5],1,12)+DecimalSeparator+Copy(sValorAliquota[5],13,2),0);
      DadosUltimaReducao.Tributos[6].Aliquota := StrToCurrDef(Copy(sAliquotas,21,2)+DecimalSeparator+Copy(sAliquotas,23,2),0);
      DadosUltimaReducao.Tributos[6].ValorTributado := StrToCurrDef(Copy(sValorAliquota[6],1,12)+DecimalSeparator+Copy(sValorAliquota[6],13,2),0);
      DadosUltimaReducao.Tributos[7].Aliquota := StrToCurrDef(Copy(sAliquotas,25,2)+DecimalSeparator+Copy(sAliquotas,27,2),0);
      DadosUltimaReducao.Tributos[7].ValorTributado := StrToCurrDef(Copy(sValorAliquota[7],1,12)+DecimalSeparator+Copy(sValorAliquota[7],13,2),0);
      DadosUltimaReducao.Tributos[8].Aliquota := StrToCurrDef(Copy(sAliquotas,29,2)+DecimalSeparator+Copy(sAliquotas,31,2),0);
      DadosUltimaReducao.Tributos[8].ValorTributado := StrToCurrDef(Copy(sValorAliquota[8],1,12)+DecimalSeparator+Copy(sValorAliquota[8],13,2),0);
      DadosUltimaReducao.Tributos[9].Aliquota := StrToCurrDef(Copy(sAliquotas,33,2)+DecimalSeparator+Copy(sAliquotas,35,2),0);
      DadosUltimaReducao.Tributos[9].ValorTributado := StrToCurrDef(Copy(sValorAliquota[9],1,12)+DecimalSeparator+Copy(sValorAliquota[9],13,2),0);
      DadosUltimaReducao.Tributos[10].Aliquota := StrToCurrDef(Copy(sAliquotas,37,2)+DecimalSeparator+Copy(sAliquotas,39,2),0);
      DadosUltimaReducao.Tributos[10].ValorTributado := StrToCurrDef(Copy(sValorAliquota[10],1,12)+DecimalSeparator+Copy(sValorAliquota[10],13,2),0);
      DadosUltimaReducao.Tributos[11].Aliquota := StrToCurrDef(Copy(sAliquotas,41,2)+DecimalSeparator+Copy(sAliquotas,43,2),0);
      DadosUltimaReducao.Tributos[11].ValorTributado := StrToCurrDef(Copy(sValorAliquota[11],1,12)+DecimalSeparator+Copy(sValorAliquota[11],13,2),0);
      DadosUltimaReducao.Tributos[12].Aliquota := StrToCurrDef(Copy(sAliquotas,45,2)+DecimalSeparator+Copy(sAliquotas,47,2),0);
      DadosUltimaReducao.Tributos[12].ValorTributado := StrToCurrDef(Copy(sValorAliquota[12],1,12)+DecimalSeparator+Copy(sValorAliquota[12],13,2),0);
      DadosUltimaReducao.Tributos[13].Aliquota := StrToCurrDef(Copy(sAliquotas,49,2)+DecimalSeparator+Copy(sAliquotas,51,2),0);
      DadosUltimaReducao.Tributos[13].ValorTributado := StrToCurrDef(Copy(sValorAliquota[13],1,12)+DecimalSeparator+Copy(sValorAliquota[13],13,2),0);
      DadosUltimaReducao.Tributos[14].Aliquota := StrToCurrDef(Copy(sAliquotas,53,2)+DecimalSeparator+Copy(sAliquotas,55,2),0);
      DadosUltimaReducao.Tributos[14].ValorTributado := StrToCurrDef(Copy(sValorAliquota[14],1,12)+DecimalSeparator+Copy(sValorAliquota[14],13,2),0);
      DadosUltimaReducao.Tributos[15].Aliquota := StrToCurrDef(Copy(sAliquotas,57,2)+DecimalSeparator+Copy(sAliquotas,59,2),0);
      DadosUltimaReducao.Tributos[15].ValorTributado := StrToCurrDef(Copy(sValorAliquota[15],1,12)+DecimalSeparator+Copy(sValorAliquota[15],13,2),0);
      DadosUltimaReducao.Tributos[16].Aliquota := StrToCurrDef(Copy(sAliquotas,61,2)+DecimalSeparator+Copy(sAliquotas,63,2),0);
      DadosUltimaReducao.Tributos[16].ValorTributado := StrToCurrDef(Copy(sValorAliquota[16],1,12)+DecimalSeparator+Copy(sValorAliquota[16],13,2),0);
   End else If ( TipoECF = teDaruma ) Then begin
      Dados := Space(1164);

      Retorno := Daruma_FIMFD_RetornaInformacao('140',Dados);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
         Exit;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
         Exit;
      End;

      DadosUltimaReducao.ModoReducao                        := '00';
      DadosUltimaReducao.ContadorCRO                        := Copy(Dados,923,4);
      DadosUltimaReducao.ContadorReducaoZ                   := Copy(Dados,927,4);
      DadosUltimaReducao.COO                                := Copy(Dados,935,6);
      DadosUltimaReducao.ContadorGeralOperacaoNaoFiscal     := Copy(Dados,941,6);
      DadosUltimaReducao.ContadorCupomFiscal                := Copy(Dados,947,6);
      DadosUltimaReducao.ContadorGeralRelatorioGerencial    := Copy(Dados,959,6);
      DadosUltimaReducao.ContadorFitaDetalheEmitida         := Copy(Dados,965,6);
      DadosUltimaReducao.ContadorOperacaoNaoFiscalCancelada := Copy(Dados,989,4);
      DadosUltimaReducao.ContadorCupomFiscalCancelado       := Copy(Dados,985,4);
      //sContadoresEspecificosOperacoesNaoFiscais           := Copy(Dados,59,120);
      //sContadoresEspecificosRelatoriosGerenciais          := Copy(Dados,180,120);
      DadosUltimaReducao.ContadorCDCsEmitidos               := '0000';
      DadosUltimaReducao.ContadorCDCsNaoEmitidos            := '0000';
      DadosUltimaReducao.ContadorCDCsCancelados             := '0000';
      sTotaLizadorGeral                                     := Copy(Dados,9,18);
      DadosUltimaReducao.TotalizadorGeral                   := StrToCurrDef(Copy(sTotalizadorGeral,1,16)+DecimalSeparator+Copy(sTotalizadorGeral,17,2),0);
      sTributos                                             := Copy(Dados,129,352);
      sIsencaoICMS                                          := Copy(Dados,381,14);
      DadosUltimaReducao.IsencaoICMS                        := StrToCurrDef(Copy(sIsencaoICMS,1,12)+DecimalSeparator+Copy(sIsencaoICMS,13,2),0);
      sNaoIncidenciaICMS                                    := Copy(Dados,409,14);
      DadosUltimaReducao.NaoIncidenciaICMS                  := StrToCurrDef(Copy(sNaoIncidenciaICMS,1,12)+DecimalSeparator+Copy(sNaoIncidenciaICMS,13,2),0);
      sSubstTributariaICMS                                  := Copy(Dados,353,14);
      DadosUltimaReducao.SubstTributariaICMS                := StrToCurrDef(Copy(sSubstTributariaICMS,1,12)+DecimalSeparator+Copy(sSubstTributariaICMS,13,2),0);
      sIsencaoISSQN                                         := Copy(Dados,465,14);
      DadosUltimaReducao.IsencaoISSQN                       := StrToCurrDef(Copy(sIsencaoISSQN,1,12)+DecimalSeparator+Copy(sIsencaoISSQN,13,2),0);
      sNaoIncidenciaISSQN                                   := Copy(Dados,493,14);
      DadosUltimaReducao.NaoIncidenciaISSQN                 := StrToCurrDef(Copy(sNaoIncidenciaISSQN,1,12)+DecimalSeparator+Copy(sNaoIncidenciaISSQN,13,2),0);
      sSubstTributariaISSQN                                 := Copy(Dados,437,14);
      DadosUltimaReducao.SubstTributariaISSQN               := StrToCurrDef(Copy(sSubstTributariaISSQN,1,12)+DecimalSeparator+Copy(sSubstTributariaISSQN,13,2),0);
      sDescontosICMS                                        := Copy(Dados,45,14);
      DadosUltimaReducao.DescontosICMS                      := StrToCurrDef(Copy(sDescontosICMS,1,12)+DecimalSeparator+Copy(sDescontosICMS,13,2),0);
      sDescontosISSQN                                       := Copy(Dados,59,14);
      DadosUltimaReducao.DescontosISSQN                     := StrToCurrDef(Copy(sDescontosISSQN,1,12)+DecimalSeparator+Copy(sDescontosISSQN,13,2),0);
      sAcrescimosICMS                                       := Copy(Dados,101,14);
      DadosUltimaReducao.AcrescimosICMS                     := StrToCurrDef(Copy(sAcrescimosICMS,1,12)+DecimalSeparator+Copy(sAcrescimosICMS,13,2),0);
      sAcrescimosISSQN                                      := Copy(Dados,115,14);
      DadosUltimaReducao.AcrescimosISSQN                    := StrToCurrDef(Copy(sAcrescimosISSQN,1,12)+DecimalSeparator+Copy(sAcrescimosISSQN,13,2),0);
      sCancelamentosICMS                                    := Copy(Dados,73,14);
      DadosUltimaReducao.CancelamentosICMS                  := StrToCurrDef(Copy(sCancelamentosICMS,1,12)+DecimalSeparator+Copy(sCancelamentosICMS,13,2),0);
      sCancelamentosISSQN                                   := Copy(Dados,87,14);
      DadosUltimaReducao.CancelamentosISSQN                 := StrToCurrDef(Copy(sCancelamentosISSQN,1,12)+DecimalSeparator+Copy(sCancelamentosISSQN,13,2),0);
      //sTotalizadoresParciaisNaoSujeitosICMS               := Copy(Dados,740,392);
      sSangrias                                             := '00000000000000';
      DadosUltimaReducao.Sangrias                           := StrToCurrDef(Copy(sSangrias,1,12)+DecimalSeparator+Copy(sSangrias,13,2),0);
      sSuprimentos                                          := '00000000000000';
      DadosUltimaReducao.Suprimentos                        := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      sCancelamentosNaoFiscais                              := Copy(Dados,815,14);
      DadosUltimaReducao.CancelamentosNaoFiscais            := StrToCurrDef(Copy(sSuprimentos,1,12)+DecimalSeparator+Copy(sSuprimentos,13,2),0);
      sDescontosNaoFiscais                                  := Copy(Dados,801,14);
      DadosUltimaReducao.DescontosNaoFiscais                := StrToCurrDef(Copy(sDescontosNaoFiscais,1,12)+DecimalSeparator+Copy(sDescontosNaoFiscais,13,2),0);
      sAcrescimosNaoFiscais                                 := Copy(Dados,829,14);
      DadosUltimaReducao.AcrescimosNaoFiscais               := StrToCurrDef(Copy(sAcrescimosNaoFiscais,1,12)+DecimalSeparator+Copy(sAcrescimosNaoFiscais,13,2),0);
      sAliquotas                                            := Copy(Dados,843,80);
      sDataMovimento                                        := Copy(Dados,1,8);

      //Converta para data
      DadosUltimaReducao.DataMovimento := StrToDateDef(Copy(sDataMovimento,1,2) + '/' +
                                                       Copy(sDataMovimento,3,2) + '/' +
                                                       Copy(sDataMovimento,5,4),0);

      //Se não houver data da último movimento retorna
      //Modo redução = 99
      If ( DadosUltimaReducao.DataMovimento = 0 ) Then begin
         DadosUltimaReducao.ModoReducao := '99';
         Exit;
      End;

      //Monta as Aliquotas
      sValorAliquota[01] := Copy(sTributos,1,14);
      sValorAliquota[02] := Copy(sTributos,15,14);
      sValorAliquota[03] := Copy(sTributos,29,14);
      sValorAliquota[04] := Copy(sTributos,43,14);
      sValorAliquota[05] := Copy(sTributos,57,14);
      sValorAliquota[06] := Copy(sTributos,71,14);
      sValorAliquota[07] := Copy(sTributos,85,14);
      sValorAliquota[08] := Copy(sTributos,99,14);
      sValorAliquota[09] := Copy(sTributos,113,14);
      sValorAliquota[10] := Copy(sTributos,127,14);
      sValorAliquota[11] := Copy(sTributos,141,14);
      sValorAliquota[12] := Copy(sTributos,155,14);
      sValorAliquota[13] := Copy(sTributos,169,14);
      sValorAliquota[14] := Copy(sTributos,183,14);
      sValorAliquota[15] := Copy(sTributos,197,14);
      sValorAliquota[16] := Copy(sTributos,211,14);

      DadosUltimaReducao.Tributos[1].Aliquota := StrToCurrDef(Copy(sAliquotas,2,2)+DecimalSeparator+Copy(sAliquotas,4,2),0);
      DadosUltimaReducao.Tributos[1].ValorTributado := StrToCurrDef(Copy(sValorAliquota[1],1,12)+DecimalSeparator+Copy(sValorAliquota[1],13,2),0);
      DadosUltimaReducao.Tributos[2].Aliquota := StrToCurrDef(Copy(sAliquotas,7,2)+DecimalSeparator+Copy(sAliquotas,9,2),0);
      DadosUltimaReducao.Tributos[2].ValorTributado := StrToCurrDef(Copy(sValorAliquota[2],1,12)+DecimalSeparator+Copy(sValorAliquota[2],13,2),0);
      DadosUltimaReducao.Tributos[3].Aliquota := StrToCurrDef(Copy(sAliquotas,12,2)+DecimalSeparator+Copy(sAliquotas,14,2),0);
      DadosUltimaReducao.Tributos[3].ValorTributado := StrToCurrDef(Copy(sValorAliquota[3],1,12)+DecimalSeparator+Copy(sValorAliquota[3],13,2),0);
      DadosUltimaReducao.Tributos[4].Aliquota := StrToCurrDef(Copy(sAliquotas,17,2)+DecimalSeparator+Copy(sAliquotas,19,2),0);
      DadosUltimaReducao.Tributos[4].ValorTributado := StrToCurrDef(Copy(sValorAliquota[4],1,12)+DecimalSeparator+Copy(sValorAliquota[4],13,2),0);
      DadosUltimaReducao.Tributos[5].Aliquota := StrToCurrDef(Copy(sAliquotas,22,2)+DecimalSeparator+Copy(sAliquotas,24,2),0);
      DadosUltimaReducao.Tributos[5].ValorTributado := StrToCurrDef(Copy(sValorAliquota[5],1,12)+DecimalSeparator+Copy(sValorAliquota[5],13,2),0);
      DadosUltimaReducao.Tributos[6].Aliquota := StrToCurrDef(Copy(sAliquotas,27,2)+DecimalSeparator+Copy(sAliquotas,29,2),0);
      DadosUltimaReducao.Tributos[6].ValorTributado := StrToCurrDef(Copy(sValorAliquota[6],1,12)+DecimalSeparator+Copy(sValorAliquota[6],13,2),0);
      DadosUltimaReducao.Tributos[7].Aliquota := StrToCurrDef(Copy(sAliquotas,32,2)+DecimalSeparator+Copy(sAliquotas,34,2),0);
      DadosUltimaReducao.Tributos[7].ValorTributado := StrToCurrDef(Copy(sValorAliquota[7],1,12)+DecimalSeparator+Copy(sValorAliquota[7],13,2),0);
      DadosUltimaReducao.Tributos[8].Aliquota := StrToCurrDef(Copy(sAliquotas,37,2)+DecimalSeparator+Copy(sAliquotas,39,2),0);
      DadosUltimaReducao.Tributos[8].ValorTributado := StrToCurrDef(Copy(sValorAliquota[8],1,12)+DecimalSeparator+Copy(sValorAliquota[8],13,2),0);
      DadosUltimaReducao.Tributos[9].Aliquota := StrToCurrDef(Copy(sAliquotas,42,2)+DecimalSeparator+Copy(sAliquotas,44,2),0);
      DadosUltimaReducao.Tributos[9].ValorTributado := StrToCurrDef(Copy(sValorAliquota[9],1,12)+DecimalSeparator+Copy(sValorAliquota[9],13,2),0);
      DadosUltimaReducao.Tributos[10].Aliquota := StrToCurrDef(Copy(sAliquotas,47,2)+DecimalSeparator+Copy(sAliquotas,49,2),0);
      DadosUltimaReducao.Tributos[10].ValorTributado := StrToCurrDef(Copy(sValorAliquota[10],1,12)+DecimalSeparator+Copy(sValorAliquota[10],13,2),0);
      DadosUltimaReducao.Tributos[11].Aliquota := StrToCurrDef(Copy(sAliquotas,52,2)+DecimalSeparator+Copy(sAliquotas,54,2),0);
      DadosUltimaReducao.Tributos[11].ValorTributado := StrToCurrDef(Copy(sValorAliquota[11],1,12)+DecimalSeparator+Copy(sValorAliquota[11],13,2),0);
      DadosUltimaReducao.Tributos[12].Aliquota := StrToCurrDef(Copy(sAliquotas,57,2)+DecimalSeparator+Copy(sAliquotas,59,2),0);
      DadosUltimaReducao.Tributos[12].ValorTributado := StrToCurrDef(Copy(sValorAliquota[12],1,12)+DecimalSeparator+Copy(sValorAliquota[12],13,2),0);
      DadosUltimaReducao.Tributos[13].Aliquota := StrToCurrDef(Copy(sAliquotas,62,2)+DecimalSeparator+Copy(sAliquotas,64,2),0);
      DadosUltimaReducao.Tributos[13].ValorTributado := StrToCurrDef(Copy(sValorAliquota[13],1,12)+DecimalSeparator+Copy(sValorAliquota[13],13,2),0);
      DadosUltimaReducao.Tributos[14].Aliquota := StrToCurrDef(Copy(sAliquotas,67,2)+DecimalSeparator+Copy(sAliquotas,69,2),0);
      DadosUltimaReducao.Tributos[14].ValorTributado := StrToCurrDef(Copy(sValorAliquota[14],1,12)+DecimalSeparator+Copy(sValorAliquota[14],13,2),0);
      DadosUltimaReducao.Tributos[15].Aliquota := StrToCurrDef(Copy(sAliquotas,72,2)+DecimalSeparator+Copy(sAliquotas,74,2),0);
      DadosUltimaReducao.Tributos[15].ValorTributado := StrToCurrDef(Copy(sValorAliquota[15],1,12)+DecimalSeparator+Copy(sValorAliquota[15],13,2),0);
      DadosUltimaReducao.Tributos[16].Aliquota := StrToCurrDef(Copy(sAliquotas,77,2)+DecimalSeparator+Copy(sAliquotas,79,2),0);
      DadosUltimaReducao.Tributos[16].ValorTributado := StrToCurrDef(Copy(sValorAliquota[16],1,12)+DecimalSeparator+Copy(sValorAliquota[16],13,2),0);
   End;
end;

///////////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para imprimir a leitura da memória fiscal por periodo de data
//
//Parametros:
//            dInicio - Data de inicio do periodo
//            dFinal - Data final do período
//            sTipo = S - Impressão simplificada
//            sTipo = C - Impressão completa
//
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////////////////////
Function Imprime_Leitura_Memoria_Fiscal_Data_MFD(dInicio,dFinal:TDateTime;
                                                 sTipo:String;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////////////////////
Var sInicio,sFinal:String;
    Retorno:Integer;
begin
   sInicio := FormatDateTime('dd/MM/yy',dInicio);
   sFinal := FormatDateTime('dd/MM/yy',dFinal);

   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_LeituraMemoriaFiscalDataMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_LeituraMemoriaFiscalDataMFD(sInicio,sFinal,sTipo);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_LeituraMemoriaFiscalDataMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;
end;

///////////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para salvar a leitura da memória fiscal por periodo de data em arquivo
// texto
//
//Parametros:
//            dInicio - Data de inicio do periodo
//            dFinal - Data final do período
//            sTipo = S - Impressão simplificada
//            sTipo = C - Impressão completa
//
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////////////////////
Function Salvar_Leitura_Memoria_Fiscal_Data_MFD(dInicio,dFinal:TDateTime;
                                                sTipo:String;
                                                sLocal:String;Var Erro:String):Boolean;
///////////////////////////////////////////////////////////////////////////////////////
Var sInicio,sFinal:String;
    Retorno:Integer;
begin
   sInicio := FormatDateTime('dd/MM/yy',dInicio);
   sFinal := FormatDateTime('dd/MM/yy',dFinal);

   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_LeituraMemoriaFiscalSerialDataMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;

      If FileExists(LocalRetorno + 'Retorno.txt') Then begin

      End else begin
         Erro := 'Arquivo de retorno não encontrado!!!';
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_LeituraMemoriaFiscalSerialDataMFD(sInicio,sFinal,sTipo);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;

      If FileExists(LocalRetorno + 'Retorno.txt') Then begin

      End else begin
         Erro := 'Arquivo de retorno não encontrado!!!';
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_LeituraMemoriaFiscalSerialDataMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;

      If FileExists(LocalRetorno + 'Retorno.txt') Then begin

      End else begin
         Erro := 'Arquivo de retorno não encontrado!!!';
         Result := False;
      End;
   End;
end;

////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para imprimir a memória fiscal por intervalo de redução
//
//Autor: João Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////////
Function Imprime_Leitura_Memoria_Fiscal_Reducao_MFD(sInicio,sFinal,sTipo:String;
                                                    Var Erro:String):Boolean;
////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
begin
   Result := True;
   If ( Trim(sInicio) = '' ) Or
         ( Trim(sFinal) = '' ) Then begin
      Result := False;
      Erro := 'Intervalo de redução inválido!!!';
      exit;
   End;

   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_LeituraMemoriaFiscalReducaoMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_LeituraMemoriaFiscalReducaoMFD(sInicio,sFinal,sTipo);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_LeituraMemoriaFiscalReducaoMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;
   End;

end;

//////////////////////////////////////////////////////////////////////////////////////////
//Função Utilizada para salvar a leitura da memória fiscal por intervalo de redução em arquivo
// texto
//
//Parametros:
//            sInicio - Numero inicial da redução
//            sFinal - Numero final da redução
//            sTipo = S - Impressão simplificada
//            sTipo = C - Impressão completa
//
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////////////////////////////////////////
Function Salvar_Leitura_Memoria_Fiscal_Reducao_MFD(sInicio,sFinal:String;
                                                   sTipo:String;
                                                   sLocal:String;Var Erro:String):Boolean;
//////////////////////////////////////////////////////////////////////////////////////////
Var Retorno:Integer;
begin
   Result := True;
   If ( TipoECF = teBematech ) Then begin
      Retorno := Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Bematech_Erros(Retorno);
         Result := False;
      End;

      If FileExists(LocalRetorno + 'Retorno.txt') Then begin

      End else begin
         Erro := 'Arquivo de retorno não encontrado!!!';
         Result := False;
      End;
   End else If ( TipoECF = teSweda ) Then begin
      Retorno := Sweda.ECF_LeituraMemoriaFiscalSerialReducaoMFD(sInicio,sFinal,sTipo);
      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Sweda.ECF_Erros(Retorno);
         Result := False;
      End;

      If FileExists(LocalRetorno + 'Retorno.txt') Then begin

      End else begin
         Erro := 'Arquivo de retorno não encontrado!!!';
         Result := False;
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Retorno := Daruma_FI_LeituraMemoriaFiscalSerialReducaoMFD(sInicio,sFinal,sTipo);

      If Retorno_ECF() Then begin
         Erro := 'Comando não executado!!!';
         Result := False;
      End;

      If ( Retorno <= 0 ) Then begin
         Erro := Daruma_FI_Erros(Retorno);
         Result := False;
      End;

      If FileExists(LocalRetorno + 'Retorno.txt') Then begin

      End else begin
         Erro := 'Arquivo de retorno não encontrado!!!';
         Result := False;
      End;
   End;
end;


///////////////////////////////////////
//Função Utilizada para verifica e fechar documento não fiscal aberto
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////
Procedure VerificaFechaNaoFiscalAberto;
///////////////////////////////////////
Var sTipo:String;
begin
   If ( TipoECF = teSweda ) Then begin
      //Se o relatório gerencial estiver aberto fecha
      sTipo := #0; SetLength(sTipo,1);
      Sweda.ECF_StatusRelatorioGerencial(sTipo);
      If ( sTipo = '1' ) Then begin
         Sweda.ECF_FechaRelatorioGerencial();
      End;
   End else If ( TipoECF = teDaruma ) Then begin
      Daruma_FI_FechaRelatorioGerencial();
   End;
end;

end.

