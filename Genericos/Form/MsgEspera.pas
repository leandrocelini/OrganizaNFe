unit MsgEspera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Gauges, JvExComCtrls, JvProgressBar,
  JvExControls, JvAnimatedImage, JvGIFCtrl, JvTimer;

Procedure Msg(AtivaMsg:Boolean;Msg:String='';Animacao:Boolean=False;BloqueiaForm:Boolean=False);

type
  TTeste = class(TWinControl);
  TdlgMsgEspera = class(TForm)
    PMsg: TPanel;
    lblMsg: TLabel;
    Barra: TJvGIFAnimator;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    myForm:TForm;
    EnabledForm:Boolean;
    FormBloqueado:Boolean;
  public
    { Public declarations }
  end;

var
  dlgMsgEspera: TdlgMsgEspera;

implementation

{$R *.dfm}

/////////////////////////////////////////////////////////////////////
Procedure Msg(AtivaMsg:Boolean;Msg:String='';
              Animacao:Boolean=False;
              BloqueiaForm:Boolean=False);
/////////////////////////////////////////////////////////////////////
Var Control:TWinControl;
Begin
   If AtivaMsg Then begin
      If ( dlgMsgEspera = Nil ) Then begin
         dlgMsgEspera := TdlgMsgEspera.Create(Application);

         If BloqueiaForm Then begin
            dlgMsgEspera.myForm := Screen.ActiveForm;
            dlgMsgEspera.EnabledForm := Screen.ActiveForm.Enabled;
            dlgMsgEspera.myForm.Enabled := False;
            dlgMsgEspera.FormBloqueado := True;
         End else begin
            dlgMsgEspera.FormBloqueado := False;
         End;

         dlgMsgEspera.lblMsg.Caption := Msg;
         dlgMsgEspera.Width  := dlgMsgEspera.lblMsg.Width + 50;
         If Animacao Then begin
            dlgMsgEspera.Height := dlgMsgEspera.lblMsg.Height +
                                   dlgMsgEspera.Barra.Height + 20;
         End else begin
            dlgMsgEspera.Height := dlgMsgEspera.lblMsg.Height + 44;
         End;
         dlgMsgEspera.Barra.Visible := Animacao;
         dlgMsgEspera.Barra.Animate := True;

         dlgMsgEspera.Show;
         dlgMsgEspera.PMsg.Refresh;
         dlgMsgEspera.lblMsg.Refresh;
      End else begin
         If ( dlgMsgEspera.lblMsg.Caption = Msg ) Then begin
            dlgMsgEspera.Barra.Refresh;
            dlgMsgEspera.SetFocus;
         End else begin
            dlgMsgEspera.lblMsg.Caption := Msg;
            dlgMsgEspera.Width  := dlgMsgEspera.lblMsg.Width + 50;
            If Animacao Then begin
               dlgMsgEspera.Height := dlgMsgEspera.lblMsg.Height +
                                      dlgMsgEspera.Barra.Height + 20;
            End else begin
               dlgMsgEspera.Height := dlgMsgEspera.lblMsg.Height + 44;
            End;
            dlgMsgEspera.Barra.Visible := Animacao;
            dlgMsgEspera.PMsg.Refresh;
            dlgMsgEspera.lblMsg.Refresh;
         End;
      End;
   End else begin
      If ( dlgMsgEspera <> Nil ) Then begin
         If dlgMsgEspera.FormBloqueado Then begin
            dlgMsgEspera.myForm.Enabled := dlgMsgEspera.EnabledForm;
            dlgMsgEspera.myForm.SetFocus;
         End;

         Screen.ActiveControl.SetFocus;
         dlgMsgEspera.Close;
         dlgMsgEspera.Free;
         dlgMsgEspera := Nil;

         //Verifica o controle ativo
         Control := Screen.ActiveControl;

         //Se houver algum controle ativo volta o foco nele
         If ( Control <> Nil ) Then begin
            Screen.ActiveForm.DefocusControl(Control,False);
            If ( Control.Enabled ) Then begin
               Control.ControlState := [];
               Control.SetFocus;
            End;
         End;
      End;
   End;
End;

//////////////////////////////////////////////////
procedure TdlgMsgEspera.FormShow(Sender: TObject);
//////////////////////////////////////////////////
begin
   //dlgMsgEspera.PMsg.Refresh;
   //dlgMsgEspera.lblMsg.Refresh;
   //dlgMsgEspera.Width  := dlgMsgEspera.lblMsg.Width + 10;
   //dlgMsgEspera.Height := dlgMsgEspera.lblMsg.Height + 10;
end;

end.
