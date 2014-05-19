unit PrincipalNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Grids, Buttons, ActnMan, ActnCtrls, ActnMenus,
  ActnList, StdActns, StdStyleActnCtrls, mbDialogo, mbFuncoes, ToolWin;

Function HtmlHelp(hwndCaller: THandle; pszFile: PChar; uCommand: cardinal; dwData: longint): THandle; stdcall; external 'hhctrl.ocx' name 'HtmlHelpA' ;

type
  TfrmPrincipalNew = class(TForm)
    BarraStatus: TStatusBar;
    ImagemFundo: TImage;
    Menu: TActionMainMenuBar;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ImgPaintCanvas(Canvas:TCanvas;Dado,Font:String;FontColor:TColor;
                             FontSize,Linha:Integer);
    procedure MenuClick(Sender: TObject);
  private
    { Private declarations }
  public
     { Public declarations }
     Gradiente:Boolean;
     Cor_Inicio:Integer;
     Cor_Final:Integer;
     Suporte:Boolean;
  end;

var
  frmPrincipalNew: TfrmPrincipalNew;

implementation

{$R *.DFM}

///////////////////////////////////////////////////////
procedure TfrmPrincipalNew.FormCreate(Sender: TObject);
///////////////////////////////////////////////////////
begin
   Application.HintPause := 200;
   Application.HintHidePause := 10000;
end;

//////////////////////////////////////////////////////////////////////////
procedure TfrmPrincipalNew.ImgPaintCanvas(Canvas:TCanvas;Dado,Font:String;
          FontColor:TColor;FontSize,Linha:Integer);
//////////////////////////////////////////////////////////////////////////
Var n,i,x,y:Integer;
Begin
   Canvas.Brush.Style := bsClear;
   Canvas.Font.Style := [fsBold];
   Canvas.Font.Name := Font;
   Canvas.Font.Size := FontSize;
   Canvas.Font.Color := FontColor;

   //Pega o tamenho do texto para calcular o centro
   n := round(Canvas.TextWidth(Dado)/2);
   i := round(Width/2);
   x := i-n;

   n := round(Canvas.TextHeight(Dado)/2);
   n := n+n;
   i := round(Height/2);

   If Linha = 1 Then begin
      y := i-n+15;
   End else begin
      y := i-15;
   End;

   Canvas.TextOut(x,y,Dado);
   Canvas.Font.Color := clGray;
   Canvas.TextOut(x-2,y-2,Dado);
   Canvas.Font.Color := clSilver;
   Canvas.TextOut(x-4,y-4,Dado);
   Canvas.Font.Color := FontColor;
   Canvas.TextOut(x-6,y-6,Dado);
End;

procedure TfrmPrincipalNew.MenuClick(Sender: TObject);
begin

end;

//////////////////////////////////////////////////////
procedure TfrmPrincipalNew.FormPaint(Sender: TObject);
//////////////////////////////////////////////////////
Var RGBDesde, RGBHasta, RGBDif:Array[0..2] of byte;  {Cores inicial e final - diferença de cores}
    Inicio, Final,Contador,Vermelho,Verde,Azul:Integer;
    Banda:TRect;                                     {Coordenadas do requadro a pintar}
    Factor:array[0..2] of shortint;                  {+1 se gradiente é crescente e -1 caso decrescente}

begin
   If Gradiente Then begin
      Inicio := ColorToRGB(Cor_Inicio);
      Final  := ColorToRGB(Cor_Final);

      RGBDesde[0]:=GetRValue(Inicio);
      RGBDesde[1]:=GetGValue(Inicio);
      RGBDesde[2]:=GetBValue(Inicio);

      RGBHasta[0]:=GetRValue(Final);
      RGBHasta[1]:=GetGValue(Final);
      RGBHasta[2]:=GetBValue(Final);

      //Calculo de RGBDif[] e factor[]
      for contador:=0 to 2 do begin
         RGBDif[contador] := Abs(RGBHasta[contador]-RGBDesde[contador]);
         If RGBHasta[contador] > RGBDesde[contador] then factor[contador] := 1 else factor[contador] := -1;
      End;

      Canvas.Pen.Style:=psSolid;
      Canvas.Pen.Mode:=pmCopy;

      Banda.Left  := 0;
      Banda.Right := Width;
      For contador := 0 to 255 do begin
         Banda.Top:=MulDiv(contador,height,256);
         Banda.Bottom:=MulDIv(contador+1,height,256);
         Vermelho:=RGBDesde[0]+factor[0]*MulDiv(contador,RGBDif[0],255);
         Verde:=RGBDesde[1]+factor[1]*MulDiv(contador,RGBDif[1],255);
         Azul:=RGBDesde[2]+factor[2]*MulDiv(contador,RGBDif[2],255);
         Canvas.Brush.Color:=RGB(Vermelho,Verde,Azul);
         Canvas.FillRect(Banda);
      end;
   End;
End;

///////////////////////////////////////////////////////
procedure TfrmPrincipalNew.FormResize(Sender: TObject);
///////////////////////////////////////////////////////
begin
   If Gradiente Then begin
      Invalidate;
   End;
end;

end.
