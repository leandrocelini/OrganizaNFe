unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg;

type
  TfrmSplash = class(TForm)
    Label1: TLabel;
    lblMsg: TLabel;
    Logo: TImage;
    procedure FormCreate(Sender: TObject);
    Procedure Mensagem(Msg:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.DFM}

/////////////////////////////////////////////////
procedure TfrmSplash.FormCreate(Sender: TObject);
/////////////////////////////////////////////////
begin
   //verifica se existe arquivo de imagem de splash do usuário
   If ( FileExists('Splash.bmp') ) Then begin
      Logo.Picture.Bitmap.LoadFromFile('Splash.bmp');
      Logo.Parent.Refresh;
   End;
end;

//////////////////////////////////////////
Procedure TfrmSplash.Mensagem(Msg:String);
//////////////////////////////////////////
Begin
   frmSplash.lblMsg.Caption := Msg;
   frmSplash.Logo.Refresh;
End;

end.
