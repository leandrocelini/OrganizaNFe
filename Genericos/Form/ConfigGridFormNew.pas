unit ConfigGridFormNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogNew, StdCtrls, CheckLst, ExtCtrls, Buttons;

type
  TdlgConfigGridFormNew = class(TdlgDialogNew)
    clbColunasGrid: TCheckListBox;
    pMsg: TPanel;
    Imagem: TImage;
    lblPagamento: TLabel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgConfigGridFormNew: TdlgConfigGridFormNew;

implementation

uses FormNew;

{$R *.dfm}

end.
