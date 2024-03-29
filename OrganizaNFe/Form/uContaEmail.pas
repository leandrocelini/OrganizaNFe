unit uContaEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogNew, mbKeyEvent, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls,
  db, mbFuncoes, ZAbstractRODataset, ZAbstractDataset, ZDataset, mbDialogo;

type
  TdlgContaEmail = class(TdlgDialogNew)
    dbEditEmail: TDBEdit;
    Label4: TLabel;
    Label3: TLabel;
    dbEditPorta: TDBEdit;
    Label1: TLabel;
    dbEditConta: TDBEdit;
    Label2: TLabel;
    dbEditSenha: TDBEdit;
    dsBuscaEmail: TDataSource;
    qrBuscaEmail: TZQuery;
    pRodape: TPanel;
    Panel2: TPanel;
    btnGravarConta: TBitBtn;
    btnCancelar: TBitBtn;
    panelCheckbox: TPanel;
    dbCheckConexaoSslPop3: TDBCheckBox;
    dbCheckExcluirAposRecebimento: TDBCheckBox;
    procedure btnGravarContaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    function buscaemail(email, emp: string): Boolean;

  private
    { Private declarations }
  public
    { Public declarations }
    acao: integer;
  end;

var
  dlgContaEmail: TdlgContaEmail;

implementation

uses uEmpresas, Data;

{$R *.dfm}

procedure TdlgContaEmail.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TdlgContaEmail.btnGravarContaClick(Sender: TObject);
begin
  // verifica se o email j� existe para a empresa selecionada na inser��o
  if buscaemail(dbEditEmail.Text, frmEmpresas.tbNewid_Empresa.AsString) and (acao = 0) then begin
      dbEditEmail.SetFocus;
      MessageDlg('Email j� cadastrado!!',mtInformation,[mbOk],0);
      Exit;
  end;

  // valida��es campos em brancos
  if not mbFuncoes.ValidaEMail(dbEditEmail.Text) then begin
    dbEditEmail.SetFocus;
    MessageDlg('Email inv�lido!!',mtInformation,[mbOk],0);
    Exit;
  end;

  if Length(dbEditPorta.Text) < 1 then begin
    dbEditPorta.SetFocus;
    MessageDlg('Favor preencher campo porta!!',mtInformation,[mbOk],0);
    Exit;
  end;

  if Length(dbEditConta.Text) < 1 then begin
    dbEditConta.SetFocus;
    MessageDlg('Favor preencher campo conta!!',mtInformation,[mbOk],0);
    Exit;
  end;

  if Length(dbEditSenha.Text) < 1 then begin
    dbEditSenha.SetFocus;
    MessageDlg('Favor preencher campo senha!!',mtInformation,[mbOk],0);
    Exit;
  end;

  if not dbCheckConexaoSslPop3.Checked and not dbCheckExcluirAposRecebimento.Checked then begin
    dbCheckConexaoSslPop3.SetFocus;
    MessageDlg('Voc� deve selecionar se o Pop Server e Ssl  com exclus�o ap�s recebimento!',mtInformation,[mbOk],0);
    Exit;
  end;

  if frmEmpresas.qrConta.State in [dsInsert, dsedit] then begin
    frmEmpresas.qrConta.Post;
  end;

  close;
end;

function TdlgContaEmail.buscaemail(email, emp: string): Boolean;
begin

  qrBuscaEmail.Active := False;
  qrBuscaEmail.ParamByName('email').AsString := email;
  qrBuscaEmail.ParamByName('emp').AsString := emp;
  qrBuscaEmail.Active := True;

  if qrBuscaEmail.RecordCount > 0 then begin
    Result := True;
  end
  else begin
    Result := False;
  end;
  qrBuscaEmail.close;
end;

procedure TdlgContaEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if frmEmpresas.qrConta.State in [dsInsert, dsedit] then begin
    frmEmpresas.qrConta.Cancel;
  end;
end;

procedure TdlgContaEmail.FormShow(Sender: TObject);
begin
  // verifica se inser��o
  if acao = 0 then begin
    frmEmpresas.qrConta.Append;
    // for�a checkbox a inicializar como false
    frmEmpresas.qrContaConexaoSslPop3.AsBoolean := False;
    frmEmpresas.qrContaExcluiAposRecebimento.AsBoolean := False;
  end
  else begin
    frmEmpresas.qrConta.Edit;
    // verifica se o checkbok inicializou checkado
    if not dbCheckConexaoSslPop3.Checked then begin
      // for�a checkbox a inicializar como false
      frmEmpresas.qrContaConexaoSslPop3.AsBoolean := False;
    end;
    // verifica se o checkbok inicializou checkado
    if not dbCheckExcluirAposRecebimento.Checked then begin
      // for�a checkbox a inicializar como false
      frmEmpresas.qrContaExcluiAposRecebimento.AsBoolean := False;
    end;
  end;
end;

end.
