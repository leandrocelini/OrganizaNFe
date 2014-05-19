//////////////////////////////////////////////////////////////////////////
// Classe utilizada para gerar códigos de boletos
//
// Desenvolvido Por João Paulo Francisco Bellucci
//
// Data: 21/11/2008
//////////////////////////////////////////////////////////////////////////

unit Boletos;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Funcoes, DB;

type
  TNomeBanco = (nbItau,nbBradesco,nbBrasil,nbNossaCaixa,nbSantander);
  TLibBoletos = class
  private
    FNomeBanco:TNomeBanco;
    FAgencia:String;
    FBanco:String;
    FConta:String;
    FCarteira:String;
    FNumeroConvenio:String;
    FCodigoCedente: String;
    FValor:Currency;
    FVencimento:TDate;
    FNossoNumero: Largeint;
    { Private declarations }
  protected
    procedure SetNomeBanco(const NomeBanco:TNomeBanco);
    Function Retorno_NossoNumero_Itau:String;
    Function Retorno_Campo1_Itau: String;
    Function Retorno_Campo2_Itau: String;
    Function Retorno_Campo3_Itau: String;
    Function Retorno_Campo4_Itau: String;
    Function CodigoDeBarras_Itau: String;
    function DataVencimento: string;
    Function TiraPontoeVirgula:String;
    Function Retorno_Campo5: String;
    Function Retorno_NossoNumero_Bradesco:String;
    Function Retorno_Campo1_Bradesco: String;
    Function Retorno_Campo2_Bradesco: String;
    Function Retorno_Campo3_Bradesco: String;
    Function Retorno_Campo4_Bradesco: String;
    Function CodigoDeBarras_Bradesco: String;
    Function Retorno_NossoNumero_Brasil:String;
    Function Retorno_Campo1_Brasil: String;
    Function Retorno_Campo2_Brasil: String;
    Function Retorno_Campo3_Brasil: String;
    Function Retorno_Campo4_Brasil: String;
    Function CodigoDeBarras_Brasil: String;
    Function Retorno_NossoNumero_NossaCaixa:String;
    Function Retorno_Campo1_NossaCaixa: String;
    Function Retorno_Campo2_NossaCaixa: String;
    Function Retorno_Campo3_NossaCaixa: String;
    Function Retorno_Campo4_NossaCaixa: String;
    Function CodigoDeBarras_NossaCaixa: String;
    Function Asbace1_NossaCaixa: String;
    Function Asbace2_NossaCaixa: String;
    Function Retorno_NossoNumero_Santander:String;
    Function Retorno_Campo1_Santander: String;
    Function Retorno_Campo2_Santander: String;
    Function Retorno_Campo3_Santander: String;
    Function Retorno_Campo4_Santander: String;
    Function CodigoDeBarras_Santander: String;

    { Protected declarations }
  public
    constructor Create;
    destructor  Destroy;override;

    { Public declarations }
  published
    property NomeBanco: TNomeBanco read FNomeBanco write SetNomeBanco default nbItau;
    property Agencia:String read FAgencia write FAgencia;
    property Conta:String read FConta write FConta;
    property Carteira:String read FCarteira write FCarteira;
    property NumeroConvenio:String read FNumeroConvenio write FNumeroConvenio;
    property CodigoCedente: String read FCodigoCedente write FCodigoCedente;
    property Valor:Currency read FValor write FValor;
    property Vencimento:TDate read FVencimento write FVencimento;
    property NossoNumero:Largeint read FNossoNumero write FNossoNumero;
    function RetornaNossoNumero:String;
    function RetornaCodigoBarras:String;
    function RetornaCodigoDigitado:String;
     { Published declarations }
  end;

implementation

///////////////////////////////
//Construtor da class Boletos
///////////////////////////////
constructor TLibBoletos.Create;
///////////////////////////////
begin
    inherited;

    Agencia := '';
    Conta := '';
end;

///////////////////////////////
destructor TLibBoletos.Destroy;
///////////////////////////////
begin
    inherited;
end;

///////////////////////////////////
//Procedimento utilizado para setar o nome do banco
///////////////////////////////////
procedure TLibBoletos.SetNomeBanco(const NomeBanco:TNomeBanco);
///////////////////////////////////
begin
   If ( NomeBanco = nbItau ) Then begin
      FBanco := '341-7';
      FNomeBanco := nbItau;
   End else if ( NomeBanco = nbBradesco) then begin
      FBanco:= '237-2';
      FNomeBanco := nbBradesco;
   End else if ( NomeBanco = nbBrasil) then begin
      FBanco:= '001-9';
      FNomeBanco := nbBrasil;
   End else if ( NomeBanco = nbNossaCaixa) then begin
      FBanco:= '151-1';
      FNomeBanco := nbNossaCaixa;
   End else if ( NomeBanco = nbSantander) then begin
      FBanco:= '033-7';
      FNomeBanco := nbSantander;
   End;

end;

///////////////////////////////////////////////
//Função utilizada para retornar o nosso número referente ao banco
///////////////////////////////////////////////
function TLibBoletos.RetornaNossoNumero:String;
///////////////////////////////////////////////
begin
   If FNomeBanco = nbItau Then begin
      Result := Retorno_NossoNumero_Itau;
   End else If FNomeBanco = nbBradesco Then begin
       Result := Retorno_NossoNumero_Bradesco;
   End else If FNomeBanco = nbBrasil Then begin
       Result := Retorno_NossoNumero_Brasil;
   End else If FNomeBanco = nbNossaCaixa Then begin
       Result := Retorno_NossoNumero_NossaCaixa;
   End else If FNomeBanco = nbSantander Then begin
       Result := Retorno_NossoNumero_Santander;
   End else begin
      Result := '';
   End;
end;

////////////////////////////////////////////////
//Função utilizada para retornar o nosso número referente ao banco
////////////////////////////////////////////////
function TLibBoletos.RetornaCodigoBarras:String;
////////////////////////////////////////////////
begin
   If FNomeBanco = nbItau Then begin
      Result:= CodigoDeBarras_Itau;
   End else If FNomeBanco = nbBradesco Then begin
      Result:= CodigoDeBarras_Bradesco;
   End else If FNomeBanco = nbBrasil Then begin
      Result:= CodigoDeBarras_Brasil;
   End else If FNomeBanco = nbNossaCaixa Then begin
      Result:= CodigoDeBarras_NossaCaixa;
   End else If FNomeBanco = nbSantander Then begin
      Result:= CodigoDeBarras_Santander;
   End else begin
      Result := '';
   End;
end;

//////////////////////////////////////////////////
//Função utilizada para retornar o nosso número referente ao banco
//////////////////////////////////////////////////
function TLibBoletos.RetornaCodigoDigitado:String;
//////////////////////////////////////////////////
begin
   If FNomeBanco = nbItau Then begin
      Result := Retorno_Campo1_Itau + ' ' + Retorno_Campo2_Itau + ' ' +
                Retorno_Campo3_Itau + ' ' + Retorno_Campo4_Itau + ' ' + Retorno_Campo5;
   End else If FNomeBanco = nbBradesco Then begin
       Result := Retorno_Campo1_Bradesco + ' ' + Retorno_Campo2_Bradesco + ' ' +
                 Retorno_Campo3_Bradesco + ' ' + Retorno_Campo4_Bradesco + ' ' + Retorno_Campo5;
   End else If FNomeBanco = nbBrasil Then begin
       Result := Retorno_Campo1_Brasil + ' ' + Retorno_Campo2_Brasil + ' ' +
                 Retorno_Campo3_Brasil + ' ' + Retorno_Campo4_Brasil + ' ' + Retorno_Campo5;
   End else If FNomeBanco = nbNossaCaixa Then begin
       Result := Retorno_Campo1_NossaCaixa + ' ' + Retorno_Campo2_NossaCaixa + ' ' +
                 Retorno_Campo3_NossaCaixa + ' ' + Retorno_Campo4_NossaCaixa + ' ' + Retorno_Campo5;
   End else If FNomeBanco = nbSantander Then begin
       Result := Retorno_Campo1_Santander + ' ' + Retorno_Campo2_Santander + ' ' +
                 Retorno_Campo3_Santander + ' ' + Retorno_Campo4_Santander + ' ' + Retorno_Campo5;
   End else begin
      Result := '';
   End;
end;

Function TLibBoletos.Retorno_NossoNumero_Itau:String;
var
A:array[1..20] of integer;
B:array[1..20] of integer;
C:Array[1..20] of integer;

i, resultado,resultado2,resto,e,f: integer;
numero,dac,dac2,d,SConta,sNossoNumero:string;
begin

   FAgencia:= Format('%4.4d',[strtoint(FAgencia)]);
   SConta:=  Format('%5.5d',[strtoint(copy(FConta,1,5))]);
   FCarteira:= Format('%3.3d',[strtoint(FCarteira)]);
   sNossoNumero:= Format('%8.8d',[FNossoNumero]);
   numero:=  Fagencia + SConta + Fcarteira + sNossoNumero;

  for i:= 1 to 20 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;
 B[11]:= 1;
 B[12]:= 2;
 B[13]:= 1;
 B[14]:= 2;
 B[15]:= 1;
 B[16]:= 2;
 B[17]:= 1;
 B[18]:= 2;
 B[19]:= 1;
 B[20]:= 2;

 for i:= 1 to 20 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
 end;
 resultado:=0;
 for i:= 1 to 20 do begin
   resultado:= resultado + C[i];
 end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   Fcarteira + '/' + sNossoNumero + '-' + dac;
  result:= dac2;

end;

Function TLibBoletos.Retorno_Campo1_Itau: String;
var
A:array[1..9] of integer;
B:array[1..9] of integer;
C:Array[1..9] of integer;
numero,d,dac,dac2,campo1,sNossoNumero: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sNossoNumero:= Format('%8.8d',[FNossoNumero]);
Fcarteira:= Format('%3.3d',[strtoint(Fcarteira)]);
numero := copy(Fbanco,1,3) + '9' + Fcarteira + copy(sNossoNumero,1,2);

  for i:= 1 to 9 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 2;
 B[02]:= 1;
 B[03]:= 2;
 B[04]:= 1;
 B[05]:= 2;
 B[06]:= 1;
 B[07]:= 2;
 B[08]:= 1;
 B[09]:= 2;

  for i:= 1 to 9 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;
  
  resultado:=0;
  for i:= 1 to 9 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo1:= copy(dac2,1,5) + '.' + copy(dac2,6,5);
  result:= campo1;
end;

Function TLibBoletos.Retorno_Campo2_Itau: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,d,dac,dac2,sNossoNumero,dacNossoNumero,campo2: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sNossoNumero:= Format('%8.8d',[Fnossonumero]);
dacNossoNumero:= Retorno_NossoNumero_Itau;
numero := copy(sNossoNumero,3,8) + copy(dacnossonumero,14,1) + copy(agencia,1,3);

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo2:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo2;

end;

Function TLibBoletos.Retorno_Campo3_Itau: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,d,dac,dac2,campo3,sConta: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sConta:= FConta;
numero := copy(Fagencia,4,1) + copy(SConta,1,5) +  copy(SConta,7,1) + '000';

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo3:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo3;
end;

Function TLibBoletos.Retorno_Campo4_Itau: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,dacNossoNumero,fatorvencimento,Sconta, valor: String;
i,resultado,resultado2,resto: integer;
begin
agencia:= Format('%4.4d',[strtoint(Fagencia)]);
dacNossoNumero:= Retorno_NossoNumero_Itau;
SConta:= FConta;
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;
numero := copy(Fbanco,1,3) + '9' + fatorvencimento + valor +
          copy(dacnossonumero,1,3) + copy(dacnossonumero,5,8) + copy(dacnossonumero,14,1) +
          agencia + copy(Sconta,1,5) + copy(Sconta,7,1) + '000';

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) or (resto = 10) or (resto = 11) then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  result:= dac;
end;

Function TLibBoletos.Retorno_Campo5: String;
var
fatorvencimento,valor,campo5: string;
begin
 fatorvencimento:= DataVencimento;
 valor:=TiraPontoeVirgula;
 campo5:= fatorvencimento + valor;
 result:= campo5;

end;

Function TLibBoletos.CodigoDeBarras_Itau: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,codigobarras,fatorvencimento,dacNossoNumero,sAgencia, SConta,valor: string;
i,resultado,resultado2,resto: integer;
begin
sAgencia:= copy(Fagencia,1,4);
sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
SConta:= FConta;
dacNossoNumero:= Retorno_NossoNumero_Itau;
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;

numero := copy(Fbanco,1,3) + '9' + fatorvencimento + valor +
          copy(dacnossonumero,1,3) + copy(dacnossonumero,5,8) + copy(dacnossonumero,14,1) +
          agencia + copy(Sconta,1,5) + copy(Sconta,7,1) + '000';

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) or (resto = 10) or (resto = 11) then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  codigobarras:= copy(numero,1,4) + dac + copy(numero,5,39);

  result:= codigobarras;
end;

function TLibBoletos.DataVencimento: string;
var
database: tdatetime;
valor: real;
fator,a: string;
begin
    database:= strtodate('07/10/1997');
    valor:= Fvencimento - database;
    a:= floattostr(valor);
    fator := Format('%4.4d',[strtoint(a)]);
    result:= fator;

end;

Function TLibBoletos.TiraPontoeVirgula:String;
var
Temp_01,sTexto : string;
Temp_03, conta: Integer;
begin
sTexto:= formatFloat('###,###,##0.00',FValor);
//sTexto:= floattostr(FValor);
Conta := 0;
Temp_03 := length(sTexto);
while conta < temp_03 do
begin
Conta := Conta + 1;
Temp_01 := Copy(Stexto,conta,1);
if Temp_01 = '.' then
begin
sTexto := Copy(sTexto,1,(Conta - 1))+ Copy(sTexto,(Conta + 1),(Temp_03 - Conta));
end;
if Temp_01 = ',' then
begin
sTexto := Copy(sTexto,1,(Conta - 1))+ Copy(sTexto,(Conta + 1),(Temp_03 - Conta));
end;
end;
sTexto:= Format('%10.10d',[strtoint(sTexto)]);
Result := sTexto;
end;

Function TLibBoletos.Retorno_NossoNumero_Bradesco:String;
var
A:array[1..13] of integer;
B:array[1..13] of integer;
C:Array[1..13] of integer;

i, resultado,resultado2,resto: integer;
numero,dac,dac2,sNossoNumero:string;
begin

   FCarteira:= Format('%2.2d',[strtoint(FCarteira)]);
   sNossoNumero:= Format('%11.11d',[FNossoNumero]);
   numero:=   Fcarteira + sNossoNumero;

  for i:= 1 to 13 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 2;
 B[02]:= 7;
 B[03]:= 6;
 B[04]:= 5;
 B[05]:= 4;
 B[06]:= 3;
 B[07]:= 2;
 B[08]:= 7;
 B[09]:= 6;
 B[10]:= 5;
 B[11]:= 4;
 B[12]:= 3;
 B[13]:= 2;

 for i:= 1 to 13 do begin
     C[i]:= A[i] * B[i];
 end;
 
 resultado:=0;
 for i:= 1 to 13 do begin
   resultado:= resultado + C[i];
 end;

  resto:= resultado mod 11;
  if resto = 1 then begin
     dac:= 'P';
  end else if resto = 0 then begin
      dac:= '0';
  end else begin
  resultado2:= 11 - resto;
  dac:= inttostr(resultado2);
  end;

  dac2:=   carteira + '/' + sNossoNumero + '-' + dac;
  result:= dac2;

end;

Function TLibBoletos.Retorno_Campo1_Bradesco: String;
var
A:array[1..9] of integer;
B:array[1..9] of integer;
C:Array[1..9] of integer;
numero,d,dac,dac2,campo1,sAgencia: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sAgencia:= copy(Right(Fagencia,6),1,4);
sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
numero := copy(Fbanco,1,3) + '9' + sAgencia + '0';

  for i:= 1 to 9 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 2;
 B[02]:= 1;
 B[03]:= 2;
 B[04]:= 1;
 B[05]:= 2;
 B[06]:= 1;
 B[07]:= 2;
 B[08]:= 1;
 B[09]:= 2;

  for i:= 1 to 9 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;
  
  resultado:=0;
  for i:= 1 to 9 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo1:= copy(dac2,1,5) + '.' + copy(dac2,6,5);
  result:= campo1;
end;

Function TLibBoletos.Retorno_Campo2_Bradesco: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,d,dac,dac2,sNossoNumero,dacNossoNumero,campo2: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sNossoNumero:= Format('%11.11d',[Fnossonumero]);
dacNossoNumero:= Retorno_NossoNumero_Bradesco;
numero := copy(dacnossonumero,2,1) + copy(sNossoNumero,1,9)  ;

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo2:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo2;

end;

Function TLibBoletos.Retorno_Campo3_Bradesco: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,d,dac,dac2,campo3,sConta,sNossoNumero: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sConta:= trim(FConta);
delete(SConta,length(SConta),1);
delete(SConta,length(SConta),1);
Sconta:= Format('%7.7d',[strtoint(SConta)]);
sNossoNumero:= Format('%11.11d',[Fnossonumero]);
numero := copy(sNossoNumero,10,2) + copy(SConta,1,7) + '0';

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo3:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo3;
end;

Function TLibBoletos.Retorno_Campo4_Bradesco: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,sNossoNumero,fatorvencimento,Sconta,Sagencia, valor: String;
i,resultado,resultado2,resto: integer;
begin
sAgencia:= copy(Right(Fagencia,6),1,4);
sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
sNossoNumero:= Format('%11.11d',[FNossoNumero]);
SConta:= trim(FConta);
delete(SConta,length(SConta),1);
delete(SConta,length(SConta),1);
Sconta:= Format('%7.7d',[strtoint(SConta)]);
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;

    numero:= copy(Fbanco,1,3) + '9' + fatorvencimento + valor +
             sAgencia + Fcarteira + sNossoNUmero + copy(SConta,1,7) + '0';

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) or (resto = 10) or (resto = 11) then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  result:= dac;
end;

Function TLibBoletos.CodigoDeBarras_Bradesco: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,sNossoNumero,sCarteira,codigobarras,sAgencia,fatorvencimento,Sconta, valor: String;
i,resultado,resultado2,resto: integer;
begin
sAgencia:= copy(Right(Fagencia,6),1,4);
sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
sNossoNumero:= Format('%11.11d',[FNossoNumero]);
SConta:= trim(FConta);
delete(SConta,length(SConta),1);
delete(SConta,length(SConta),1);
Sconta:= Format('%7.7d',[strtoint(SConta)]);
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;
sCarteira:=    Format('%2.2d',[strtoint(Fcarteira)]);

    numero:= copy(Fbanco,1,3) + '9' + fatorvencimento + valor +
             sAgencia + sCarteira + sNossoNUmero + copy(SConta,1,7) + '0';

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) or (resto = 10) or (resto = 11) then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  codigobarras:= copy(numero,1,4) + dac + copy(numero,5,39);

  result:= codigobarras;
end;

Function TLibBoletos.Retorno_NossoNumero_Brasil:String;
var
A:array[1..17] of integer;
B:array[1..17] of integer;
C:Array[1..17] of integer;

i, resultado,resto: integer;
numero,dac,dac2,sNossoNumero,sNumeroConvenio: string;
begin
   sNossoNumero:= inttostr(FNossoNumero);
   sNossoNumero:= Format('%10.10d',[strtoint(sNossoNumero)]);
   sNumeroConvenio:= Format('%7.7d',[strtoint(FNumeroConvenio)]);
   numero:=   sNumeroConvenio + sNossoNumero;

  for i:= 1 to 17 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 9;
 B[02]:= 2;
 B[03]:= 3;
 B[04]:= 4;
 B[05]:= 5;
 B[06]:= 6;
 B[07]:= 7;
 B[08]:= 8;
 B[09]:= 9;
 B[10]:= 2;
 B[11]:= 3;
 B[12]:= 4;
 B[13]:= 5;
 B[14]:= 6;
 B[15]:= 7;
 B[16]:= 8;
 B[17]:= 9;

 for i:= 1 to 17 do begin
     C[i]:= A[i] * B[i];
 end;

 resultado:=0;
 for i:= 1 to 17 do begin
   resultado:= resultado + C[i];
 end;

  resto:= resultado mod 11;
  if resto = 10 then begin
     dac:= 'X';
  end else begin
  dac:= inttostr(resto);
  end;

  dac2:=   sNumeroConvenio + sNossoNumero + '-' + dac;
  result:= dac2;

end;

Function TLibBoletos.Retorno_Campo1_Brasil: String;
var
A:array[1..9] of integer;
B:array[1..9] of integer;
C:Array[1..9] of integer;
numero,d,dac,dac2,campo1: String;
i,e,f,resultado,resultado2,resto: integer;
begin   
numero := copy(Fbanco,1,3) + '9' + '00000';

  for i:= 1 to 9 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 2;
 B[02]:= 1;
 B[03]:= 2;
 B[04]:= 1;
 B[05]:= 2;
 B[06]:= 1;
 B[07]:= 2;
 B[08]:= 1;
 B[09]:= 2;

  for i:= 1 to 9 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;
  
  resultado:=0;
  for i:= 1 to 9 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo1:= copy(dac2,1,5) + '.' + copy(dac2,6,5);
  result:= campo1;
end;

Function TLibBoletos.Retorno_Campo2_Brasil: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,d,dac,dac2,sNossoNumero,sNumeroConvenio,campo2: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sNumeroConvenio:= Format('%7.7d',[strtoint(FNumeroConvenio)]);
sNossoNumero:= Format('%10.10d',[Fnossonumero]);
numero := '0' + sNumeroConvenio + copy(sNossoNumero,1,2)  ;

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo2:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo2;

end;

Function TLibBoletos.Retorno_Campo3_Brasil: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,d,dac,dac2,campo3,sCarteira,sNossoNumero: String;
i,e,f,resultado,resultado2,resto: integer;
begin
sCarteira:= copy(Fcarteira,1,2);
sNossoNumero:= Format('%10.10d',[Fnossonumero]);
numero := copy(sNossoNumero,3,8) + sCarteira;

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  resultado2:= 10 - resto;
  if resultado2 = 10 then begin
     resultado2:= 0;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo3:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo3;
end;

Function TLibBoletos.Retorno_Campo4_Brasil: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,sNossoNumero,sNumeroConvenio,fatorvencimento,Sconta, valor: String;
i,resultado,resultado2,resto,NConvenio: integer;
begin
//sAgencia:= copy(Right(Fagencia,6),1,4);
//sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
sNossoNumero:= Format('%10.10d',[FNossoNumero]);
NConvenio:= strtoint(FNumeroConvenio);
sNumeroConvenio:= Format('%7.7d',[NConvenio]);
SConta:= FConta;
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;

    numero:= copy(Fbanco,1,3) + '9' + fatorvencimento + valor + '000000'
              + sNumeroConvenio + sNossoNUmero + copy(Fcarteira,1,2);

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) or (resto = 10) or (resto = 11) then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  result:= dac;
end;

Function TLibBoletos.CodigoDeBarras_Brasil: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,sNossoNumero,sNumeroConvenio,codigobarras,fatorvencimento,Sconta, valor: String;
i,resultado,resultado2,resto,Nconvenio: integer;
begin
//sAgencia:= copy(Right(Fagencia,6),0,4);
//sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
sNossoNumero:= Format('%10.10d',[FNossoNumero]);
NConvenio:= strtointdef(FNumeroConvenio,0);
sNumeroConvenio:= Format('%7.7d',[NConvenio]);
SConta:= FConta;
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;

    numero:= copy(Fbanco,1,3) + '9' + fatorvencimento + valor + '000000'
              + sNumeroConvenio + sNossoNUmero + copy(Fcarteira,1,2);

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 10) or (resto = 11) then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  codigobarras:= copy(numero,1,4) + dac + copy(numero,5,39);

  result:= codigobarras;
end;

Function TLibBoletos.Retorno_NossoNumero_NossaCaixa:String;
var
A:array[1..23] of integer;
B:array[1..23] of integer;
C:Array[1..23] of integer;

i, resultado,resto: integer;
numero,dac,dac2,sNossoNumero,sConta,multiplicador: string;
begin
   SConta:= trim(FConta);
   delete(SConta,length(SConta),1);
   delete(SConta,length(SConta),1);
   SConta:= copy(right(SConta,7),1,7);
   sConta:=  Format('%7.7d',[strtoint(sConta)]);
   sNossoNumero:= Format('%9.9d',[FNossoNumero]);
   numero:= copy(FAgencia,1,4) +  copy(FConta,1,2) + sConta + copy(Right(FConta,1),1,1) + sNossoNumero;

  for i:= 1 to 23 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '31973197319731319731973';
  for i:=1 to 23 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 23 do begin
      C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 23 do begin
    resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  if resto = 0 then begin
  dac:= '0';
  end else  dac:= inttostr(10 - resto);

  dac2:=  sNossoNumero + '-' + dac;
  result:= dac2;

end;

Function TLibBoletos.Retorno_Campo1_NossaCaixa: String;
var
A:array[1..9] of integer;
B:array[1..9] of integer;
C:Array[1..9] of integer;
numero,dac,dac2,campo1,sNossoNumero: String;
i,resultado,resto: integer;

begin

sNossoNumero:= Format('%9.9d',[FNossoNumero]); //inttostr(FNossoNumero);
numero := copy(Fbanco,1,3) + '9' + '9' + copy(SnossoNumero,2,4);

  for i:= 1 to 9 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 2;
 B[02]:= 1;
 B[03]:= 2;
 B[04]:= 1;
 B[05]:= 2;
 B[06]:= 1;
 B[07]:= 2;
 B[08]:= 1;
 B[09]:= 2;

  for i:= 1 to 9 do begin
     C[i]:= A[i] * B[i];
  end;
  
  resultado:=0;
  for i:= 1 to 9 do begin
   if c[i] > 9 then begin
      c[i]:= c[i] - 9;
   end;
   resultado:= resultado + C[i];
  end;
  resultado:= resultado * 9;
  resto:= resultado mod 10;

  dac:= inttostr(resto);
  dac2:=   numero + dac;
  campo1:= copy(dac2,1,5) + '.' + copy(dac2,6,5);
  result:= campo1;
end;


Function TLibBoletos.Asbace1_NossaCaixa: String;
var
A:array[1..23] of integer;
B:array[1..23] of integer;
C:Array[1..23] of integer;
sNossoNumero,numero,sConta,multiplicador: String;
i,resultado,resto,resultado2: integer;
begin
sNossoNumero:= Format('%9.9d',[FNossoNumero]); //inttostr(FNossoNumero); 
SConta:= trim(FConta);
delete(SConta,length(SConta),1);
delete(SConta,length(SConta),1);
SConta:= copy(right(SConta,6),1,6);

numero := sNossoNumero + copy(FAgencia,1,4) +  copy(FConta,2,1) + sConta + copy(Fbanco,1,3);

  for i:= 1 to 23 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '21212121212121212121212';
  for i:=1 to 23 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 23 do begin
      C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 23 do begin
      if C[i] > 9 then begin
         C[i] := C[i] - 9;
      end;
      resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  if resto = 0 then begin
     resultado2 := 0;
  end else resultado2:= 10 - resto;

  result:= inttostr(resultado2);

end;

Function TLibBoletos.Asbace2_NossaCaixa: String;
var
A:array[1..24] of integer;
B:array[1..24] of integer;
C:Array[1..24] of integer;
sNossoNumero,numero,sConta,multiplicador: String;
resultado,resto,resultado2,d1: integer;
d2 : boolean;

procedure calculo();
var
i: integer;
begin
  if d2 = false then begin
     numero := sNossoNumero + copy(FAgencia,1,4) +  copy(FConta,2,1) + sConta + copy(Fbanco,1,3) + Asbace1_NossaCaixa;
  end else numero := sNossoNumero + copy(FAgencia,1,4) +  copy(FConta,2,1) + sConta + copy(Fbanco,1,3) + inttostr(d1);

  for i:= 1 to 24 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '765432765432765432765432';
  for i:=1 to 24 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 24 do begin   
      C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 24 do begin
    resultado:= resultado + C[i];
  end;
end;

begin
d2:= false;
sNossoNumero:= Format('%9.9d',[FNossoNumero]); //inttostr(FNossoNumero);
SConta:= trim(FConta);
delete(SConta,length(SConta),1);
delete(SConta,length(SConta),1);
SConta:= copy(right(SConta,6),1,6);
resultado2:=0;
  calculo();

    while d2 = false do begin
      resto:= resultado mod 11;
      if resto = 0 then begin
         resultado2 := 0;
         d2:= true;
      end else if resto > 1 then begin
                  resultado2:= 11 - resto;
                  d2:= true;
               end else if resto = 1 then begin
                   d1:= strtoint(Asbace1_NossaCaixa);
                   d1:= d1 + 1;
                   if d1 = 10 then begin
                      d1 := 0;
                   end;
                   d2:= true;
                   calculo();
                   d2:= false;
               end;
    end;
  result:= inttostr(resultado2);

end;

Function TLibBoletos.Retorno_Campo2_NossaCaixa: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,dac,dac2,sNossoNumero,campo2,sAgencia: String;
i,resultado,resto: integer;
begin
sAgencia:= copy(FAgencia,1,4);
sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
sNossoNumero:= Format('%9.9d',[Fnossonumero]);
numero := copy(sNossoNumero,6,4) + sAgencia + copy(FConta,2,1) + copy(FConta,4,1)  ;

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   if c[i] > 9 then begin
      c[i]:= c[i] - 9;
   end;
   resultado:= resultado + C[i];
  end;
  resultado := resultado *  9;
  resto:= resultado mod 10;
  dac:= inttostr(resto);
  dac2:=   numero + dac;
  campo2:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo2;

end;

Function TLibBoletos.Retorno_Campo3_NossaCaixa: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,dac,dac2,campo3: String;
i,resultado,resto: integer;
begin

numero := copy(FConta,5,5) + copy(Fbanco,1,3) + Asbace1_NossaCaixa + Asbace2_NossaCaixa;

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 10 do begin
   if c[i] > 9 then begin
      c[i]:= c[i] - 9;
   end;
   resultado:= resultado + C[i];
  end;
  resultado := resultado * 9;
  resto:= resultado mod 10;

  dac:= inttostr(resto);
  dac2:=   numero + dac;
  campo3:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo3;
end;

Function TLibBoletos.Retorno_Campo4_NossaCaixa: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,sNossoNumero,fatorvencimento,Sconta,sAgencia, valor: String;
i,resultado,resultado2,resto: integer;
begin
sAgencia:= copy(FAgencia,1,4);
sAgencia:= Format('%4.4d',[strtoint(sAgencia)]);
sNossoNumero:= Format('%9.9d',[FNossoNumero]);
SConta:= FConta;
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;

    numero:= copy(Fbanco,1,3) + '9' + fatorvencimento + valor + sNossoNumero +
             sAgencia + copy(SConta,2,1) + copy(SConta,4,6)   + copy(Fbanco,1,3) + 
             Asbace1_NossaCaixa + Asbace2_NossaCaixa;

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) or (resto = 10) or (resto = 11) then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  result:= dac;
end;

Function TLibBoletos.CodigoDeBarras_NossaCaixa: String;
var
numero,sNossoNumero,fatorvencimento,Sconta, valor: String;
begin
sNossoNumero:= Format('%9.9d',[FNossoNumero]);
SConta:= FConta;
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;

  numero:= copy(Fbanco,1,3) + '9' + Retorno_Campo4_NossaCaixa + fatorvencimento +
           valor + '9' + copy(sNossoNUmero,2,8) + copy(FAgencia,1,4) + copy(SConta,2,1) + copy(SConta,4,6)+
           copy(Fbanco,1,3) + Asbace1_NossaCaixa + Asbace2_NossaCaixa ;

  //codigobarras:= copy(numero,1,4) + Retorno_Campo4_NossaCaixa + copy(numero,5,39);

  result:= numero;
end;

Function TLibBoletos.Retorno_NossoNumero_Santander:String;
var
A:array[1..12] of integer;
B:array[1..12] of integer;
C:Array[1..12] of integer;

i, resultado,resto: integer;
numero,dac,dac2,sNossoNumero,multiplicador: string;
begin
sNossoNumero:= Format('%12.12d',[FNossoNumero]);

   numero:= sNossoNumero;

  for i:= 1 to 12 do begin
      A[i] := strtoint(numero[i]);
  end;
                  //'234567892345'
  multiplicador:= '543298765432';
  for i:=1 to 12 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 12 do begin
      C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 12 do begin
    resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) then begin
  dac:= '0';
  end else  dac:= inttostr(11 - resto);

  dac2:=  sNossoNumero + ' ' + dac;
  result:= dac2;

end;

Function TLibBoletos.Retorno_Campo1_Santander: String;
var
A:array[1..9] of integer;
B:array[1..9] of integer;
C:Array[1..9] of integer;
numero,dac,dac2,campo1,d: String;
i,resultado,resultado2,resto,e,f: integer;

begin
numero := copy(Fbanco,1,3) + '9' + '9' + copy(FCodigocedente,1,4);

  for i:= 1 to 9 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 2;
 B[02]:= 1;
 B[03]:= 2;
 B[04]:= 1;
 B[05]:= 2;
 B[06]:= 1;
 B[07]:= 2;
 B[08]:= 1;
 B[09]:= 2;


  {for i:= 1 to 9 do begin
     C[i]:= A[i] * B[i];
  end;   }
  
  resultado:=0;
  for i:= 1 to 9 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;

  for i:= 1 to 9 do begin
    resultado:= resultado + C[i];
  end;

 { for i:= 1 to 9 do begin
   if c[i] > 9 then begin
      c[i]:= c[i] - 9;
   end;
   resultado:= resultado + C[i];
  end;  }
  resto:= resultado mod 10;
  if resto = 0 then begin
     resultado2:= 0;
  end else begin
     resultado2:= 10 - resto;
  end;
  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo1:= copy(dac2,1,5) + '.' + copy(dac2,6,5);
  result:= campo1;
end;

Function TLibBoletos.Retorno_Campo2_Santander: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
numero,dac,dac2,campo2,sNossoNumero,d: String;
i,resultado,resultado2,resto,e,f: integer;

begin
sNossonumero := Format('%12.12d',[FNossoNumero]);;
numero := copy(FCodigoCedente,5,3) + copy(sNossonumero,1,7);

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  {for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
  end; }

  resultado:=0;
  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;
  {for i:= 1 to 10 do begin
   if c[i] > 9 then begin
      c[i]:= c[i] - 9;
   end;
   resultado:= resultado + C[i];
  end; }

  for i:= 1 to 10 do begin
     resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  if resto = 0 then begin
     resultado2:= 0;
  end else begin
     resultado2:= 10 - resto;
  end;

  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo2:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo2;
end;

Function TLibBoletos.Retorno_Campo3_Santander: String;
var
A:array[1..10] of integer;
B:array[1..10] of integer;
C:Array[1..10] of integer;
 numero,dac,dac2,campo3,SNossoNumero,d: String;
i,resultado,resultado2,resto,e,f: integer;

begin
SNossoNumero := Retorno_NossoNumero_Santander;
numero := copy(SNossoNumero,8,5) + copy(SNossoNumero,14,1)+ '0' + FCarteira;

  for i:= 1 to 10 do begin
      A[i] := strtoint(numero[i]);
  end;

 B[01]:= 1;
 B[02]:= 2;
 B[03]:= 1;
 B[04]:= 2;
 B[05]:= 1;
 B[06]:= 2;
 B[07]:= 1;
 B[08]:= 2;
 B[09]:= 1;
 B[10]:= 2;

  {for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
  end;}

  resultado:=0;
  for i:= 1 to 10 do begin
     C[i]:= A[i] * B[i];
     if C[i] > 9 then begin
        d:= inttostr(C[i]);
        e:= strtoint(d[1]);
        f:= strtoint(d[2]);
        C[i]:= e + f;
     end;
  end;
  {for i:= 1 to 10 do begin
   if c[i] > 9 then begin
      c[i]:= c[i] - 9;
   end;
   resultado:= resultado + C[i];
  end;}
  for i:= 1 to 10 do begin
     resultado:= resultado + C[i];
  end;

  resto:= resultado mod 10;
  if resto = 0 then begin
     resultado2:= 0;
  end else begin
     resultado2:= 10 - resto;
  end;

  dac:= inttostr(resultado2);
  dac2:=   numero + dac;
  campo3:= copy(dac2,1,5) + '.' + copy(dac2,6,6);
  result:= campo3;
end;

Function TLibBoletos.Retorno_Campo4_Santander: String;
var
A:array[1..43] of integer;
B:array[1..43] of integer;
C:Array[1..43] of integer;
numero,multiplicador,dac,fatorvencimento,valor,SNossoNumero: String;
i,resultado,resultado2,resto: integer;
begin
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;
SNossoNumero := Retorno_NossoNumero_Santander;
numero := copy(Fbanco,1,3) + '9' + fatorvencimento + valor + '9' +
          FCodigoCedente + copy(SNossoNumero,1,12) + copy(SNossoNumero,14,1) +
          '0' + FCarteira ;

  for i:= 1 to 43 do begin
      A[i] := strtoint(numero[i]);
  end;

  multiplicador:= '4329876543298765432987654329876543298765432';
  for i:=1 to 43 do begin
      B[i] := strtoint(multiplicador[i]);
  end;

  for i:= 1 to 43 do begin
     C[i]:= A[i] * B[i];
  end;

  resultado:=0;
  for i:= 1 to 43 do begin
   resultado:= resultado + C[i];
  end;

  resto:= resultado mod 11;
  if (resto = 0) or (resto = 1) or (resto = 10)  then begin
     dac:= '1';
  end else begin
       resultado2:= 11 - resto;
       dac:= inttostr(resultado2);
  end;
  result:= dac;
end;

Function TLibBoletos.CodigoDeBarras_Santander: String;
var
numero,fatorvencimento, valor,SNossoNumero: String;
begin
fatorvencimento:= DataVencimento;
valor:= TiraPontoeVirgula;
SNossoNumero := Retorno_NossoNumero_Santander;

  numero:= copy(Fbanco,1,3) + '9' + Retorno_Campo4_Santander + fatorvencimento + valor + '9' +
          FCodigocedente + copy(SNossoNumero,1,12) + copy(SNossoNumero,14,1) +
          '0' + FCarteira ;

  result:= numero;
end;

end.

