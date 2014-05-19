unit Calendario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, ExtCtrls;

type
  TdlgCalendario = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    sbClose: TSpeedButton;
    Calendario: TMonthCalendar;
    procedure sbCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure CalendarioDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgCalendario: TdlgCalendario;

implementation

{$R *.dfm}

procedure TdlgCalendario.sbCloseClick(Sender: TObject);
begin
   Close;
end;

procedure TdlgCalendario.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   If ( Key = 27 ) And ( Shift = [] ) Then begin
      Close;
   End;
end;

procedure TdlgCalendario.CalendarioDblClick(Sender: TObject);
begin
   Close;
end;

procedure TdlgCalendario.FormShow(Sender: TObject);
begin
   Calendario.Date := Date();
end;

end.
