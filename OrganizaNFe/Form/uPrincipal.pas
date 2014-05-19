unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PrincipalNew, ToolWin, ActnMan, ActnCtrls, ActnMenus, ComCtrls,
  ExtCtrls, ActnList, XPStyleActnCtrls, ImgList, ExtDlgs;

type
  TfrmPrincipal = class(TfrmPrincipalNew)
    Action: TActionManager;
    cadastroEmpresas: TAction;
    relatorios: TAction;
    finalizar: TAction;
    ImagemMenu: TImageList;
    ActionToolBar1: TActionToolBar;
    ActionToolBar2: TActionToolBar;
    baixaremails: TAction;
    config: TAction;
    procedure cadastroEmpresasExecute(Sender: TObject);
    procedure finalizarExecute(Sender: TObject);
    procedure baixaremailsExecute(Sender: TObject);
    procedure configExecute(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uEmpresas, ubaixaremails, Data, uConfig;


{$R *.dfm}


procedure TfrmPrincipal.baixaremailsExecute(Sender: TObject);
begin
   dlgBaixarEmails := TdlgBaixarEmails.Create(Application);
   frmEmpresas := TfrmEmpresas.Create(Application);

    Try
       frmEmpresas.tbNew.Open;
       frmEmpresas.qrConta.Open;
       dlgBaixarEmails.ShowModal;
    Finally

       FreeAndNil(dlgBaixarEmails);
       FreeAndNil(frmEmpresas);
    End;

end;

procedure TfrmPrincipal.cadastroEmpresasExecute(Sender: TObject);
begin
   frmEmpresas := TfrmEmpresas.Create(Application);

   Try
      frmEmpresas.ShowModal;
   Finally
      FreeAndNil(frmEmpresas);
   End;
end;

procedure TfrmPrincipal.configExecute(Sender: TObject);
begin
  inherited;

   dlgConfig := TdlgConfig.Create(Application);

    Try
       dlgConfig.ShowModal;
    Finally
       FreeAndNil(dlgConfig);
    End;
end;

procedure TfrmPrincipal.finalizarExecute(Sender: TObject);
begin
   Application.Terminate;
end;

end.
