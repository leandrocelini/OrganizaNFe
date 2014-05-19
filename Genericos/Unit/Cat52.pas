unit Cat52;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes;

//------------------------------------------------------------------------------
// REGISTRO TIPO E00 � IDENTIFICA��O DA SOFTWARE HOUSE

type                            // N�  Tam. Posi��o    Tp Denomina��o do Campo     Conte�do
  TCat52E00 = record            // --- --- ----------  -- ------------------------ ------------------------------------------------------------------------
      Tipo             :string; // 1   3   1   -  3    X  Tipo                     "E00"
      NumeroFabricacao :string; // 2   20  4   -  23   X  N�mero de fabrica��o     N�mero de fabrica��o do ECF
      MfAdicional      :string; // 3   1   24  -  24   X  MF adicional             Letra indicativa de MF adicional
      NumeroUsuario    :string; // 4   2   25  -  26   N  N�mero do usu�rio        N�mero de ordem do usu�rio do ECF
      TipoECF          :string; // 5   7   27  -  33   X  Tipo de ECF              Tipo de ECF
      MarcaECF         :string; // 6   20  34  -  53   X  Marca do ECF             Marca do ECF
      Modelo           :string; // 7   20  54  -  73   X  Modelo                   Modelo do ECF
      COO              :string; // 8   6   74  -  79   N  COO                      N� do Contador de Ordem de Opera��o relativo � troca de Aplicativo
      NumeroAplicativo :string; // 9   2   80  -  81   N  N�mero do Aplicativo     N�mero de Ordem do Aplicativo
      CNPJ_CPF         :string; // 10  14  82  -  95   N  CNPJ/CPF:                CNPJ/CPF da Software House ou Desenvolvedor Aut�nomo
      IE               :string; // 11  14  96  -  109  N  I.E:                     I.E: da Software House
      IM               :string; // 12  14  110 -  123  N  I.M:                     I.M: da Software House
      NomeSoftwareHouse:string; // 13  40  124 -  163  X  Nome da Software House   Nome comercial (raz�o social / denomina��o) do Software House
      NomeAplicativo   :string; // 14  40  164 -  203  X  Nome do Aplicativo       Nome do Aplicativo
      VersaoAplicativo :string; // 15  10  204 -  213  X  Vers�o do Aplicativo     Vers�o do Aplicativo
      Linha01          :string; // 16  42  214 -  255  X  Linha 01                 Dados do Programa Aplicativo
      Linha02          :string; // 17  42  256 -  297  X  Linha 02                 Dados do Programa Aplicativo
   end;

//------------------------------------------------------------------------------
// REGISTRO TIPO E01 - IDENTIFICA��O DO ECF

type                            // N�  Tam. Posi��o    Tp Denomina��o do Campo     Conte�do
  TCat52E01 = record            // --- ---- ---------- -- ------------------------ ------------------------------------------------------------------------
      TipoRegistro     :string; // 1   3    1    - 3   X  Tipo do registro         "E01"
      NumeroFabricacao :string; // 2   20   4    - 23  X  N�mero de fabrica��o     N� de fabrica��o do ECF
      MfAdicional      :string; // 3   1    24   - 24  X  MF adicional             Letra indicativa de MF adicional
      TipoECF          :string; // 4   7    25   - 31  X  Tipo do ECF              Tipo do ECF
      Marca            :string; // 5   20   32   - 51  X  Marca                    Marca do ECF
      Modelo           :string; // 6   20   52   - 71  X  Modelo                   Modelo do ECF
      VersaoSB         :string; // 7   10   72   - 81  X  Vers�o do SB             Vers�o atual do Software B�sico do ECF gravada na MF
      DataSB           :string; // 8   8    82   - 89  D  Data da grava��o do SB   Data da grava��o na MF da vers�o do SB a que se refere o campo 07
      HoraSB           :string; // 9   6    90   - 95  H  Hora da grava��o do SB   Hora da grava��o na MF da vers�o do SB a que se refere o campo 07
      NumeroECF        :string; // 10  3    96   - 98  N  N�mero Seq�encial do ECF N� de ordem seq�encial do ECF no estabelecimento usu�rio
      CnpjUsuario      :string; // 11  14   99   - 112 N  CNPJ do usu�rio          CNPJ do estabelecimento usu�rio do ECF
      ComandoGeracao   :string; // 12  3    113  - 115 X  Comando de gera��o       C�digo do comando utilizado para gerar o arquivo, conforme tabela abaixo
      CrzInicial       :string; // 13  6    116  - 121 N  CRZ inicial              Contador de Redu��es Z do in�cio do per�odo a ser capturado
      CrzFinal         :string; // 14  6    122  - 127 N  CRZ final                Contador de Redu��es Z do final do per�odo a ser capturado
      DataInicial      :string; // 15  8    128  - 135 D  Data Inicial             Data do In�cio do per�odo a ser capturado
      DataFinal        :string; // 16  8    136  - 143 D  Data final               Data do fim do per�odo a ser capturado
      VersaoBiblioteca :string; // 17  8    144  - 151 X  Vers�o da biblioteca     Vers�o da biblioteca do fabricante do ECF geradora deste arquivo
      VersaoAtoCOTEPE  :string; // 18  15   152  - 166 X  Vers�o do Ato/COTEPE     Vers�o do Ato/COTEPE
  end;

//------------------------------------------------------------------------------
// REGISTRO TIPO E02 � IDENTIFICA��O DO ATUAL CONTRIBUINTE USU�RIO DO ECF

type                            // N�  Tam. Posi��o    Tp Denomina��o do Campo     Conte�do
  TCat52E02 = record            // --- ---- ---------- -- ------------------------ ------------------------------------------------------------------------
      Tipo             :string; // 1   3    1   -  3   X  Tipo                     "E02"
      NumeroFabricacao :string; // 2   20   4   -  23  X  N�mero de fabrica��o     N� de fabrica��o do ECF
      MfAdicional      :string; // 3   1    24  -  24  X  MF adicional             Letra indicativa de MF adicional
      Modelo           :string; // 4   20   25  -  44  X  Modelo                   Modelo do ECF
      CNPJ             :string; // 5   14   45  -  58  N  CNPJ                     CNPJ do estabelecimento usu�rio do ECF
      IE               :string; // 6   14   59  -  72  X  Inscri��o Estadual       Inscri��o Estadual do estabelecimento usu�rio
      NomeContribuinte :string; // 7   40   73  -  112 X  Nome do Contribuinte     Nome comercial (raz�o social / denomina��o) do contribuinte usu�rio do ECF
      Endereco         :string; // 8   120  113 -  232 X  Endere�o                 Endere�o do estabelecimento usu�rio do ECF
      DataCadastro     :string; // 9   8    233 -  240 D  Data do cadastro         Data do cadastro do usu�rio no ECF
      HoraCadastro     :string; // 10  6    241 -  246 H  Hora do cadastro         Hora do cadastro do usu�rio no ECF
      CRO              :string; // 11  6    247 -  252 N  CRO                      Valor do CRO relativo ao cadastro do usu�rio no ECF  (Contador de Rein�cio de Opera��o)
      GT               :string; // 12  18   253 -  270 N  GT                       Valor acumulado no GT, com duas casas decimais. (Totalizador Geral)
      NumeroUsuario    :string; // 13  2    271 -  272 N  N�mero do usu�rio        N� de ordem do usu�rio do ECF
   end;

//------------------------------------------------------------------------------

function GetNumCat52(ch:Char):Integer;
function GetCabecalhoCat52(arquivo:string; var e00:TCat52E00; var e01:TCat52E01; var e02:TCat52E02):Boolean;

//------------------------------------------------------------------------------

implementation

//------------------------------------------------------------------------------

function GetNumCat52(ch:Char):Integer;
var digs:string;
var x:integer;
begin
   digs := '123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   Result := 0;
   for x := 1 to 35 do begin
      if ( ch = digs[x] ) then begin
         Result := x;
      end;
   end;
end;

//------------------------------------------------------------------------------

function GetCabecalhoCat52(arquivo:string; var e00:TCat52E00; var e01:TCat52E01; var e02:TCat52E02):Boolean;
var arq:TStringList;
    x:integer;
    linha,NomeArq:string;
begin
   Result := False;

   NomeArq := ExtractFileName(arquivo);

   //Se no nome do arquivo for maior que 8 char ignora
   If ( Length(NomeArq) <> 12 ) then begin
      Exit;
   End;

   if FileExists(arquivo) then begin

      arq := TStringList.Create;
      arq.LoadFromFile(arquivo);

      for x := 0 to arq.Count - 1 do begin

         linha := arq[x];

         //------------------------------------------------------------------------
         // REGISTRO TIPO E00 � IDENTIFICA��O DA SOFTWARE HOUSE
         if ( copy(linha,1,3) = 'E00' ) then begin

            e00.Tipo             := copy(linha, 1   , 3   ); // 1
            e00.NumeroFabricacao := copy(linha, 4   , 20  ); // 2
            e00.MfAdicional      := copy(linha, 24  , 1   ); // 3
            e00.NumeroUsuario    := copy(linha, 25  , 2   ); // 4
            e00.TipoECF          := copy(linha, 27  , 7   ); // 5
            e00.MarcaECF         := copy(linha, 34  , 20  ); // 6
            e00.Modelo           := copy(linha, 54  , 20  ); // 7
            e00.COO              := copy(linha, 74  , 6   ); // 8
            e00.NumeroAplicativo := copy(linha, 80  , 2   ); // 9
            e00.CNPJ_CPF         := copy(linha, 82  , 14  ); // 10
            e00.IE               := copy(linha, 96  , 14  ); // 11
            e00.IM               := copy(linha, 110 , 14  ); // 12
            e00.NomeSoftwareHouse:= copy(linha, 124 , 40  ); // 13
            e00.NomeAplicativo   := copy(linha, 164 , 40  ); // 14
            e00.VersaoAplicativo := copy(linha, 204 , 10  ); // 15
            e00.Linha01          := copy(linha, 214 , 42  ); // 16
            e00.Linha02          := copy(linha, 256 , 42  ); // 17

            Result := True;

         //------------------------------------------------------------------------
         // REGISTRO TIPO E01 - IDENTIFICA��O DO ECF
         end else if ( copy(linha,1,3) = 'E01' ) then begin

            e01.TipoRegistro     := copy(linha, 1   , 3   ); // 1
            e01.NumeroFabricacao := copy(linha, 4   , 20  ); // 2
            e01.MfAdicional      := copy(linha, 24  , 1   ); // 3
            e01.TipoECF          := copy(linha, 25  , 7   ); // 4
            e01.Marca            := copy(linha, 32  , 20  ); // 5
            e01.Modelo           := copy(linha, 52  , 20  ); // 6
            e01.VersaoSB         := copy(linha, 72  , 10  ); // 7
            e01.DataSB           := copy(linha, 82  , 8   ); // 8
            e01.HoraSB           := copy(linha, 90  , 6   ); // 9
            e01.NumeroECF        := copy(linha, 96  , 3   ); // 10
            e01.CnpjUsuario      := copy(linha, 99  , 14  ); // 11
            e01.ComandoGeracao   := copy(linha, 113 , 3   ); // 12
            e01.CrzInicial       := copy(linha, 116 , 6   ); // 13
            e01.CrzFinal         := copy(linha, 122 , 6   ); // 14
            e01.DataInicial      := copy(linha, 128 , 8   ); // 15
            e01.DataFinal        := copy(linha, 136 , 8   ); // 16
            e01.VersaoBiblioteca := copy(linha, 144 , 8   ); // 17
            e01.VersaoAtoCOTEPE  := copy(linha, 152 , 15  ); // 18

            Result := True;

         //------------------------------------------------------------------------
         // REGISTRO TIPO E02 � IDENTIFICA��O DO ATUAL CONTRIBUINTE USU�RIO DO ECF

         end else if ( copy(linha,1,3) = 'E02' ) then begin

            e02.Tipo             := copy(linha, 1   , 3   ); // 1
            e02.NumeroFabricacao := copy(linha, 4   , 20  ); // 2
            e02.MfAdicional      := copy(linha, 24  , 1   ); // 3
            e02.Modelo           := copy(linha, 25  , 20  ); // 4
            e02.CNPJ             := copy(linha, 45  , 14  ); // 5
            e02.IE               := copy(linha, 59  , 14  ); // 6
            e02.NomeContribuinte := copy(linha, 73  , 40  ); // 7
            e02.Endereco         := copy(linha, 113 , 120 ); // 8
            e02.DataCadastro     := copy(linha, 233 , 8   ); // 9
            e02.HoraCadastro     := copy(linha, 241 , 6   ); // 10
            e02.CRO              := copy(linha, 247 , 6   ); // 11
            e02.GT               := copy(linha, 253 , 18  ); // 12
            e02.NumeroUsuario    := copy(linha, 271 , 2   ); // 13

            Result := True;

         end;

      end;

      FreeAndNil(arq);
   end;
end;

//------------------------------------------------------------------------------

end.
