unit DialogNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
    TdlgDialogNew = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  dlgDialogNew: TdlgDialogNew;

implementation

{$R *.DFM}

////////////////////////////////////////////////////
procedure TdlgDialogNew.FormCreate(Sender: TObject);
////////////////////////////////////////////////////
begin
   //
end;

/////////////////////////////////////////////////////////////
procedure TdlgDialogNew.WMSysCommand(var Msg: TWMSysCommand);
/////////////////////////////////////////////////////////////
Begin
   If ( Msg.CmdType = SC_MINIMIZE ) Then begin
      SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
   End else begin
      DefaultHandler(Msg);
   End;
End;

/////////////////////////////////////////////////////////////////////////////
procedure TdlgDialogNew.FormClose(Sender: TObject; var Action: TCloseAction);
/////////////////////////////////////////////////////////////////////////////
begin
   //
end;

end.
